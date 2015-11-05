

import java.io.IOException;
import java.util.Arrays;

import com.ampl.AMPL;
import com.ampl.Constraint;
import com.ampl.DataFrame;
import com.ampl.Objective;
import com.ampl.Parameter;
import com.ampl.Tuple;
import com.ampl.Variable;

public class LocationTransportation {
  public static void main(String[] args)  {
    AMPL ampl = new AMPL();
    try {
    	
		// Use the provided path or the default one
		String modelDirectory = args.length > 0 ? args[0]
				:  "../models";
		
      ampl.setOption("solver", "cplex");
      ampl.setBoolOption("presolve", false);
      ampl.setBoolOption("omit_zero_rows", true);

      // Read the model.
      ampl.read(modelDirectory + "/trnloc2.mod");
      ampl.readData(modelDirectory + "/trnloc.dat"); // TODO: set data programmatically
            
      // Get references to AMPL's model entities for easy access.
      Objective shipCost = ampl.getObjective("Ship_Cost");
      Variable maxShipCost = ampl.getVariable("Max_Ship_Cost");
      Variable buildVar = ampl.getVariable("Build");
      Constraint supply = ampl.getConstraint("Supply");
      Constraint demand = ampl.getConstraint("Demand");
      Parameter numCutParam = ampl.getParameter("nCUT");
      Parameter cutType = ampl.getParameter("cut_type");
      Parameter buildParam = ampl.getParameter("build");
      Parameter supplyPrice = ampl.getParameter("supply_price");
      Parameter demandPrice = ampl.getParameter("demand_price");
      
      numCutParam.set(0);
      maxShipCost.setValue(0);
      double[] initialBuild = new double[ampl.getSet("ORIG").size()];
      Arrays.fill(initialBuild, 1);
      buildParam.setValues(initialBuild);
      
      for (int numCuts = 1; ; numCuts++) {
        System.out.format("Iteration %d%n", numCuts);
        
        // Solve the subproblem.
        ampl.eval("solve Sub;");
        String result =shipCost.result() ; 
        if (result.equals("infeasible")) {
          // Add a feasibility cut.
          numCutParam.set(numCuts);
          cutType.set(numCuts, "ray");
          DataFrame dunbdd = supply.getValues("dunbdd");
          for (Object[] row: dunbdd)
            supplyPrice.set(new Tuple(row[0], numCuts), (Double)row[1]);
          dunbdd = demand.getValues("dunbdd");
          for (Object[] row: dunbdd)
            demandPrice.set(new Tuple(row[0], numCuts), (Double)row[1]);
        } else if (shipCost.value() > maxShipCost.value() + 0.00001) {
          // Add an optimality cut.
          numCutParam.set(numCuts);
          cutType.set(numCuts, "point");
          ampl.setIntOption("display_1col", 0);
          ampl.display("Ship");
          DataFrame duals = supply.getValues();
          for (Object[] row: duals)
            supplyPrice.set(new Tuple(row[0], numCuts), (Double)row[1]);
          duals = demand.getValues();
          for (Object[] row: duals)
            demandPrice.set(new Tuple(row[0], numCuts), (Double)row[1]);
        } else break;

        // Re-solve the master problem.
        System.out.println("RE-SOLVING MASTER PROBLEM");
        ampl.eval("solve Master;");

        // Copy the data from the Build variable used in the master problem
        // to the build parameter used in the subproblem.
        DataFrame data = buildVar.getValues();
        buildParam.setValues(data.getColumnAsDoubles("val"));
      }
      
      ampl.display("Ship");
    } catch (IOException e) {
		throw new RuntimeException(e);
	} 
    finally {
      ampl.close();
    }
  }
}
