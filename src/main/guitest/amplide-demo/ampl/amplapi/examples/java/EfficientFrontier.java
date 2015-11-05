

import java.io.IOException;

import com.ampl.AMPL;
import com.ampl.Objective;
import com.ampl.Parameter;
import com.ampl.Variable;

public class EfficientFrontier {

	public static void main(String[] args) {
		// Number of steps of the efficient frontier
		int steps = 10;
		// Use the provided path or the default one
		String modelDirectory = args.length > 0 ? args[0]
				: "../models";


		AMPL ampl = null;
		// Outer try-catch-finally block, to be sure of releasing the AMPL
		// object when done
		try {
			// Create AMPL object
			ampl= new AMPL();
			
			ampl.setBoolOption("reset_initial_guesses", true);
			ampl.setBoolOption("send_statuses", false);
			ampl.setOption("solver", "cplex");

			// Load the AMPL model from file
			ampl.read(modelDirectory + "/qpmv.mod");
			ampl.read(modelDirectory + "/qpmvbit.run");

			// Set tables directory (parameter used in the script above)
			ampl.getParameter("data_dir").set(modelDirectory);
			// Read tables
			ampl.readTable("assetstable");
			ampl.readTable("astrets");
			
			Variable portfolioReturn = ampl.getVariable("portret");
			Parameter averageReturn = ampl.getParameter("averret");
			Parameter targetReturn = ampl.getParameter("targetret");
			Objective deviation = ampl.getObjective("cst");

			
			ampl.eval("let stockopall:={};let stockrun:=stockall;");
			
			
			// Relax the integrality
			ampl.setBoolOption("relax_integrality", true);
			// Solve the problem
			ampl.solve();
			// Calibrate the efficient frontier range
			double minret = portfolioReturn.value();
			double maxret = findMax(averageReturn.getValues()
					.getColumnAsDoubles("val"));
			double stepsize = (maxret - minret) / steps;

			double[] returns = new double[steps];
			double[] deviations = new double[steps];

			for (int i = 0; i < steps; i++) {
				System.out.format("Solving for return = %f%n", maxret - (i - 1)
						* stepsize);
				// Set target return to the desired point
				targetReturn.setValues(maxret - (i - 1) * stepsize);
				ampl.eval("let stockopall:={};let stockrun:=stockall;");
				// Relax integrality
				ampl.setBoolOption("relax_integrality", true);
				ampl.solve();
				System.out.format("QP result = %f %n", deviation.value());
				// Adjust Included Stocks
				ampl.eval("let stockrun2:={i in stockrun:weights[i]>0};");
				ampl.eval("let stockrun:=stockrun2;");
				ampl.eval("let stockopall:={i in stockrun:weights[i]>0.5};");
				// Set integrality back
				ampl.setBoolOption("relax_integrality", false);
				ampl.solve();
				System.out.format("QMIP result = %f%n", deviation.value());
				// Store data of corrent frontier point
				returns[i] = maxret - (i - 1) * stepsize;
				deviations[i] = deviation.value();
			}

			// Display efficient frontier points
			System.out.format("%-8s  %-8s%n", "RETURN", "DEVIATION");
			for (int i = 0; i < returns.length; i++)
				System.out.format("%-6f  %-6f%n", returns[i], deviations[i]);
		} catch (IOException e) {
			throw new RuntimeException(e);
		} finally {
			ampl.close();
		}
	}

	private static double findMax(double[] array) {
		double max = Double.NEGATIVE_INFINITY;
		for (double d : array)
			if (d > max)
				max = d;
		return max;

	}
}
