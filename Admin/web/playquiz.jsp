<%-- 
    Document   : playquiz
    Created on : Sep 7, 2017, 2:56:42 AM
    Author     : Kevin Pui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html data-ng-app="myApp">
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8;">
<title>Play</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>

<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />
<link href="frameworks/css/questionstyle.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

    </head>
    <body>
        <%!
            Connection conn;
            PreparedStatement pstmt;
            Statement stmt, stmt2,st;
            ResultSet result, rs,res;
            Integer quizID, z=1, y=1;
            String username, password, category,videoID;
        %>
        
       <%
        username = (String)session.getAttribute("uname");
        password = (String)session.getAttribute("pass");
        videoID = request.getParameter("videoID");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                
            stmt = conn.createStatement();
            result = stmt.executeQuery("SELECT * FROM question WHERE videoID = '"+videoID +"' LIMIT 5");
        
            stmt2 = conn.createStatement();
            rs = stmt2.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
            
            st=conn.createStatement();
            res = st.executeQuery("SELECT * FROM video WHERE videoID = '"+ videoID +"'");
            
            
        }catch(ClassNotFoundException cnfe){
            out.println("Class not Found Execption:-" + cnfe.toString());
        }catch(SQLException sqle){
            out.println("SQL Query Exception:- " + sqle);
        }
        %> 
        
        <script src="frameworks/js/paginationMethod1.js"></script>
        
    <div class="container">
    <%     
        if (rs.next()) {
    %>
    <div class="row"><!--1--> 
        <!-- tab -->
        <div class="col-xs-2 col-md-2 col-lg-2 tab"><!--1.1--> 
            <div id="circle">
                <a href="profile.jsp" id="profile"><%=rs.getString("username")%></a>
            </div>
    <%
        }else {
            response.sendRedirect("index.jsp");
        }
    %>
        
    <jsp:include page="navigator.jsp"></jsp:include> 
    
        <%
            while(res.next() ) {
        %>
    <div class="row wrap"><!--1.2.2--> 
        <div class="col-xs-12 col-md-7 col-lg-7 videoquestion"><!--1.2.2.1--> 
        <%
            if(res.getString("videoPath").contains("embed")){
        %>
            <iframe class="qvideo" src="<%=res.getString("videoPath")%>" frameborder="0" allowfullscreen></iframe>
        <%
            }else{
        %>
            <video controls width="100%"><source src="<%=res.getString("videoPath")%>" type="video/mp4"></video>  
        <%
            }
        %>        
        </div>  
        <div class="col-xs-12 col-md-5 col-lg-5 videoquestion" ><!--1.2.2.2--> 
            <%@ include file="videoquestion.jsp"%>
        </div> 
    </div> <!--close row 1.2.2-->
    
        <%
           }
        %>


    <!-- pagination caller; java--> 
    <script src="frameworks/js/paginationCaller1.js"></script> 
    
    <!-- footer -->
    <jsp:include page="footer.jsp"></jsp:include>