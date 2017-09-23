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
            Connection c;
            Statement s;
            ResultSet r;
            Integer vID;
        %>

        <%-- read function --%>    
        <%
            
            vID = Integer.parseInt(request.getParameter("id"));
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                s = c.createStatement();
                r = s.executeQuery("SELECT * FROM question WHERE videoID = '"+vID +"' LIMIT 5");
                
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
            while(r.next() ) {
             
        %>
                <tr>   
                    <td>
                        <!--display quiz question-->
                        <div id="<%=r.getInt("questionID") %>" class="questioncontainer">
                            <h4><%=r.getString("question") %></h4>
                        </div> 

                        <div class="container2">
                            <!-- Format for multiple choice -->
                            <div data-ng-if="'<%=r.getString("type")%>' === 'M'">
                                <form name="form1">
                                    <div class="row"><!--1.2.1.2.1--> 
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice "><!--1.2.1.2.1.1--> 
                                            <label for="A">
                                                A <input type="radio" data-ng-model="checkeds" value="A" id="A" name="multiradio" required/> <%=r.getString("input1") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--1.2.1.2.1.2--> 
                                            <label for="B">
                                                B <input type="radio" data-ng-model="checkeds" value="B" id="B" name="multiradio" /> <%=r.getString("input2") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--1.2.1.2.1.3--> 
                                            <label for="C">
                                                C <input type="radio" data-ng-model="checkeds" value="C" id="C" name="multiradio" /> <%=r.getString("input3") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--1.2.1.2.1.4--> 
                                            <label for="D">
                                                D <input type="radio" data-ng-model="checkeds" value="D" id="D" name="multiradio" /> <%=r.getString("input4") %>
                                            </label>
                                        </div>
                                    </div> <!--close row 1.2.1.2.1-->
             
                                    <!-- button -->   
                                    <div class="row button"><!--1.2.1.2.2-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1" ><!--1.2.1.2.2.1-->
                                            <a  class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 2; count = count+1" data-ng-init="0" data-ng-disabled="form1.$invalid" onClick="checkansSound()">Check</a>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--1.2.1.2.2.2-->
                                            <a class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 3" onClick="giveupSound()">Give Up</a>
                                        </div> 
                                    </div> <!--close row 1.2.1.2.2--> 
                                </form>                                  
                <center>                    
                <!-- check answer-->
                <div data-ng-show="show === 2">
                    <!-- correct -->
                    <div data-ng-if="checkeds === '<%=r.getString("checked")%>'" >
                        <span class="yellow"><h3>Correct</h3></span>
                        <hr class="correct">
                    </div>
                                
                    <!-- incorrect -->
                    <div data-ng-if="checkeds !== '<%=r.getString("checked")%>'">
                        <h3>Incorrect</h3>
                        <hr class="normal">
                    </div> 
                </div>
                        
                <!-- Show answer -->
                <div data-ng-show="show === 3">
                    <b class="answer">Answer: <%=r.getString("checked")%></b>
                </div> 
                
                </center> 
                            </div> <!--end of multiple choice format-->
                            
                            
                            <!-- Format for Fill in the Blank -->
                            <div data-ng-if="'<%=r.getString("type")%>' === 'B'">
                                <ul class="answercontainer">
                                    <li>
                                        <span><%=r.getString("input1") %></span>
                                        <span class="tabq"><%=r.getString("input2") %></span>
                                        <span class="tabq"><%=r.getString("input3") %></span>
                                        <span class="tabq"><%=r.getString("input4") %></span>
                                    </li>
                                </ul>
                            </div> <!--end of fill in blank format-->

                            
                            <!-- User input for Fill in the Blank & True False -->
                            <div data-ng-if="'<%=r.getString("type")%>' === 'B' || '<%=r.getString("type")%>' === 'T'">
                                <form name="form2">
                                    <div class="useranswer">
                                        <h4>Answer:</h4>
                                        <input type="text" name="answer" data-ng-model="checkeds" required/>
                                    </div>
                                                                                  
                                    <div class="row"><!--1.2.1.2.1-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--1.2.1.2.1.1--> 
                                            <button class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 2; count = count+1" data-ng-init="0" data-ng-disabled="form2.$invalid" onClick="checkansSound()">Check</button>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--1.2.1.2.1.2-->
                                            <button class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 3" onClick="giveupSound()">Give Up</button>  
                                        </div> 
                                    </div> <!--close row 1.2.1.2.1-->                 
                                </form>
                
                <center>                    
                <!-- check answer-->
                <div data-ng-show="show === 2">
                    <!-- correct -->
                    <div data-ng-if="checkeds === '<%=r.getString("checked")%>'" >
                        <span class="yellow"><h3>Correct</h3></span>
                        <hr class="correct">

                    </div>
                                
                    <!-- incorrect -->
                    <div data-ng-if="checkeds !== '<%=r.getString("checked")%>'">
                        <h3>Incorrect</h3>
                        <hr class="normal">
                    </div> 
                </div>
                        
                <!-- Show answer -->
                <div data-ng-show="show === 3">
                    <b class="answer">Answer: <%=r.getString("checked")%></b>
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
            
            
            
      