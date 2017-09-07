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
            String username;
        %>
        
        <%-- CREATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            
            if(request.getParameter("btnAdd") != null){
                try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                pstmt = conn.prepareStatement("INSERT INTO reward(reward, cdate, udate,lupdateBY) VALUES(?, NOW(), NOW(),?)");
                pstmt.setString(1,request.getParameter("txtReward"));
                pstmt.setString(2,username);
                pstmt.executeUpdate();
                
                response.sendRedirect("./reward.jsp");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>

</body>
</html>
