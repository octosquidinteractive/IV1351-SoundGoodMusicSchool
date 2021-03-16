import javax.xml.transform.Result;
import java.sql.*;

public class ServerAccess
{

    private static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/SoundGoodMusicSchoolDB?user=admin&password=admin";

    public static Connection connection = null;

    public static void listInstruments(/*Connection connection, */String instrument_type) throws SQLException
    {
        PreparedStatement statement = connection.prepareStatement
                (
                        "SELECT * " +
                                "FROM instrument_rent JOIN rental " +
                                "ON instrument_rent.instrument_id = rental.instrument_id " +
                                "WHERE instrument_rent.instrument_type = '" + instrument_type + "' AND " +
                                "instrument_rent.instrument_id NOT IN " +
                                "( " +
                                    "SELECT rental.instrument_id " +
                                    "FROM rental " +
                                    "WHERE " +
                                        "rental.student_id IS NOT NULL AND " +
                                        "returned IS NOT TRUE " +
                                ")"
                );

        ResultSet instruments = statement.executeQuery();

        //Iterates over the instrument tables using an INTERNAL CURSOR. True if there is a next row, false if there is not.
        while(instruments.next())
            System.out.println(
              "Type: " + instruments.getString(5) + " " +
                      "Brand: " + instruments.getString(3) + " " +
                      "Model: " + instruments.getString(4) + " " +
                      "Price: " + instruments.getString(7) + " " +
                      "Rental ID: " + instruments.getString(6) + " " +
                      "Instrument ID: " + instruments.getString(11)
            );

        System.out.println("SUCCESS!");
    }

    public static void rentInstrument(int studentId, int instrumentId, int rentalId, String rentTo) throws SQLException
    {

        try
        {

            //Returns a table containing the count amount of the instruments currently rented by a student.
            PreparedStatement thresholdCheck = connection.prepareStatement
                    (
                            "SELECT COUNT(*) " +
                                    "FROM rental " +
                                    "WHERE " +
                                    "student_id = " + studentId + " AND " +
                                    "returned IS NOT TRUE"
                    );

            //Run and save the result of the query.
            ResultSet threshold = thresholdCheck.executeQuery();

            //Iterate the internal cursor, once.
            threshold.next();

            //Check if the student has already rented more instruments than what is allowed. Exit if true.
            if (threshold.getInt(1) >= 2)
            {
                System.out.print("The student is already renting two instruments.");
                return;
            }

            //Prepare an UPDATE statement.
            PreparedStatement rent = connection.prepareStatement
                    (
                            //"START TRANSACTION; " +
                            "UPDATE rental " +
                                    "SET " +
                                    "student_id = " + studentId +
                                    ", duration = '" + rentTo + "'" +
                                    ", returned = FALSE" +
                                    ", date = CURRENT_DATE()" +
                                    "WHERE " +
                                    "instrument_id = " + instrumentId + " AND " +
                                    "rental_id = " + rentalId
                            //"COMMIT;"
                    );

            //Run the update and commit the changes.
            rent.executeUpdate();
            connection.commit();

            System.out.println("SUCCESS!");
        }
        catch(SQLException e)
        {
            //If fail:
            //Print stack trace,
            //Roll back the changes made.
            e.printStackTrace();
            connection.rollback();
        }
    }

    public static void terminateRental(int studentId, int rentId, int instrumentId) throws SQLException
    {

        try
        {

            //Fetch a table containing the instrument in order to extract the data for re-insertion.
            PreparedStatement dataCheck = connection.prepareStatement
                    (
                            "SELECT price " +
                                    "FROM rental " +
                                    "WHERE instrument_id = " + instrumentId + " AND " +
                                    "student_id = " + studentId + " AND " +
                                    "returned IS FALSE"
                    );

            //Run and save the query.
            ResultSet rental = dataCheck.executeQuery();

            //Iterate the counter.
            rental.next();

            //Save the price of the instrument into a temporary variable. But parse it from string to int
            int tempPrice = Integer.parseInt(rental.getString(1));

            //Terminate the rental by setting the returned boolean to true.
            PreparedStatement terminate = connection.prepareStatement
                    (
                            "UPDATE rental " +
                                    "SET " +
                                    "duration = CURRENT_DATE(), returned = TRUE " +
                                    "WHERE " +
                                    "student_id = " + studentId + " AND " +
                                    "rental_id = " + rentId
                    );



            //Run the update and commit the changes.
            terminate.executeUpdate();

            //Creates a new rental object to allow rentals of the instrument from another student.
            PreparedStatement newRentalObject = connection.prepareStatement
                    (
                            "INSERT INTO " +
                                    "rental" +
                                    "(rental_id, price, delivery_address, date, duration, instrument_id, student_id, bill_id, returned)" +
                                    "VALUES (0, " + tempPrice + ", NULL, NULL, NULL," +  instrumentId + ", NULL, NULL, FALSE)"
                    );

            //Run the update.
            newRentalObject.executeUpdate();

            connection.commit();

            System.out.println("SUCCESS!");
        }
        catch(SQLException e)
        {
            //If fail:
            //Print stack trace,
            //Roll back the changes made.
            e.printStackTrace();
            connection.rollback();
        }
    }

    public static void databaseConnection()
    {
        System.out.println("ATTEMPTING TO ESTABLISH CONNECTION TO DATABASE");

        try
        {
            //Register the JDBC driver.
            //Class.forName(JDBC_DRIVER);

            //Establish a connection to the DB.
            connection = DriverManager.getConnection(DB_URL);
            connection.setAutoCommit(false);
        }
        catch (SQLException/* | ClassNotFoundException*/ e)
        {
            e.printStackTrace();
        }

        System.out.println("CONNECTION TO THE DATABASE ESTABLISHED");

        //END DB ACCESS.

        /*try
        {
            listInstruments(connection, "Guitar");
        } catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }*/
    }


    //Commented out in order to allow for integration with the CLI. Will be split into further methods.
    /*public static void main(String[] args)
    {


        //START DB ACCESS:

        Connection connection = null;

        System.out.println("ATTEMPTING TO ESTABLISH CONNECTION TO DATABASE");

        try
        {
            //Register the JDBC driver.
            //Class.forName(JDBC_DRIVER);

            //Establish a connection to the DB.
            connection = DriverManager.getConnection(DB_URL);
            connection.setAutoCommit(false);
        }
        catch (SQLException/* | ClassNotFoundException*/ /*e)
        {
            e.printStackTrace();
        }

        System.out.println("CONNECTION TO THE DATABASE ESTABLISHED");

        //END DB ACCESS.

        /*try
        {
            listInstruments(connection, "Guitar");
        } catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }*/

    //}
}
