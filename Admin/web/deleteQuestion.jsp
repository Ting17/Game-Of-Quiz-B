<%-- 
    Document   : deleteQuestion
    Created on : Apr 26, 2017, 5:14:37 PM
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
            Integer questionID;
            String quizID, videoID;
        %>
        <!--delete function remove question-->
        <%
            if(request.getParameter("question") != null && request.getParameter("question")!= ""){
                questionID = Integer.parseInt(request.getParameter("question"));
                quizID = request.getParameter("quizID");
                videoID = request.getParameter("videoID");
                
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                    pstmt = conn.prepareStatement("DELETE FROM question WHERE questionID = '" +questionID+ "'and quizID='" + quizID + "'");
                    pstmt.executeUpdate();
                    response.sendRedirect("./question.jsp?quizID=" + quizID + "&videoID=" + videoID);
                
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>
    </body>
</html>