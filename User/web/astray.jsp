<%-- 
    Document   : astray
    Created on : Sep 5, 2017, 12:11:34 PM
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
    <title>Time for Astray Maze</title>
    
    <script src="frameworks/js/astrayjs/Box2dWeb.min.js"></script>
    <script src="frameworks/js/astrayjs/Three.js"></script>
    <script src="frameworks/js/astrayjs/keyboard.js"></script>
    <script src="frameworks/js/astrayjs/jquery.js"></script>
    <script src="frameworks/js/astrayjs/maze.js"></script>
    <script src="frameworks/js/astrayjs/astray.js"></script>

    <!-- StyleSheet -->
    <link href="frameworks/css/astray.css" rel="stylesheet" />
</head>
   
<body class="bonus4">

    <div id="instructions">
        <p>How to play Astray:</p>
        <br><br>
        <p>Use the arrow keys to move the ball and find the exit to the maze.</p>
        <br><br>
        <p>Control with: h, j, k, l</p>
    </div>

    <div id="help">
        <p>Hold down the 'I' key for instructions.</p>
    </div>

    <div id="level">
        <p>Level 1</p>
    </div>
    
    <div id="abutton" class="right">
        <a href="video2.jsp">Back to Video page</a> 
    </div>

</body>
</html>
