<%@page import="org.eclipse.jdt.internal.compiler.ast.ForeachStatement"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.bank.model.BankUserDetails"%>
<%@page import="java.util.List"%>
<%@page import="com.bank.DAO.BankUserDAOImpl"%>
<%@page import="com.bank.DAO.BankUserDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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

<h2>Search User Details</h2>
<form action="AllUserDetails.jsp" method="get">

<input type="text" name="query" placeholder="search any field">
<input type="submit" value="search">

</form>
<br><br>
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

String query=request.getParameter("query");

BankUserDAO bankUserDAO=new BankUserDAOImpl();
List<BankUserDetails> allUserDetails=bankUserDAO.allUserDetails();

boolean found=false;

for (BankUserDetails bankUserDetails:allUserDetails) {
boolean match=false;

Long mobileNumber = bankUserDetails.getMobilenumber();
Long aadharNumber = bankUserDetails.getAadharnumber();

if(bankUserDetails.getStatus().equalsIgnoreCase("Active")) {
	 
	if(query !=null && !query.isEmpty()) {
	
	String lowerQuery=query.toLowerCase();
	
	String mobileNumberStr = (mobileNumber != null) ? mobileNumber.toString() : "";
    String aadharNumberStr = (aadharNumber != null) ? aadharNumber.toString() : "";

	
    	if ((bankUserDetails.getName() != null && bankUserDetails.getName().toLowerCase().contains(lowerQuery)) ||
            (bankUserDetails.getEmailid() != null && bankUserDetails.getEmailid().toLowerCase().contains(lowerQuery)) ||
            mobileNumberStr.contains(lowerQuery) ||  
            aadharNumberStr.contains(lowerQuery) ||
            (bankUserDetails.getPan() != null && bankUserDetails.getPan().toLowerCase().contains(lowerQuery)) ||
            (bankUserDetails.getAddress() != null && bankUserDetails.getAddress().toLowerCase().contains(lowerQuery)) ||
            (bankUserDetails.getGender() != null && bankUserDetails.getGender().toLowerCase().contains(lowerQuery))
            ) {
            match = true;
        	}
		}
	else {
	
	match=true;
		}
}
	if(match) {
	found=true;

%>

<tr>
<td><%=bankUserDetails.getName() %></td>
<td><%=bankUserDetails.getEmailid() %></td>
<td><%= bankUserDetails.getMobilenumber()%></td>
<td><%=bankUserDetails.getAadharnumber() %></td>
<td><%=bankUserDetails.getPan() %></td>
<td><%=bankUserDetails.getAddress() %></td>
<td><%=bankUserDetails.getGender() %></td>
<td><%=bankUserDetails.getStatus() %></td>
</tr>
<%
}
}
 if(!found){
%>
<tr>
    <td colspan="7" style="text-align: center;">No results found for "<%= query !=null ? query: ""%>"</td>
</tr>
<%
 }  
%>
</table>
</center>
</body>
</html>