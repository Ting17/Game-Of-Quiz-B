<%-- 
    Document   : gametime
    Created on : May 11, 2017, 12:45:01 AM
    Author     : tingting17
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
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Game Time</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/rewardstyle.css" rel="stylesheet" />

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->
  
</head>

<body>

    <%
        Random rand = new Random();
        int n = rand.nextInt(5)+1;
    %>
    <center>
    <%
        if(n==1){
    %>
    <%@ include file="game_hangman.jsp"%>
    <% 
        } if(n==2){
    %>
    <%@ include file="game_pusheen.jsp"%>
   
    <% 
        } if(n==3){
    %>
    <%@ include file="reward_quote.jsp"%>
    <% 
        } if(n==4){
    %>
    <div class="astray"> 
            <div class="game"><!--2.1-->
                <h1>Ready for a maze game?</h1><br/>
                <a class="btn btn-success btn-lg" href="game_astray.jsp">Ready!</a>
                <a class="btn btn-primary btn-lg" href="video2.jsp">Back to Video page</a>
            </div>
    </div>
    <% 
        } if(n==5){
    %>
    <div class="tetris"> 
        <img src="resources/img/tetris.png"/>
        <div class="tetrisf game">
            <h1>Ready for a tetris?</h1><br/>
            <a class="btn btn-success btn-lg" href="game_tetris.jsp">Ready!</a>
            <a class="btn btn-primary btn-lg" href="video2.jsp">Back to Video page</a>
        </div>
    </div>
     
    <%  
        }
    %>
    </center>


<!-- jQuery – required for Bootstrap's JavaScript plugins) -->
<script src="frameworks/js/jquery.min.js"></script>

<!-- All Bootstrap plug-ins file -->
<script src="frameworks/js/bootstrap.min.js"></script>
    
<!-- Basic AngularJS-->
<script src="frameworks/js/angular.js"></script>
        
<!-- Angular-route-->
<script src="frameworks/js/angular-route.min.js"></script>   

<!-- Configuration-->
<script src="frameworks/js/gameOQ.js"></script>    

</body>
</html>