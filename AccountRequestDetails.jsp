<%@page import="com.bank.model.BankUserDetails"%>
<%@page import="java.util.List"%>
<%@page import="com.bank.DAO.BankUserDAOImpl"%>
<%@page import="com.bank.DAO.BankUserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<h1>Pending Account Requests</h1>
<table border="1">
<tr>
<th>Name</th>
<th>Email Id</th>
<th>Mobile Number</th>
<th>Aadhar Number</th>
<th>Pan Number</th>
<th>Address</th>
<th>Gender</th>
<th>Status</th>
</tr>
<%
BankUserDAO bankUserDAO=new BankUserDAOImpl();
List<BankUserDetails> allBankUserDetails=bankUserDAO.allUserDetails();
for (BankUserDetails bankUserDetails: allBankUserDetails) {
	
if("pending".equalsIgnoreCase(bankUserDetails.getStatus())) {
%>
<tr>
<td><%=bankUserDetails.getName() %></td>
<td><%=bankUserDetails.getEmailid() %></td>
<td><%=bankUserDetails.getMobilenumber() %></td>
<td><%=bankUserDetails.getAadharnumber() %></td>
<td><%=bankUserDetails.getPan() %></td>
<td><%=bankUserDetails.getAddress() %></td>
<td><%=bankUserDetails.getGender() %></td>
<td><%=bankUserDetails.getStatus() %></td>
<td>
<form action="updatedetails" method="post">
<input value=<%=bankUserDetails.getId() %> hidden="true" name="id">
<input type="submit" value="Accept">
</form>
</td>
</tr>
<%
}
}
%>
</table>
</center>
</body>
</html>