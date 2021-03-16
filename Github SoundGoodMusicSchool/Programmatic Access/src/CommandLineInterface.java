import java.util.Scanner;

public class CommandLineInterface
{

    private boolean isRunning = true;

    private Scanner console = new Scanner(System.in);

    public CommandLineInterface()
    {
        commandLine();
    }

    public void stopCommandLine()
    {
        isRunning = false;
    }

    public void commandLine()
    {
        //Enable the program running.
        isRunning = true;

        //Establish server connection.
        ServerAccess.databaseConnection();

        //Enable an infinite loop in order to perpetually receive input commands.
        while(isRunning)
        {
            try
            {

                System.out.println("# Please Enter a prompt");
                //Initialize the input scanner by reading the next line.
                CmdLine cmdLine = new CmdLine(console.nextLine());

                switch(cmdLine.getCmd())
                {

                    case LIST:
                        System.out.println("Listing all instruments available of type.");

                        //Run the function from the server access class.
                        ServerAccess.listInstruments( cmdLine.getParameter(0) );

                        break;
                    case RENT:
                        System.out.println("Renting an instrument for a student.");

                        //Run the function from the server access class.
                        ServerAccess.rentInstrument( Integer.parseInt(cmdLine.getParameter(0)),
                                Integer.parseInt(cmdLine.getParameter(1)),
                                Integer.parseInt(cmdLine.getParameter(2)),
                                cmdLine.getParameter(3) );

                        break;
                    case TERMINATE:
                        System.out.println("Terminating a rental for a student.");

                        ServerAccess.terminateRental( Integer.parseInt(cmdLine.getParameter(0)),
                                Integer.parseInt(cmdLine.getParameter(1)),
                                Integer.parseInt(cmdLine.getParameter(2)));

                        break;
                    case QUIT:
                        System.out.print("Quitting...");
                        stopCommandLine();
                        break;

                    default:
                        System.out.println("Illegal Command");

                }
            }
            catch(Exception e)
            {
                System.out.println("Operation failed");
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }

    }

    public static void main(String[] args)
    {
        CommandLineInterface cli = new CommandLineInterface();
    }

}
