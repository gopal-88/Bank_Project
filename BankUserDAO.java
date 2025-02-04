package com.bank.DAO;

import java.util.List;

import com.bank.model.BankUserDetails;

public interface BankUserDAO {

	int insertBankUSerDetails(BankUserDetails details);
	List<BankUserDetails> allUserDetails();
	int updateStatus(long accountNumber,int pin,int id);
	BankUserDetails userLogin(String emailid,int pin);
	int updateamount(double amount,long accountnumber);
}
