<%-- 
    Document   : quote
    Created on : July 31, 2017, 04:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>

        <%!
            Connection conn;
            PreparedStatement pstmt;
            Statement stm;
            ResultSet rs;
            Integer videoID;
            String username,password,category;
            
        %>

        <%-- read and create function--%>    
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                stm = conn.createStatement();
                rs = stm.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
                if(request.getParameter("btnCollect") != null){
                    pstmt = conn.prepareStatement("UPDATE user SET result = ? WHERE username='" + username + "' and password='" + password + "'");
                    pstmt.setString(1,request.getParameter("star"));
                    pstmt.executeUpdate();
                }              
                
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            } 
        %>
            
            <div class='congrats' >CONGRATULATIONS!</div>
            <p>You got 3 Star!</p> 
            <p><i>Click on the star to collect it.</i></p>
   
            <form action="" method="POST">
            <%  
                while(rs.next()) {
            %>             
                <input type="hidden" name="star" value="<%=rs.getInt("result")+3%>"/>
            <%
                }
            %> 
                <label for="collect">
                    <span class="glyphicon glyphicon-star yellow" title="Collect Me"></span>
                    <input type="submit" id="collect" name="btnCollect" style="display:none" onClick="collectSound()"/>
                </label>
            </form>   