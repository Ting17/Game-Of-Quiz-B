<%-- 
    Document   : bonus
    Created on : Aug 05, 2017, 12:45:01 AM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<script src="frameworks/js/hangman.js"></script> 
      

<div class="bonus1">
    <div class="row"><!--1-->
        <div class="col-xs-12 col-md-12 col-lg-12 hangman"><!--1.1-->
            <h1>Time with Hangman</h1>
            <p>(Try to guess the word by select alphabet below.) </p>
        </div> <!--close column 1.1-->
    </div> <!--close row 1-->
        
    <div class="row"><!--2-->
        <div class="col-xs-12 col-md-12 col-lg-12"><!--2.1-->
            <p id="mylives"></p>
            <div id="buttons"></div>  
        </div> <!--close column2.1-->
    </div> <!--close row 2-->
    
    <div class="row"><!--3-->
        <div class="col-xs-12 col-md-12 col-lg-12"><!--3.1-->
            <p id="catagoryName"></p>
            <div id="hold"></div>

            <canvas id="stickman">This Text will show if the Browser does NOT support HTML5 Canvas tag</canvas>
            <div class="container">
                <button id="hint" class="btn btn-lg btn-success hbutton" data-toggle="modal" data-target="#modal">Hint</button>
                <button id="reset" class="btn btn-lg btn-danger hbutton2">Play again</button>
                <a href="video2.jsp" class="btn btn-lg btn-primary hbutton">Back to Video page</a>
                <a href="profile.jsp" class="btn btn-lg btn-default hbutton2">Back to profile</a>

                <!-- Hint Modal -->
                <div class="modal fade " id="modal" role="dialog"> 
                <div class="modal-dialog modal-content modal-sm">
                    <center>
                    <div class="modal-body">
                        <p id="clue">Hint: </p>  
                    </div>
                    </center>
                </div>
                </div> 
            </div>
        </div> <!--close row 3.1-->
    </div> <!--close row 3-->

</div> <!--end of bonus1-->



 
    


                  