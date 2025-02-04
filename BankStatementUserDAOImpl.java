package com.bank.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

public class BankStatementUserDAOImpl implements BankStatementUserDAO {
    
    // Database URL and SQL Insert statement
    private static final String url = "jdbc:mysql://127.0.0.1:3306/teca62projects?user=root&password=root";
    private static final String insert = 
        "INSERT INTO user_bank_statement (Transaction_Type, Transaction_Amount, Transaction_Date, Transaction_Time, Account_Number, Balance_Amount) VALUES (?, ?, ?, ?, ?, ?)";
    
    private Connection connection; // This will hold the connection

    // Method to set the connection
    public void setConnection(Connection connection)
    {
    	this.connection=connection;
    }

    @Override
    public boolean insertstatementDetails(String transactiontype, double transactionamount, long accountnumber, double balanceamount) {
        try (PreparedStatement ps = connection.prepareStatement(insert)) {
            ps.setString(1, transactiontype);
            ps.setDouble(2, transactionamount);
            ps.setDate(3, Date.valueOf(LocalDate.now()));
            ps.setTime(4, Time.valueOf(LocalTime.now()));
            ps.setLong(5, accountnumber); // Ensure this value is valid
            ps.setDouble(6, balanceamount);

            // Log the values for debugging
            System.out.println("Inserting Statement: " +
                "Type: " + transactiontype + ", " +
                "Amount: " + transactionamount + ", " +
                "Account Number: " + accountnumber + ", " +
                "Balance Amount: " + balanceamount);

            int result = ps.executeUpdate();
            return result > 0; // Return true if insert was successful
        } catch (SQLException e) {
            e.printStackTrace(); // Log the error for debugging
            return false; // Return false on error
        }
    }

}
