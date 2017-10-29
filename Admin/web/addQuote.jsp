<%-- 
    Document   : addReward
    Created on : Jul 7, 2017, 1:35:17 PM
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
            Integer adminID;
        %>
        
        <%-- CREATE function for quote as reward--%>
        <%
            adminID = (Integer)session.getAttribute("aid");
            
            if(request.getParameter("btnAdd") != null){
                try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                pstmt = conn.prepareStatement("INSERT INTO reward(reward, cdate, udate,adminID) VALUES(?, NOW(), NOW(),?)");
                pstmt.setString(1,request.getParameter("txtReward"));
                pstmt.setInt(2,adminID);
                pstmt.executeUpdate();
                
                response.sendRedirect("./quote.jsp");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>

</body>
</html>
