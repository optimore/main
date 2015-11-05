

import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;

import com.ampl.AMPLException;
import com.ampl.LicenseException;

public class App {
    static int nExamples = 9;
    static Console console;

    public static int getNexamples() {
	return nExamples;
    }

    public static void main(String[] args) throws LicenseException,
	    AMPLException {
	Test.another();

	console = System.console();
	int choiche = 0;
	while (true) {
	    choiche = askExample();

	    if (choiche == -1)
		continue;

	    if (choiche == 0)
		break;

	    runExample(choiche);
	}
	System.out.println("Bye...");
    }

    static int askExample() {
	String input = null;
	System.out.println("AMPL API Examples");
	System.out.println("1) First example");
	System.out.println("2) Efficient frontier");
	System.out.println("3) Async example");
	System.out.println("4) Options example");
	System.out.println("5) DataFrame example");
	System.out.println("6) DataFrame Multidimensional example");
	System.out.println("7) Diet model example");
	System.out.println("8) Tracking model example");
	System.out.println("9) Benders example");
	System.out.print("\nChoose which example to run (0 exits): ");

	BufferedReader bufferedReader = new BufferedReader(
		new InputStreamReader(System.in));
	try {
	    input = bufferedReader.readLine();
	} catch (IOException e1) {
	    return 0;
	}

	try {
	    int read = Integer.parseInt(input);
	    if ((read < 0) || (read > nExamples))
		return -1;
	    return read;
	} catch (NumberFormatException e) {
	    return -1;
	}
    }

    public static void runExample(int number) {
    	
	switch (number) {
	case 1:
	    FirstExample.main(new String[]{"target/classes/models/diet"});
	    break;
	case 2:
	    EfficientFrontier.main(new String[]{"target/classes/models/qpmv"});
	    break;
	case 3:
	    AsyncExample.main(new String[]{"target/classes/models/qpmv"});
	    break;
	case 4:
	    OptionsExample.main(new String[]{"target/classes/models/diet"});
	    break;
	case 5:
	    DataFrameExample.main(new String[]{"target/classes/models/diet"});
	    break;
	case 6:
	    MultiDimensionalExample.main(new String[]{"target/classes/models/diet"});
	    break;
	case 7:
	    DietModel.main(new String[]{"target/classes/models/diet"});
	    break;
	case 8:
	    TrackingModel.main(new String[]{"target/classes/models/tracking"});
	    break;
	case 9:
	    LocationTransportation.main(new String[]{"target/classes/models/locationtransportation"});
	    break;

	}
    }

}
