<%-- 
    Document   : deleteAnnoun
    Created on : Jul 13, 2017, 4:07:50 PM
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
            Integer announID;
        %>
        <!--delete function remove announcement-->
        <%
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){
                announID = Integer.parseInt(request.getParameter("id"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                    pstmt = conn.prepareStatement("DELETE FROM announcement WHERE announID = '" +announID+ "'");
                    pstmt.executeUpdate();
                    response.sendRedirect("./announ.jsp");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>

</body>
</html>