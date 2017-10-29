<%-- 
    Document   : quiz_advise
    Created on : Oct 27, 2017, 2:09:26 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <a data-toggle="modal" data-target="#myModal" >
        <img src="resources/img/cat.gif" class="cat" alt="click me" title="click me" onClick="meowSound()"/> <!-- image obtained from http://misstingtingwu.blogspot.my/ -->
    </a>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    <div class="modal-content catnote">
        <center>
            <h4 class="modal-title"><b>Thankz for noticing me, Human!!!</b></h4>
        </center>
        <br/>
        <p><b>Cat's Advise 1:</b></p>
        <ul>
            <li><p>Watch video and try to get the general idea.</p></li>
            <li><p>Answer question on the right side.</p></li>
            <li><p>Watch again for answer if have any doubt.</p></li>
        </ul>
        <br/>
        <p><b>Cat's Advise 2:</b></p>
        <ul>
            <li><p>If confident enough go play more quiz, take the challenge.</p></li>
            <li><p>If found any mistake, click on feedback button.</p></li>
            <li><p>Answer the questions correctly to collect a star.</p></li>
            <li><p>Answer the <b>Last</b> question correctly for a <u>random chest reward</u>.</p></li>
        </ul>
        <br/>    
        <div class="catpawn">
            <img src="resources/img/catpawn.png">
        </div>
    </div>
    </div>
    </div> <!--close modal-->