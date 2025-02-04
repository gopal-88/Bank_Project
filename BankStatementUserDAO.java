package com.bank.DAO;

import java.sql.Connection;

public interface BankStatementUserDAO {

	boolean insertstatementDetails(String transactiontype, double transactionamount,long accountnumber,double balanceamount);
	void setConnection(Connection connection);
}
