<%-- 
    Document   : deleteQuiz
    Created on : Apr 25, 2017, 12:09:43 AM
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
            Integer quizID;
        %>
        <!--delete function remove Quizr-->
        <%
            if(request.getParameter("quiz") != null && request.getParameter("quiz")!= ""){
                quizID = Integer.parseInt(request.getParameter("quiz"));
  
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                    pstmt = conn.prepareStatement("DELETE FROM quiz WHERE quizID = '" +quizID+ "'");
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