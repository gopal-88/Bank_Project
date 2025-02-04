package com.bank.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//@Getter
//@Setter
@AllArgsConstructor
@NoArgsConstructor
//@ToString
@Data
public class BankUserDetails {

	private int id;
	private String name;
	private String emailid;
	private int pin;
	private long mobilenumber;
	private long aadharnumber;
	private String address;
	private double amount;
	private String gender;
	private long accountnumber;
	private String ifsc;
	private String branch;
	private String pan;
	private String status;
	
}
