
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
        <fieldset style="width: 25%; margin-top: 20px;">
            <legend><h3 style="color: green;">User Registration</h3></legend>
            <form action="registration" method="post">
                <table>
                    <tr>
                        <th><label for="name"style="color:highlight;">User Name:</label></th>
                        <td><input type="text" placeholder="Enter Your Name" name="name" required></td>
                    </tr>
                    <tr>
                        <th><label for="emailid"style="color: highlight;">User Email ID:</label></th>
                        <td><input type="text" placeholder="Enter Your Email ID" name="email" required></td>
                    </tr>
                    <tr>
                        <th><label for="mobile"style="color:highlight;">Mobile Number:</label></th>
                        <td><input type="text" placeholder="Enter Your Mobile Number" name="mb" required></td>
                    </tr>
                    <tr>
                        <th><label for="aadhar"style="color:highlight;">Aadhar Number:</label></th>
                        <td><input type="text" placeholder="Enter Your Aadhar Number" name="aadhar" required></td>
                    </tr>
                    <tr>
                        <th><label for="pan"style="color:highlight;">PAN Number:</label></th>
                        <td><input type="text" placeholder="Enter Your PAN" name="pan" required></td>
                    </tr>
                    <tr>
                        <th><label for="address"style="color:highlight;">Address:</label></th>
                        <td><input type="text" placeholder="Enter Your Address" name="address" required></td>
                    </tr>
                    <tr>
                        <th style="color:highlight;">Gender:</th>
                        <td>
                            <input type="radio" id="male" name="gender" value="Male" required> Male
                            <input type="radio" id="female" name="gender" value="Female" required> Female
                        </td>
                    </tr>
                    <tr>
                        <th><label for="amount" style="color:highlight;">Amount:</label></th>
                        <td><input type="text" placeholder="Enter Your Amount" name="amount"></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="Register">
                        </td>
                    </tr>
                </table>
            </form>
        </fieldset>
    </center>
</body>
</html>
