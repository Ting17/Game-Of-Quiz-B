<%-- 
    Document   : quiz_question
    Created on : Apr 29, 2017, 11:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

        <%!
            Connection conn;
            Statement st;
            ResultSet result, res;
            Integer x=1, y=1, z=1;
            String username,password,category,quizID,videoID;
        %>

        <%-- read function --%>    
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            
            if(request.getParameter("videoID") != null && request.getParameter("videoID")!= ""){ 
                videoID = request.getParameter("videoID");
                quizID = request.getParameter("quizID");
                category = request.getParameter("categ");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    st = conn.createStatement();
                    result = st.executeQuery("SELECT * FROM question WHERE videoID = '" + videoID + "' AND quizID = '" + quizID + "' LIMIT 5");
                    
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }
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
                            <div data-ng-if="'<%=result.getString("type")%>' === 'MC'"><p class="right type" title="It's Multiple Choice">MC</p></div>
                            <div data-ng-if="'<%=result.getString("type")%>' === 'BL'"><p class="right type" title="Fill in the Blank with choices below">BL</p></div>
                            <div data-ng-if="'<%=result.getString("type")%>' === '2C'"><p class="right type" title="It's two choice selection">2C</p></div>
                        </div> 

                        <div class="container2">
                            <!-- Format for multiple choice -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'MC'">
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
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--2.2.2.1-->
                                            <a class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 1" data-ng-disabled="form1.$invalid" onClick="checkansSound()">Check</a>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2.2.2-->
                                            <a class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 2" onClick="giveupSound()">Give Up</a>
                                        </div> 
                                    </div> <!--close row 2.2.2--> 
                                </form>                                  
        <center>   
        <!-- check answer-->
        <div data-ng-show="show ===1">
            <!-- correct -->
            <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                <span class="yellow"><h3>Correct</h3></span>
                <hr class="correct yellow">
                
                <!--chest box for 5th question-->
                <div data-ng-if="<%=x %>%5 === 0">
                    <jsp:include page="gameChest.jsp"></jsp:include> 
                </div><!-- end of chest box for 5th question-->
                
                <!--star for every question except for the 5th-->
                <div data-ng-if="<%=x %>%5 !== 0">
                    <jsp:include page="reward_starcollect.jsp"></jsp:include>  
                </div><!--end of star for every question except for the 5th-->
                
            </div> <!-- end of correct answer-->
            <%
                x++;
            %>
                         
            <!-- incorrect -->
            <div data-ng-if="checkeds !== '<%=result.getString("checked")%>'">
                <h3>Incorrect</h3>
                <hr class="normal">
            </div> <!-- end of incorrect answer-->
        </div> <!-- end of check answer-->        
                        
        <!-- Show answer -->
        <div data-ng-show="show === 2">
            <b class="answer">Answer: <%=result.getString("checked")%></b>
        </div> <!-- end of showing answer-->       
        </center> 
                            </div> <!--end of multiple choice format-->

                            
                            <!-- Format for Fill in the Blank -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'BL'">
                                <form name="form2">
                                    <ul class="answercontainer">
                                        <li>
                                            <span><%=result.getString("input1") %></span>
                                            <span class="tab"><%=result.getString("input2") %></span>
                                            <span class="tab"><%=result.getString("input3") %></span>
                                            <span class="tab"><%=result.getString("input4") %></span>
                                        </li>
                                    </ul>
                                    
                                    <center class="inputans">
                                        <h4>Answer:</h4>
                                        <input type="text" name="answer" data-ng-model="checkeds" required/>                                        <br/>
                                    </center> 
                                                                                  
                                    <div class="row"><!--2.2.1-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--2.2.1.1--> 
                                            <button class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 1" data-ng-disabled="form2.$invalid" onClick="checkansSound()">Check</button>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2.1.2-->
                                            <button class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 2" onClick="giveupSound()">Give Up</button>  
                                        </div> 
                                    </div> <!--close row 2.2.1-->                 
                                </form>
        <center>                    
        <!-- check answer-->
        <div data-ng-show="show === 1">
            <!-- correct -->
            <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                <span class="yellow"><h3>Correct</h3></span>
                <hr class="correct">
                <!--chest box for 5th question-->
                <div data-ng-if="<%=z %>%5 === 0">
                    <jsp:include page="gameChest.jsp"></jsp:include> 
                </div><!-- end of chest box for 5th question-->

                <!--star for every question except for the 5th-->
                <div data-ng-if="<%=z %>%5 !== 0">
                    <jsp:include page="reward_starcollect.jsp"></jsp:include>  
                </div><!--end of star for every question except for the 5th-->
            </div>
                                
            <!-- incorrect -->
            <div data-ng-if="checkeds !== '<%=result.getString("checked")%>'">
                <h3>Incorrect</h3>
                <hr class="normal">
            </div> 
        </div>
                        
        <!-- Show answer -->
        <div data-ng-show="show === 2">
            <b class="answer">Answer: <%=result.getString("checked")%></b>
        </div>                
        </center>        
                            </div> <!--end of Fill in the Blank -->

                            <!-- User input for two choice selection -->
                            <div data-ng-if="'<%=result.getString("type")%>' === '2C'">
                                <form name="form3">
                                    <div class="row"><!--2.2.1-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 twocs"><!--2.2.1.1--> 
                                            <label for="A">
                                                <input type="radio" data-ng-model="checkeds" value="1" id="A" name="multiradio" required/> <%=result.getString("input1") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 twocs"><!--2.2.1.2--> 
                                            <label for="B">
                                                <input type="radio" data-ng-model="checkeds" value="2" id="B" name="multiradio" /> <%=result.getString("input2") %>
                                            </label>
                                        </div>
                                    </div><!--close row 2.2.1-->
                                            
                                    <div class="row"><!--2.2.2-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--2.2.2.1--> 
                                            <button class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 1" data-ng-disabled="form3.$invalid" onClick="checkansSound()">Check</button>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2.2.2-->
                                            <button class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 2" onClick="giveupSound()">Give Up</button>  
                                        </div> 
                                    </div> <!--close row 2.2.2-->                 
                                </form>
        <center>      
        <!-- check answer-->
        <div data-ng-show="show === 1">
            <!-- correct -->
            <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                <span class="yellow"><h3>Correct</h3></span>
                <hr class="correct yellow">
                
                <!--chest box for 5th question-->
                <div data-ng-if="<%=z %>%5 === 0">
                    <jsp:include page="gameChest.jsp"></jsp:include> 
                </div><!-- end of chest box for 5th question-->
                
                <!--star for every question except for the 5th-->
                <div data-ng-if="<%=z %>%5 !== 0">
                    <jsp:include page="reward_starcollect.jsp"></jsp:include>  
                </div><!--end of star for every question except for the 5th-->
                
            </div> <!-- end of correct answer-->
            <%
                z++;
            %>
                         
            <!-- incorrect -->
            <div data-ng-if="checkeds !== '<%=result.getString("checked")%>'">
                <h3>Incorrect</h3>
                <hr class="normal">
            </div> <!-- end of incorrect answer-->
        </div> <!-- end of check answer-->        
                        
        <!-- Show answer -->
        <div data-ng-show="show === 2">
            <div data-ng-if="'<%=result.getString("checked")%>'=== '1'">
                <b class="answer">Answer: <%=result.getString("input1")%></b>
            </div>
            <div data-ng-if="'<%=result.getString("checked")%>'=== '2'">
                <b class="answer">Answer: <%=result.getString("input2")%></b>
            </div>
        </div> <!-- end of showing answer-->      
        </center>         
                            </div> <!--end of User input for two choice selection-->
  
                        </div> <!--close container2-->
                    </td>
                </tr>    
        <%
            }
        %>
            </tbody>
        </table>
    </div>