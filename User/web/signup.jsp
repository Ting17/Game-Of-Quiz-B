<%-- 
    Document   : signup
    Created on : Sep 4, 2017, 3:28:22 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>

    <body>
        <%!
            Connection conn;
            PreparedStatement pstmt;
        %>
        
        <%-- CREATE function--%>
        <%
            if(request.getParameter("signup") != null){
                try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                pstmt = conn.prepareStatement("INSERT INTO user(username, password, result) VALUES(?,?,?)");
                pstmt.setString(1,request.getParameter("username"));
                pstmt.setString(2,request.getParameter("password"));
                pstmt.setString(3,request.getParameter("result"));
                pstmt.executeUpdate();
                response.sendRedirect("./index.html");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>
    </body>
</html>
