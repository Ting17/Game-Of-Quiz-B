<%-- 
    Document   : videoquestion
    Created on : Apr 29, 2017, 11:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>

        <%!
            Connection conn;
            Statement stmt;
            ResultSet result;
            Integer videoID, z=1, y=1;
            String username,password,category; 
        %>

        <%-- read function --%>    
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");

            videoID = Integer.parseInt(request.getParameter("id"));
            category = request.getParameter("categ");
            try{
                Class.forName("com.mysql.jdbc.Driver");
             
                stmt = conn.createStatement();
                result = stmt.executeQuery("SELECT * FROM question WHERE videoID = '"+videoID +"' LIMIT 5");
                
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            }
        %>
             
                    
    <div class="table-responsive">
        <table class="table table-stripped table-hover sortable questiont" id="tablepaging">
            <thead>
                <tr>
                    <th>
                        <center>
                            <div id="pgNum"></div>
                        </center> 
                    </th>
                </tr>
            </thead>       
            <tbody>
        <%
            while(result.next() ) {
             
        %>
                <tr>   
                    <td>
                        <!--display quiz question-->
                        <div id="<%=result.getInt("questionID") %>" class="questioncontainer">
                            <h4><%=result.getString("question") %></h4>
                            <div data-ng-if="'<%=result.getString("type")%>' === 'M'"><p class="right type" title="It's Multiple Choice"><%=result.getString("type")%></p></div>
                            <div data-ng-if="'<%=result.getString("type")%>' === 'B'"><p class="right type" title="Fill in the Blank with choices below"><%=result.getString("type")%></p></div>
                            <div data-ng-if="'<%=result.getString("type")%>' === 'T'"><p class="right type" title="True or False?"><%=result.getString("type")%></p></div>
                        </div> 

                        <div class="container2">
                            <!-- Format for multiple choice -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'M'">
                                <form name="form1">
                                    <div class="row"><!--2.2.1--> 
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice "><!--2.2.1.1--> 
                                            <label for="A">
                                                A <input type="radio" data-ng-model="checkeds" value="A" id="A" name="multiradio" required/> <%=result.getString("input1") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--2.2.1.2--> 
                                            <label for="B">
                                                B <input type="radio" data-ng-model="checkeds" value="B" id="B" name="multiradio" /> <%=result.getString("input2") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--2.2.1.3--> 
                                            <label for="C">
                                                C <input type="radio" data-ng-model="checkeds" value="C" id="C" name="multiradio" /> <%=result.getString("input3") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--2.2.1.4--> 
                                            <label for="D">
                                                D <input type="radio" data-ng-model="checkeds" value="D" id="D" name="multiradio" /> <%=result.getString("input4") %>
                                            </label>
                                        </div>
                                    </div> <!--close row 2.2.1-->
             
                                    <!-- button -->   
                                    <div class="row button"><!--2.2.2-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1" ><!--2.2.2.1-->
                                            <a  class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 2; count = count+1" data-ng-init="0" data-ng-disabled="form1.$invalid" onClick="checkansSound()">Check</a>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2..2-->
                                            <a class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 3" onClick="giveupSound()">Give Up</a>
                                        </div> 
                                    </div> <!--close row 2.2.2--> 
                                </form>                                  
                <center>                    
                <!-- check answer-->
                <div data-ng-show="show === 2">
                    <!-- correct -->
                    <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                        <span class="yellow"><h3>Correct</h3></span>
                        <hr class="correct">
                        <div data-ng-if="<%=z %>%5 === 0">
                            <jsp:include page="starcollect.jsp"></jsp:include>       
                        </div>
                        <div data-ng-if="count === 1 ">
                            <h1 class="countdown3">3</h1>
                        </div>
                        <div data-ng-if="count === 2 ">
                            <h1 class="countdown2">2</h1>
                        </div>
                        <div data-ng-if="count === 3 ">
                            <h1 class="countdown1">1</h1>
                        </div>
                        <div data-ng-if="count === 4 ">
                            <a href="bonus.jsp" class="btnbonus">Bonus Time!!</a>
                        </div>
                        <%
                            z++;
                        %>
                    </div>
                                
                    <!-- incorrect -->
                    <div data-ng-if="checkeds !== '<%=result.getString("checked")%>'">
                        <h3>Incorrect</h3>
                        <hr class="normal">
                    </div> 
                </div>
                        
                <!-- Show answer -->
                <div data-ng-show="show === 3">
                    <b class="answer">Answer: <%=result.getString("checked")%></b>
                </div> 
                
                </center> 
                            </div> <!--end of multiple choice format-->
                            
                            
                            <!-- Format for Fill in the Blank -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'B'">
                                <ul class="answercontainer">
                                    <li>
                                        <span><%=result.getString("input1") %></span>
                                        <span class="tab"><%=result.getString("input2") %></span>
                                        <span class="tab"><%=result.getString("input3") %></span>
                                        <span class="tab"><%=result.getString("input4") %></span>
                                    </li>
                                </ul>
                            </div> <!--end of fill in blank format-->

                            
                            <!-- User input for Fill in the Blank & True False -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'B' || '<%=result.getString("type")%>' === 'T'">
                                <form name="form2">
                                    <div class="useranswer">
                                        <center>
                                            <h4>Answer:</h4>
                                            <input type="text" name="answer" data-ng-model="checkeds" size="40%" required/>
                                        </center>                                    
                                    </div>
                                                                                  
                                    <div class="row"><!--2.2.1-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--2.2.1.1--> 
                                            <button class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 2; count = count+1" data-ng-init="0" data-ng-disabled="form2.$invalid" onClick="checkansSound()">Check</button>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2.1.2-->
                                            <button class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 3" onClick="giveupSound()">Give Up</button>  
                                        </div> 
                                    </div> <!--close row 2.2.1-->                 
                                </form>
                
                <center>                    
                <!-- check answer-->
                <div data-ng-show="show === 2">
                    <!-- correct -->
                    <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                        <span class="yellow"><h3>Correct</h3></span>
                        <hr class="correct">
                        
                        <div data-ng-if="<%=y %>%5 === 0">
                            <jsp:include page="starcollect.jsp"></jsp:include>       
                        </div>
                        <div data-ng-if="count === 1 ">
                            <h1 class="countdown3">3</h1>
                        </div>
                        <div data-ng-if="count === 2 ">
                            <h1 class="countdown2">2</h1>
                        </div>
                        <div data-ng-if="count === 3 ">
                            <h1 class="countdown1">1</h1>
                        </div>
                        <div data-ng-if="count === 4 ">
                            <a href="bonus.jsp" class="btnbonus">Bonus Time!!</a>
                        </div>
                        <%
                            y++;
                        %>
                    </div>
                                
                    <!-- incorrect -->
                    <div data-ng-if="checkeds !== '<%=result.getString("checked")%>'">
                        <h3>Incorrect</h3>
                        <hr class="normal">
                    </div> 
                </div>
                        
                <!-- Show answer -->
                <div data-ng-show="show === 3">
                    <b class="answer">Answer: <%=result.getString("checked")%></b>
                </div> 
                
                </center> 
                            </div> <!--end of Fill in the Blank & True False-->
                                   
                        </div> <!--close container2-->
                    </td>
                </tr>    
        <%
            }
        %>
            </tbody>
        </table>
    </div>
            
            
            
      