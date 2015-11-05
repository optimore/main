

import com.ampl.AMPL;
import com.ampl.Parameter;
import com.ampl.Variable;
import com.ampl.DataFrame;

public class Test {

    static final boolean DEBUG = true;

    public static void main(String[] args) {

	/*
	 * AMPL.printDebugInformation(true); AMPL ampl = new AMPL();
	 * ampl.eval("var x := 42;"); Variable v = ampl.getVariable("x");
	 * v.get().value(); System.out.println(ampl.cd());
	 */
	//profile();
        DietModel.main(new String[]{"target/classes/models/diet"});

    }
    
    

    private static void profile() {
	AMPL ampl = new AMPL();
	ampl.eval("include Italcementi2014_2stage_LoadModelDataAndTables.run;");
	ampl.solve();

	DataFrame df = ampl
		.getData("{j in DEST, i in SUPPL, k in PLANT[i], n in CHILDREN} Used_Vehicles[i,k,j,n]");

	ampl.close();

	System.out.println(df.getNumRows());
	System.out.println("Finished");
	System.out.println(df.getNumRows());
	System.out.println(df.toString());
    }

    static double test() {
    	AMPL ampl = null;
	try {

	    if (DEBUG)
		System.out.println("Attempting to start AMPL");
	    // Create an AMPL instance
	    ampl = new AMPL();
	    if (DEBUG)
		System.out.println("After AMPL Constructor");

	    if (!ampl.isRunning())
		return -1;

	    ampl.eval("param c default 1.5;");
	    Parameter c = ampl.getParameter("c");

	    return c.getValues().getColumnAsDoubles(c)[0];
	} catch (Exception e) {
	    if (DEBUG)
		System.out.println("Exception caught: " + e.getMessage());
	    return -1;
	}
	finally{
		if (ampl != null)
			ampl.close();
	}
    }

    static void another() {
	// Create a new dataframe with one indexing column (A) and another
	// column (c)
	DataFrame df = new DataFrame(1, "A", "c");
	for (int i = 1; i <= 1000; i++)
	    df.addRow(i, i * 1.1);

	AMPL ampl = new AMPL();
	try {
	    ampl.eval("set A;" + "param c{i in A} default 0;"
		    + "var x{i in A} := c[i];");
	    // Assign data to the set A and the parameter c in one line
	    ampl.setData(df, "A");
	    // Get the variable x
	    Variable x = ampl.getVariable("x");
	    // From the following line onwards, df is uncoupled from the
	    // modelling system,
	    df = x.getValues();

	} finally {
	    ampl.close();
	}
	// Enumerate through all the instances and print their values
	for (Object[] row : df)
	    System.out.format("%f %f%n", row[0], row[1]);

    }
}