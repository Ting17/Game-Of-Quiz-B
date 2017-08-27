<%-- 
    Document   : bonus
    Created on : May 11, 2017, 12:45:01 AM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

   
<div class="bonus2">
    <div data-ng-hide="cat=cat===true" class="hungry">
        <div class="row"> <!--1-->
            <div class="col-xs-12 col-md-12 col-lg-12"> <!--1.1-->
                <h1>Pusheen the cat is blocking your reward</h1>
                <img src="resources/img/feedme.gif"/>  
                <br/>
                <button class="btn btn-primary btn-lg feed" data-ng-click="cat=cat!==true" >Feed</button>
            </div> <!--close column 1.1-->
        </div> <!--close row 1-->
    </div>
            
    <div data-ng-show ="cat"> 
    <div data-ng-hide="cat2=cat2===true">
        <div class="row"> <!--1-->
            <div class="col-xs-7 col-md-7 col-lg-7"> <!--1.1-->
                <div class="bubble">
                    <p class="thought">
                <%
                    Random random = new Random();
                    int x = random.nextInt(4)+1;

                    if(x==1){
                %>
                        Sushi
                <% 
                    } else{if(x==2){
                %>
                        Pizza
                <%  
                    }else{if(x==3){
                %>
                        Cookie
                <%  
                    }else{
                %>
                        Fish
                <%  
                    }}}
                %>
                    </p>
                </div>
  
                <img id="myImage" src="resources/img/waiting.gif" />
            </div> <!--close column 1.1-->
                
            <div class="col-xs-5 col-md-5 col-lg-5 instruct"> <!--1.2-->
                <center>
                    <h2>Select food for Pusheen</h2>
                    <a class="btn btn-primary btn-lg feed" type="submit" data-ng-click="cat2=cat2!==true" onclick="meowSound()">Feed</a>
                </center>
            </div> <!--close column 1.2-->
        </div> <!--close row 1-->
                   
        <div class="row"> <!--2-->
            <div class="col-xs-3 col-md-3 col-lg-3"> <!--2.1-->
                <input type="radio" data-ng-model="food" value="1" required/><img class="food" title="sushi" src="resources/img/fsushi.png" />
            </div>
                    
            <div class="col-xs-3 col-md-3 col-lg-3"> <!--2.2-->
                <input type="radio" data-ng-model="food" value="2" /><img class="food" title="pizza" src="resources/img/fpizza.png" />
            </div>
                    
            <div class="col-xs-3 col-md-3 col-lg-3"> <!--2.3-->
                <input type="radio" data-ng-model="food" value="3" /><img class="food" title="cookie" src="resources/img/fcookie.png" />
            </div>
                    
            <div class="col-xs-3 col-md-3 col-lg-3"> <!--2.5-->
                <input type="radio" data-ng-model="food" value="4" /><img class="food" title="fish" src="resources/img/ffish.png" />
            </div>         
        </div> <!--close row 2-->      
    </div>
    </div> <!--close show cat-->
                            
    <div data-ng-show ="cat2"> 
    <div data-ng-hide="cat3=cat3===true">  
        <div class="row"> <!--1-->
            <div class="col-xs-12 col-md-12 col-lg-12"> <!--1.1-->             
                <div id="cateatgif">
                    <!-- correct -->
                    <div data-ng-if="food === '<%=x%>'">
                        <%
                            if(x==1){
                        %>
                            <img class="food" src="resources/img/psushi.gif" />
                        <% 
                            } else{if(x==2){
                        %>
                            <img class="food" src="resources/img/ppizza.gif" />
                        <%  
                            }else{if(x==3){
                        %>
                            <img class="food" src="resources/img/pcookie.gif" />
                        <%  
                            }else{
                        %>
                            <img class="food" src="resources/img/pfish.gif" />
                        <%  
                            }}}
                        %>
                    </div>

                    <!-- incorrect -->
                    <div data-ng-if="food !== '<%=x%>'">
                        <img src="resources/img/angry.gif" />
                    </div>  
                </div>

                <div id="catgiffinish" style="display:none;">
                    <!-- correct -->
                    <div data-ng-if="food === '<%=x%>'">
                        <img src="resources/img/pthank.gif" />
                        <br/>
                        <a class="btn btn-success btn-lg feed" href="quote.jsp">Claim Quote</a>
                        <a class="btn btn-primary btn-lg feed" href="video2.jsp">Back to Video page</a>
                        <a class="btn btn-default btn-lg feed" href="profile.jsp">Back to profile</a>
                    </div>
                    
                    <!-- incorrect -->
                    <div data-ng-if="food !== '<%=x%>'">
                        <p>Wrong food for pusheen</p>
                    </div>
                </div>
            </div> <!--close column 1.1-->
        </div> <!--close row 1-->
    </div>
    </div> <!--close show cat2-->                
</div><!--end bonus2-->