<%@page import="com.bank.DAO.BankStatementUserDAOImpl"%>
<%@page import="com.bank.DAO.BankStatementUserDAO"%>
<%@page import="java.sql.*"%>
<%@page import="com.bank.model.BankUserDetails"%>
<%@page import="com.bank.DAO.BankUserDAOImpl"%>
<%@page import="com.bank.DAO.BankUserDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Debit Transaction</title>
    <script>
        function showAlertAndRedirect(maskedAccountNumber, useredamount, balanceamount) {
            // Show alert message
            alert('A/c ' + maskedAccountNumber + ' debited for Rs: ' + useredamount + '. Available Balance: ' + balanceamount + '.');
            // Redirect to Home.jsp after alert is closed
            window.location.href = "Home.jsp";
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

// Retrieve parameters from the request
String uaccountnumber = request.getParameter("accountnumber");
String useramountString = request.getParameter("useramount");

if (uaccountnumber != null && useramountString != null) {
    long useraccountnumber = Long.parseLong(uaccountnumber);
    double useredamount = Double.parseDouble(useramountString);

    // New balance calculation
    double balanceamount = bankUserDetails.getAmount() - useredamount;

    if (bankUserDetails.getAccountnumber() == useraccountnumber) {
        Connection connection = null;

        try {
            connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/teca62projects?user=root&password=root");
            
            // Update user's balance
            BankUserDAO dao = new BankUserDAOImpl();
            int result = dao.updateamount(balanceamount, useraccountnumber);

            // Insert transaction statement
            BankStatementUserDAO statementUserDAO = new BankStatementUserDAOImpl();
            statementUserDAO.setConnection(connection); // Set the connection

            // Now try inserting the statement
            boolean statementInserted = statementUserDAO.insertstatementDetails("Dr.", useredamount, useraccountnumber, balanceamount);
            if (result > 0 && statementInserted) {
            	
            	String maskedAccountNumber = "****" + String.valueOf(useraccountnumber).substring(String.valueOf(useraccountnumber).length() - 4);
                // Redirect on success
                bankUserDetails.setAmount(balanceamount);
                session.setAttribute("userdetails", bankUserDetails);
                out.println("<script>showAlertAndRedirect('" + maskedAccountNumber + "', " + useredamount + ", " + balanceamount + ");</script>");
                //response.sendRedirect("Home.jsp");
            } else {
                out.println("<script>alert('Transaction failed. Unable to update balance or insert statement.');</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log exception
        } finally {
            // Ensure connection is closed
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace(); // Log close failure
                }
            }
        }

    }
}
%>

<center>
    <h2>Debit Transaction</h2>
    <form action="DebitAmount.jsp" method="post">
        <input placeholder="Enter Amount" name="useramount" type="number" required>
        <br>
        <input placeholder="Enter Account Number" required="required" name="accountnumber">
        <br><br>
        <input type="submit" value="Submit">
    </form>
</center>

</body>
</html>
