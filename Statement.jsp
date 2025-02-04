<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Time"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.bank.DAO.BankStatementUserDAOImpl"%>
<%@page import="com.bank.DAO.BankStatementUserDAO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.bank.model.BankUserDetails"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
BankUserDetails bankUserDetails = (BankUserDetails) session.getAttribute("userdetails");

if (bankUserDetails == null) {
    response.sendRedirect("login.jsp");
    return;
}
long accountNumber = bankUserDetails.getAccountnumber();
Connection connection = null;
List<String> transactions = new ArrayList<>();

try {
    connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/teca62projects?user=root&password=root");
    BankStatementUserDAO statementUserDAO = new BankStatementUserDAOImpl();
    statementUserDAO.setConnection(connection); // Set connection
    
    // Fetch statements from the database
    String sql = "SELECT Transaction_Type, Transaction_Amount, Transaction_Date, Transaction_Time, Balance_Amount FROM user_bank_statement WHERE Account_Number = ?";
    PreparedStatement ps = connection.prepareStatement(sql);
    ps.setLong(1, accountNumber);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        String transactionType = rs.getString("Transaction_Type");
        double transactionAmount = rs.getDouble("Transaction_Amount");
        Date transactionDate = rs.getDate("Transaction_Date");
        Time transactionTime = rs.getTime("Transaction_Time");
        double balance = rs.getDouble("Balance_Amount");

        transactions.add(transactionType + ": Rs. " + transactionAmount + " on " + transactionDate + " at " + transactionTime + " | Balance: Rs. " + balance);
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
%>

<center>
    <h2>Transaction Statement</h2>
    <table border="1">
        <tr>
            <th>Transaction Type</th>
            <th>Transaction Amount</th>
            <th>Transaction Date</th>
            <th>Transaction Time</th>
            <th>Balance Amount</th>
        </tr>
        <%
            for (String transaction : transactions) {
        %>
        <tr>
            <td><%= transaction.split(": ")[0] %></td>
            <td><%= transaction.split(": ")[1].split(" on ")[0] %></td>
            <td><%= transaction.split(" on ")[1].split(" at ")[0] %></td>
            <td><%= transaction.split(" at ")[1].split(" \\| ")[0] %></td>
            <td><%= transaction.split("\\| ")[1] %></td>
        </tr>
        <%
            }
        %>
    </table>
    <br>
    <a href="Home.jsp">Go back</a>
</center>
</body>
</html>