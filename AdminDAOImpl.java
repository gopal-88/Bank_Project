package com.bank.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class AdminDAOImpl  implements AdminDAO{

	private Connection connection;
	private static final String url="jdbc:mysql://127.0.0.1:3306/teca62projects?user=root&password=root";
	private static final String select="select * from admin where Admin_Email_id=? and Password=?";
	
	@Override
	public boolean adminlogin(String emailid, String password) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection=DriverManager.getConnection(url);
			
			PreparedStatement preparedStatement=connection.prepareStatement(select);
			preparedStatement.setString(1, emailid);  
	        preparedStatement.setString(2, password);
		ResultSet resultSet= preparedStatement.executeQuery();
		if(resultSet.next())
		{
			return true;
		}
		else
		{
			return false;
		}
		
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
			
		}
		
	}

}
