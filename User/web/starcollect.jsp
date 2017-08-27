<%-- 
    Document   : question
    Created on : Aug 25, 2017, 04:59:49 PM
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
        
   
            <form action="" method="POST">
            <%  
                while(rs.next()) {
            %>             
                <input type="hidden" name="star" value="<%=rs.getInt("result")+1%>"/>
            <%
                }
            %> 
                <label for="collect">
                    <span class="glyphicon glyphicon-star yellow"></span>
                    <input type="submit" id="collect" name="btnCollect" style="display:none" onClick="collectSound()"/>
                </label>
            </form>   
