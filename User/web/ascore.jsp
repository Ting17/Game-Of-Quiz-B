<%-- 
    Document   : profile
    Created on : Aug 12, 2017, 10:16:54 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Play</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body class="profile">
        <%!
            Connection conn;
            Statement stm;
            ResultSet rs;
            String username,password;
        %>

        <%-- READ function for question--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    stm = conn.createStatement();
                    rs = stm.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");

                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
        %>
        

    <center>
        <div class="row"> <!-- 1 -->
            <div class="col-sm-3 col-md-3 col-lg-3 prostar1"> <!-- 1.1 -->
                <img src="resources/img/s.gif"/>
            </div> <!-- close column 1.1-->
            
            <div class="col-sm-6 col-md-6 col-lg-6 title"> <!-- 1.2 -->
                <div class="row"> <!-- 1.2.1 -->
                    <div class="col-sm-12 col-md-12 col-lg-12"> <!-- 1.2.1.1 -->
                <%  
                    if (rs.next()) {
                %>
                    <h1>Hi <%=rs.getString("username")%></h1>
                    <br/>
                    <p>You have collected</p>
                    <h2 class="yellow"><%=rs.getString("result")%> Stars</h2>
                <%
                    }
                %> 
                    </div>
                </div> <!-- close row 1.2.1-->
                <div class="row"> <!-- 1.2.2 -->
                    <div class="col-sm-12 col-md-12 col-lg-12"> <!-- 1.2.2.1 -->
                        <a href="video2.jsp" class="btn btn-warning btn-lg probutton">Play More Quiz</a>
                        <a class="btn btn-default btn-lg probutton" onclick="history.back()">Back</a>
                        
                    </div>
                </div> <!-- close row 1.2.2-->
            </div> <!-- close column 1.2-->
                    
            <div class="col-sm-3 col-md-3 col-lg-3 prostar2"> <!-- 1.3 -->
                <img src="resources/img/s.gif"/>
            </div> <!-- close column 1.3-->
        </div> <!-- close row 1-->
                    
        <div class="row"> <!-- 2 -->
            <div class="col-sm-12 col-md-12 col-lg-12 prodesc"> <!-- 2.1 -->
                <p>Try to collect as many stars as possible by answering question correctly.</p>
                <p>Stars collected will be token for future event.</p>
            </div>
        </div> <!-- close row 2-->
    </center>