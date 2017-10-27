<%-- 
    Document   : checkscore
    Created on : Oct 27, 2017, 2:09:26 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
        
        <%!
            Connection conn;
            Statement stmt;
            ResultSet rs;
            String username,password;
        %>

    <%-- read function for personal scoring--%>    
    <%
        username = (String)session.getAttribute("uname");
        password = (String)session.getAttribute("pass");

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");

            stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
 
        }catch(ClassNotFoundException cnfe){
            out.println("Class not Found Execption:-" + cnfe.toString());
        }catch(SQLException sqle){
            out.println("SQL Query Exception:- " + sqle);
        }     
    %>    
        

        <!-- Modal -->
    <%  
        rs.previous();
        if (rs.next()) {
    %>        
        <div class="modal fade" id="ascore" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content modalbg">
            <!--Content-->
            <div class="estrellas">
                <span class="glyphicon glyphicon-star yellow"></span>
                <span class="glyphicon glyphicon-star yellow"></span>
                <span class="glyphicon glyphicon-star yellow"></span>
                <span class="glyphicon glyphicon-star yellow"></span>
                <span class="glyphicon glyphicon-star yellow"></span>
                <span class="glyphicon glyphicon-star yellow"></span>
                <span class="glyphicon glyphicon-star yellow"></span>
            </div>   
            <center class="ascore">
                <h3><b><%=rs.getString("username")%></b></h3>
                <br/>
                <h4>You have collected</h4>
                <h2 class="yellow"><%=rs.getString("result")%> Stars</h2>
                <br/>
                <p><i>**Collect more star as token for future event**</i></p>
                <button class="btn btn-default btn-lg btn-block" data-dismiss="modal">Ok!</button> <br/>
            </center> 
        </div>
        </div>
        </div> <!--close modal-->
    <%
        }
    %>   