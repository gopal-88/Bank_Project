package org.bank.controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.DAO.BankUserDAO;
import com.bank.DAO.BankUserDAOImpl;
@WebServlet("/updatedetails")
public class UpdateDetails extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String idStr=request.getParameter("id");
		int id=Integer.parseInt(idStr);
		
		Random rand=new Random();
		long accountnumber=100000000000L + Math.abs(rand.nextLong() % 900000000000L);
		int pin=rand.nextInt(9000)+1000;
		
		BankUserDAO userDAO=new BankUserDAOImpl();
		int updateResult=userDAO.updateStatus(accountnumber,pin,id);
		
		if(updateResult>0)
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher("AccountRequestDetails.jsp");
			dispatcher.forward(request, response);
		}
		else
		{
			response.sendRedirect("index.jsp?status=error");
		}
		
	}
	
	}

