<%@page import="java.sql.SQLException"%>
<%@page import="com.bank.DAO.BankStatementUserDAOImpl"%>
<%@page import="com.bank.DAO.BankStatementUserDAO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.bank.DAO.BankUserDAOImpl"%>
<%@page import="com.bank.DAO.BankUserDAO"%>
<%@page import="com.bank.model.BankUserDetails"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Credit Amount</title>
    <script>
        function showAlertAndRedirect(message) {
            alert(message);
            window.location.href = "Home.jsp"; // Redirect after alert
        }
    </script>
</head>
<body>
<%
BankUserDetails bankUserDetails = (BankUserDetails) session.getAttribute("userdetails");

if (bankUserDetails == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Handle credit transaction
String useramountString = request.getParameter("useramount");
String action = request.getParameter("action");

if ("credit".equals(action) && useramountString != null) {
    double useredamount = Double.parseDouble(useramountString);
    double balanceamount = bankUserDetails.getAmount() + useredamount;

    long useraccountnumber = bankUserDetails.getAccountnumber();
    BankUserDAO dao = new BankUserDAOImpl();
    
    Connection connection = null;

    try {
        connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/teca62projects?user=root&password=root");
        // Set the connection for DAO

        // Update user's balance
        int result = dao.updateamount(balanceamount, useraccountnumber);
        
        // Insert transaction statement
        BankStatementUserDAO statementUserDAO = new BankStatementUserDAOImpl();
        statementUserDAO.setConnection(connection); // Set the connection

        // Insert statement details
        boolean statementInserted = statementUserDAO.insertstatementDetails("Cr.", useredamount, useraccountnumber, balanceamount);

        // Check if the update was successful
        if (result > 0 && statementInserted)
        {
            String maskedAccountNumber = "****" + String.valueOf(useraccountnumber).substring(String.valueOf(useraccountnumber).length() - 4);
            String message = "A/c " + maskedAccountNumber + " credited for Rs: " + useredamount + ". Available Balance: Rs. " + balanceamount + ".";
            out.println("<script>showAlertAndRedirect('" + message + "');</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Log exception
    } finally {
        if (connection != null) {
            try {
                connection.close(); // Close connection
            } catch (SQLException closeEx) {
                closeEx.printStackTrace(); // Log close failure
            }
        }
    }
}
%>

<center>
    <h2>Credit Amount</h2>
    <form action="CreditAmount.jsp" method="post">
        <input placeholder="Enter Amount" name="useramount" type="number" required><br>
        <input type="hidden" name="action" value="credit">
        <br><br>
        <input type="submit" value="Credit">
    </form><br>
    <a href="Home.jsp">Go back</a>
</center>
</body>
</html>