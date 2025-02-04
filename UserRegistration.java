package org.bank.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.bank.DAO.BankUserDAO;
import com.bank.DAO.BankUserDAOImpl;
import com.bank.model.BankUserDetails;
@WebServlet("/registration")
public class UserRegistration extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name=request.getParameter("name");
		String emailid=request.getParameter("email");
		String mobilenumber=request.getParameter("mb");
		long mobile=Long.parseLong(mobilenumber);
		String aadharnumber=request.getParameter("aadhar");
		long aadhar=Long.parseLong(aadharnumber);
		String address=request.getParameter("address");
		String pannumber=request.getParameter("pan");
		String amount=request.getParameter("amount");
		double money=Double.parseDouble(amount);
		String gender=request.getParameter("gender");
		
		BankUserDetails userDetails=new BankUserDetails();
		userDetails.setName(name);
		userDetails.setEmailid(emailid);
		userDetails.setMobilenumber(mobile);
		userDetails.setAadharnumber(aadhar);
		userDetails.setAddress(address);
		userDetails.setPan(pannumber);
		userDetails.setAmount(money);
		userDetails.setGender(gender);
		
		BankUserDAO dao=new BankUserDAOImpl();
	int bankUser=dao.insertBankUSerDetails(userDetails);
	PrintWriter printWriter=response.getWriter();
	response.setContentType("text/html");
		
		if(bankUser!=0) {
			
			RequestDispatcher dispatcher=request.getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response);
			printWriter.println("<center><h2>Registration successfull</h2></center>");
			
		}
		else
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher("UserRegis.jsp");
			dispatcher.include(request, response);
			printWriter.println("<center><h2>Server 404 Not Found...</h2></center>");
		}
	}
}
