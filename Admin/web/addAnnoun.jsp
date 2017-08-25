<%-- 
    Document   : addAnnoun
    Created on : Jul 10, 2017, 9:40:11 PM
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
            String username;
            Statement stmt;
            ResultSet rs;
        %>
        
        <%-- CREATE function for adding announcement--%>
        <%
            username = (String)session.getAttribute("uname");
            
            if(request.getParameter("btnAdd") != null){
                try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");

                pstmt = conn.prepareStatement("INSERT INTO announcement(announcement, content, admin, cdate, udate) VALUES(?,?,?, NOW(), NOW())");
                pstmt.setString(1,request.getParameter("txtAnnoun"));
                pstmt.setString(2,request.getParameter("txtContent"));
                pstmt.setString(3,username);
                pstmt.executeUpdate();
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from admin where username='" + username + "'");       
                
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
