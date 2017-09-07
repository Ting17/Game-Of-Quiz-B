<%-- 
    Document   : addTopic
    Created on : Apr 24, 2017, 11:12:32 PM
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
                pstmt = conn.prepareStatement("INSERT INTO quiz(quizTopic, category, videoID, cdate, udate, lupdateBY) VALUES(?,?,?,NOW(),NOW(),?)");
                pstmt.setString(1,request.getParameter("txtQuiz"));
                pstmt.setString(2,request.getParameter("txtCate"));
                pstmt.setString(3,request.getParameter("txtVideo"));
                pstmt.setString(4,username);
                pstmt.executeUpdate();
                
                response.sendRedirect("./quiz.jsp");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>

</body>
</html>

        
 