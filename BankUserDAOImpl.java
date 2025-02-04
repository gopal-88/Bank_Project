package com.bank.DAO;

import java.io.PrintWriter;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.crypto.spec.PSource;

import org.bank.controller.UserRegistration;

import com.bank.model.BankUserDetails;

public class BankUserDAOImpl  implements BankUserDAO{
	
	private Connection connection;
	private static final String url="jdbc:mysql://127.0.0.1:3306/teca62projects?user=root&password=root";
	private static final String insert=
	"insert into bank_user_details(Name, Emailid, Mobile_Number, Aadhar_Number, Address, Amount, Gender,IFSC_code, Branch, Pan_Number, Status)"
	+ " values(?,?,?,?,?,?,?,?,?,?,?)";
	private static final String selectAll="select * from bank_user_details";
	private static final String select="select * from bank_user_details where Emailid=? and Pin=?";
	private static final String update="update bank_user_details set Status=? , Pin=?, Account_Number=? where id=?";
	private static final String update_amount="update bank_user_details set Amount=? where Account_Number=?";


	
	@Override
	public int insertBankUSerDetails(BankUserDetails details) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection=DriverManager.getConnection(url);
			
//			Random rand=new Random();
//			long accountnumber=100000000000L + Math.abs(rand.nextLong() % 900000000000L);
//			int pin=rand.nextInt(9000)+1000;
			String status="Pending";
			String ifsc="UNBI0428";
			
			
			PreparedStatement preparedStatement=connection.prepareStatement(insert);
			preparedStatement.setString(1, details.getName());
			preparedStatement.setString(2, details.getEmailid());
			preparedStatement.setLong(3, details.getMobilenumber());
			preparedStatement.setLong(4, details.getAadharnumber());
			preparedStatement.setString(5, details.getAddress());
			preparedStatement.setDouble(6, details.getAmount());
			preparedStatement.setString(7, details.getGender());
			preparedStatement.setString(8, ifsc);
			preparedStatement.setString(9, "UNION");
			preparedStatement.setString(10, details.getPan());
			preparedStatement.setString(11, status);
//			preparedStatement.setLong(12, accountnumber);
//			preparedStatement.setInt(13, pin);
			
			
		return preparedStatement.executeUpdate();
		
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		finally {
	        // Close connection
	        try {
	            if (connection != null) {
	                connection.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	@Override
	public List<BankUserDetails> allUserDetails() {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		connection=	DriverManager.getConnection(url);
		PreparedStatement statement=connection.prepareStatement(selectAll);
		ResultSet set=statement.executeQuery();
		List<BankUserDetails> list=new ArrayList<BankUserDetails>();
		if(set.isBeforeFirst())
		{
			while(set.next())
			{
				BankUserDetails userDetails=new BankUserDetails();
				userDetails.setId(set.getInt("id"));
				userDetails.setName(set.getString("Name"));
				userDetails.setEmailid(set.getString("Emailid"));
				userDetails.setMobilenumber(set.getLong("Mobile_Number"));
				userDetails.setAadharnumber(set.getLong("Aadhar_Number"));
				userDetails.setAddress(set.getString("Address"));
				userDetails.setPan(set.getString("Pan_Number"));
				userDetails.setStatus(set.getString("Status"));
				userDetails.setGender(set.getString("Gender"));
				list.add(userDetails);
			}
			return list;
		}
		else
		{
			return null;
		}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
	}


	public int updateStatus(long accountNumber,int pin,int id) {
		
		
		int updatedrows=0;
		
		try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connection = DriverManager.getConnection(url);
		
		        PreparedStatement preparedStatement = connection.prepareStatement(update);

		        preparedStatement.setString(1, "Active");
		        preparedStatement.setInt(2, pin);
		        preparedStatement.setLong(3, accountNumber);
		        preparedStatement.setInt(4, id);

		       updatedrows = preparedStatement.executeUpdate();

		        if (updatedrows > 0) {
		            System.out.println("Status updated to Active for account number: " + accountNumber);
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		        return 0;
		    } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return 0;
			}
		return updatedrows;
		}

	@Override
	public BankUserDetails userLogin(String emailid, int pin) {
		                                                                                                                                                                                                                                              
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection=DriverManager.getConnection(url);
			PreparedStatement userPreparedStatement=connection.prepareStatement(select);
			userPreparedStatement.setString(1, emailid);
			userPreparedStatement.setInt(2, pin);
		ResultSet rs=	userPreparedStatement.executeQuery();
		if (rs.next()) {
			BankUserDetails logindetails=new BankUserDetails();
			//id, Name, Emailid, Pin, Mobile_Number, Aadhar_Number, Address, Amount, Gender, Account_Number, IFSC_code, Branch, Pan_Number, Status
			logindetails.setName(rs.getString("Name"));
			logindetails.setEmailid(rs.getString("Emailid"));
			logindetails.setPin(rs.getInt("Pin"));
			logindetails.setMobilenumber(rs.getLong("Mobile_Number"));
			logindetails.setAadharnumber(rs.getLong("Aadhar_Number"));
			logindetails.setAddress(rs.getString("Address"));
			logindetails.setAmount(rs.getDouble("Amount"));
			logindetails.setGender(rs.getString("Gender"));
			logindetails.setAccountnumber(rs.getLong("Account_Number"));
			logindetails.setIfsc(rs.getString("IFSC_code"));
			logindetails.setStatus(rs.getString("Status"));
			return logindetails;
		} else {

			return null;
		}
		
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		
	}

	@Override
	public int updateamount(double amount, long accountnumber) {
		
		try (Connection connection = DriverManager.getConnection(url);
	             PreparedStatement ps = connection.prepareStatement(update_amount)) {

	            ps.setDouble(1, amount);
	            ps.setLong(2, accountnumber);
	            return ps.executeUpdate();

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return -1;
	        }
	}


}
