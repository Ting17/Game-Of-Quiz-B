<%-- 
    Document   : bonus
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
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Claim Reward</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="rewardstyle.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="languages.min.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Claim Reward</title>         
</head>

<body>
    
    <%
        Random rand = new Random();
        int n = rand.nextInt(3)+1;
    %>
    <center>
    <%
        if(n==1){
    %>
    <%@ include file="hangman.jsp"%>
    <% 
        } else{if(n==2){
    %>
    <%@ include file="pusheen.jsp"%>
   
    <% 
        } else{
    %>
    <%@ include file="quote.jsp"%>
    <%  
        }}
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