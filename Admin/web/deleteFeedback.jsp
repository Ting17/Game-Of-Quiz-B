<%-- 
    Document   : deleteFeedback
    Created on : Aug 28, 2017, 1:00:04 PM
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
            Integer feedbackID;
        %>
        <!--delete function remove feedback-->
        <%
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){
                feedbackID = Integer.parseInt(request.getParameter("id"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                    pstmt = conn.prepareStatement("DELETE FROM feedback WHERE feedbackID = '" +feedbackID+ "'");
                    pstmt.executeUpdate();
                    response.sendRedirect("./feedback.jsp");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }
        %>

</body>
</html>