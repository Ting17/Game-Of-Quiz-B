<%-- 
    Document   : reward_starcollect
    Created on : July 31, 2017, 04:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

                    <center>
                    <button class="chestbtn" onclick="changeImage1()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange1" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage2()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange2" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage3()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange3" src="resources/img/chestclosed.png"></button>
                    </center>
                    <div data-ng-if="btnclicked === 3" class="chestreward">
                    <%
                        Random rand3 = new Random();
                        int o1 = rand3.nextInt(3)+1;
                        if(o1==1){
                    %>
                        <a href="gametime.jsp" class="btnbonus">Game Time!!</a>
                    <% 
                        } if(o1==2){
                    %>
                        <jsp:include page="reward_starcollect3.jsp"></jsp:include>
                    <% 
                        } if(o1==3){
                    %>
                        <p>Too bad. Try Again Next Time</p>
                    <% 
                        }
                    %>
                    </div> 