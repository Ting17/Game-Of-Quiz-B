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
            Integer adminID;
        %>
        
        <%-- CREATE function for new announcement--%>
        <%
            adminID = (Integer)session.getAttribute("aid");
            
            if(request.getParameter("btnAdd") != null){
                try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
              
                pstmt = conn.prepareStatement("INSERT INTO announcement(announcement, content, adminID, cdate, udate) VALUES(?,?,?, NOW(), NOW())");
                pstmt.setString(1,request.getParameter("txtAnnoun"));
                pstmt.setString(2,request.getParameter("txtContent"));
                pstmt.setInt(3,adminID);
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
