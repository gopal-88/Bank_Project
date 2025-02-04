<%@page import="com.bank.model.BankUserDetails"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e9ecef; /* Light grey background */
            font-family: Arial, sans-serif; /* Font style */
        }
        .welcome-card {
            background-color: #fff; /* White background for the card */
            padding: 20px; /* Padding around the content */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            margin: 20px; /* Margin around the card */
            text-align: center; /* Center text */
        }
        .profile-container {
            display: flex; /* Use flexbox for alignment */
            justify-content: flex-end; /* Align items to the right */
            align-items: center; /* Center items vertically */
            margin-bottom: 20px; /* Space below profile section */
        }
        .profile-icon {
            width: 40px; /* Width of the profile icon */
            height: 40px; /* Height of the profile icon */
            border-radius: 50%; /* Circular icon */
            margin-right: 10px; /* Space to the right of the icon */
        }
        .btn {
            width: 65%; /* Full width of the button */
            margin: 5px 0; /* Margin for buttons */
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
%>

<!-- Main Container -->
<div class="container d-flex justify-content-center align-items-center" style="height: 80vh;">
    <div class="welcome-card col-md-4"> <!-- Medium-sized box -->
        
        <!-- Profile Section -->
        <div class="profile-container">
            <img src="path/to/profile-icon.png" alt="Profile Icon" class="profile-icon"> <!-- Replace with your icon path -->
            <span>Hello, <%= bankUserDetails.getName() %>!</span>
        </div>

        <h5>Welcome to the Bank Portal</h5> <!-- Welcome message -->
        
        <a href="CreditAmount.jsp"><button class="btn btn-primary">Credit</button></a>
        <a href="CheckBalance.jsp"><button class="btn btn-success">Check Balance</button></a>
        <a href="DebitAmount.jsp"><button class="btn btn-secondary">Debit</button></a>
        <a href="Statement.jsp"><button class="btn btn-info">Statement</button></a>
    </div>
</div>
<!-- Optional Bootstrap JS and dependencies (if needed) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</body>
</html>