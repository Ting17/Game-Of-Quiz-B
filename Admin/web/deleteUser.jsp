<%-- 
    Document   : deleteUser
    Created on : Jul 20, 2017, 1:00:04 PM
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
            Integer userID;
        %>
        
        <%
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){
                userID = Integer.parseInt(request.getParameter("id"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                    pstmt = conn.prepareStatement("DELETE FROM user WHERE userID = '" +userID+ "'");
                    pstmt.executeUpdate();
                    response.sendRedirect("./user.jsp");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>

</body>
</html>