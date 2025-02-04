<%@page import="java.sql.Connection"%>
<%@page import="com.bank.model.BankUserDetails"%>
<%@page import="com.bank.DAO.BankUserDAOImpl"%>
<%@page import="com.bank.DAO.BankUserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.bank.DAO.AdminDAOImpl"%>
<%@page import="com.bank.DAO.AdminDAO"%>
<html>
<body>
<center>
<h2 style="color: red">Bank Management System</h2>
<br>
</center>

<%-- <center>

<%=adminemail %>
<%=adminpassword %>

</center> --%>
<br>

<!-- User Login -->
<div style="margin: 0; display: flex; justify-content: center; align-items: center;">

<div style="width: 200px; height: 200px; display: flex; justify-content: center; align-items: center;">
<center>
<h3 style="color: green">User Login</h3>

<form action="index.jsp" method="post">
<input type="text" placeholder="Enter Your Emailid" name="email" required>
<br><br>
<input placeholder="Enter Your Password" name="password" required>
<br><br>
<input type="submit" value="LOGIN">
</form>
</center>
</div>


<!-- Admin Login -->

<div style="width: 200px; height: 200px; display: flex; justify-content: center; align-items: center;">
<center>
<h3 style="color: green">Admin Login</h3>


<form action="index.jsp">
<input placeholder="Enter Your Emailid" name="adminemail">
<br><br>
<input placeholder="Enter Your Password" name="adminpassword">
<br><br>
<input type="submit" value="LOGIN">
</form>
</center>
</div>

<%-- <%!String msg=null;%>
<% if(msg != null)
{
%>
 <%= msg %>
<% } %> --%>

<%!
String msg=null;
String umsg=null;
%>
<%
String adminemail=request.getParameter("adminemail");
String adminpassword=request.getParameter("adminpassword");

if(adminemail != null && adminpassword != null)
{
AdminDAO adminDAO=new AdminDAOImpl();

    if(adminDAO.adminlogin(adminemail, adminpassword))
   {
	RequestDispatcher dispatcher=request.getRequestDispatcher("Details.jsp");
	dispatcher.forward(request, response);
	return;
    }
    else
   {	
    msg="Invalid email or password!";
    /* request.setAttribute("msg", msg); */ 
	/* RequestDispatcher dispatcher=request.getRequestDispatcher("index.jsp");
	dispatcher.forward(request, response);
	return; */
    }
}
%>

</div>

<br><br>
<center>

<a href="UserRegis.jsp">New Account...?</a>&nbsp &nbsp
<a href="">Forget password...?</a>


<% 
if (msg != null) { %>
    <p style="color: red;"><%= msg %></p>
<% } %>


<%

String useremailid=request.getParameter("email");
String userpassword=request.getParameter("password");

if(useremailid!=null && userpassword!=null)
{
	Connection connection;
	int pin=Integer.parseInt(userpassword);
	BankUserDAO dao=new BankUserDAOImpl();
    BankUserDetails details=dao.userLogin(useremailid,pin);
    if(details!=null)
	{
    	session.setAttribute("userdetails", details);
		RequestDispatcher dispatcher=request.getRequestDispatcher("Home.jsp");
		dispatcher.forward(request, response);
	}
	else
	{
		umsg="Invalid data";
	}
} %>


</center>
</body>
</html>
