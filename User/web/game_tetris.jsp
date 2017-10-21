<%-- 
    Document   : game_tetris
    Created on : Sep 5, 2017, 2:31:52 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- Style -->
<link href="frameworks/css/tetris.css" rel="stylesheet" />
    <title>Time for Tetris</title>

</head>

<body>
    <center>
    <div class="row" id="tetris">
        <div class="col-sm-8 col-md-8 col-lg-8" >
            <canvas id="canvas">
                Sorry, this example cannot be run because your browser does not support the &lt;canvas&gt; element
            </canvas>
        </div>
        <div class="col-sm-4 col-md-4 col-lg-4">
            <div id="menu">
                <p id="start"><a href="javascript:play();">Press Space to Play.</a></p>
                <p>Upcoming</p>
                <p><canvas id="upcoming"></canvas></p><br/>
                <p>Score: <span id="score">00000</span></p>
                <p>Row(s) cleared: <span id="rows">0</span></p>
            </div>
        </div>  
    </div>

    <div class="row">
        <div class="col-xs-12 col-md-12 col-lg-12"><!--2.1-->
            <a class="btn btn-primary btn-lg qbutton" href="video2.jsp">Back to Video page</a>
        </div><!--close column 2.1-->
    </div>
    </center>    
    <script src="frameworks/js/tetrisjs/stats.js"></script>
    <script src="frameworks/js/tetrisjs/tetris.js"></script>  

</body>
</html>
