<%@page import="com.bank.model.BankUserDetails"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Balance</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f9;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
            max-width: 600px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
        }
        .balance-box {
            border: 1px solid #007bff;
            border-radius: 5px;
            padding: 20px;
            background-color: #e7f1ff;
        }
        .balance-box h3 {
            margin-bottom: 10px;
        }
        .btn {
            margin-top: 20px;
            width: 100%;
        }
    </style>
</head>
<body>
<%
BankUserDetails bankUserDetails = (BankUserDetails) session.getAttribute("userdetails");

if (bankUserDetails == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Display the balance
String accountNumber = String.valueOf(bankUserDetails.getAccountnumber());
String name = bankUserDetails.getName();
double availableBalance = bankUserDetails.getAmount();
%>

<div class="container">
    <div class="balance-box">
        <h3>Account Balance</h3>
        <p>Your account number: <strong><%= accountNumber %></strong></p>
        <p>Your name: <strong><%= name %></strong></p>
        <p>Your available balance: <strong>Rs. <%= availableBalance %></strong></p>
    </div>
    <a href="Home.jsp" class="btn btn-primary">Go back</a>
</div>

</body>
</html>