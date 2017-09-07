<%-- 
    Document   : mquestion
    Created on : Aug 27, 2017, 11:11:10 AM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html data-ng-app="myApp">
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>More Quiz Question</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />
<link href="frameworks/css/questionstyle.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body>

        <%!
            Connection conn;
            PreparedStatement pstmt;
            Statement stmt,st;
            ResultSet result,res;
            Integer quizID, a=1, b=1;
            String username,password; 
        %>

        <%-- read function --%>    
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
          
            if(request.getParameter("quizID") != null && request.getParameter("quizID")!= ""){  
                quizID = Integer.parseInt(request.getParameter("quizID"));
                
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    st = conn.createStatement();
                    res = st.executeQuery("SELECT * FROM quiz where quizID = '"+ quizID + "'"); 
                    
                    stmt = conn.createStatement();
                    result = stmt.executeQuery("SELECT * FROM question WHERE videoID = 0 AND quizID ='"+ quizID +"' ORDER BY RAND ( ) LIMIT 10");

                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }
            
            }
            
            if(request.getParameter("btnAdd") != null){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("INSERT INTO feedback(videoID, quizID, username, feedback, rdate) VALUES(?,?,?,?,NOW())");
                    pstmt.setString(1,request.getParameter("txtVideoID"));
                    pstmt.setInt(2,quizID);
                    pstmt.setString(3,username);
                    pstmt.setString(4,request.getParameter("txtfeedback"));
                    pstmt.executeUpdate();

                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }  
            }  
        %>

<script src="frameworks/js/paginationMethod.js"></script> 
    
    <div class="row"><!--1--> 
        <div class="col-xs-12 col-md-12 col-lg-12 parallax"> <!--1.1--> 
            <div class="row"><!--1.1.1--> 
                <div class="col-xs-8 col-md-8 col-lg-8 title"><!--1.1.1.1--> 
                    <p>"The purpose of the quiz is not to shame or embarrass anyone, but to make sure everyone is on the same page"</p>
                    <p class="right">- Mark Goulston</p>
                </div>
                
                <div class="col-xs-4 col-md-4 col-lg-4"><!--1.1.1.2--> 
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
                        <p><b>Cat's Advise:</b></p>
                        <ul>
                            <li><p>Answer the last question correctly to collect star.</p></li>
                            <li><p>Answer correctly click the CHECK button for exactly III times for bonus time!!!!</p></li>
                        </ul>
                        <br/>    
                        <div class="catpawn">
                        <img src="resources/img/catpawn.png">
                        </div>
                    </div>
                    </div>
                    </div> <!--close modal-->
                </div> <!--close column 1.1.1.2-->
            </div> <!--close row 1.1.1-->
        </div> <!--close column 1.1-->
    </div> <!--close row 1-->    
    
<div class="container">
    <!--breadcrumb-->
    <div class="row"><!--2-->
        <div class="col-xs-12 col-md-12 col-lg-12 "><!--2.1-->
        <%  
            if (res.next()) {
        %>
            <h3>Quiz: <%=res.getString("quizTopic")%></h3>
        <%
            }
        %>
        </div><!--end column 2.1-->
    </div><!--end row 2& end of breadcrumb-->
          
    <div class="row"><!--3-->
        <div class="col-xs-12 col-md-8 col-lg-8 "><!--3.1-->
            <div class="table-responsive">
                <table class="table table-stripped table-hover questiont" id="tablepaging">
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
                                </div> 

                                <div class="container2">
                                    <!-- Format for multiple choice -->
                                    <div data-ng-if="'<%=result.getString("type")%>' === 'M'">
                                        <form name="form1">
                                            <div class="row"><!--3.1.1--> 
                                                <div class="col-xs-12 col-md-12 col-lg-12 multichoice "><!--3.1.1.1-->
                                                    A <input type="radio" data-ng-model="checkeds" value="A" name="multiradio" required/> <%=result.getString("input1") %>
                                                </div>
                                                <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--3.1.1.2-->
                                                    B <input type="radio" data-ng-model="checkeds" value="B" name="multiradio" /> <%=result.getString("input2") %>
                                                </div>       
                                                <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--3.1.1.3--> 
                                                    C <input type="radio" data-ng-model="checkeds" value="C" id="C" name="multiradio" /> <%=result.getString("input3") %>
                                                </div>
                                                <div class="col-xs-12 col-md-12 col-lg-12 multichoice"><!--3.1.1.4--> 
                                                    D <input type="radio" data-ng-model="checkeds" value="D" id="D" name="multiradio" /> <%=result.getString("input4") %>
                                                </div>
                                            </div> <!--close row 3.1.1-->

                                            <!-- button -->   
                                            <div class="row button"><!--3.1.2-->
                                                <div class="col-xs-6 col-md-6 col-lg-6 full-width1" ><!--3.1.2.1-->
                                                    <a  class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 1; count = count+1" data-ng-init="0" data-ng-disabled="form1.$invalid" onClick="checkansSound()">Check</a>
                                                </div>
                                                <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--3.1.2.2-->
                                                    <a class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 2" onClick="giveupSound()">Give Up</a>
                                                </div> 
                                            </div> <!--close row 3.1.2--> 
                                        </form>                                  

                    <center>
                        <!-- check answer-->
                        <div data-ng-show="show === 1">
                            <!-- correct -->
                            <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                                <span class="yellow"><h3>Correct</h3></span>
                                <hr class="correct">

                                <div data-ng-if="<%=a %>%5 === 0">
                                    <jsp:include page="starcollect.jsp"></jsp:include>       
                        <%
                            a++;
                        %>          
                                </div>  
                                <div data-ng-if="count === 3 ">
                                    <a href="bonus.jsp" class="btnbonus">Bonus Time!!</a>
                                </div> 
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
                                                    <input type="text" name="answer" data-ng-model="checkeds" size="80%" required/>
                                                </center>
                                            </div>

                                            <div class="row"><!--3.1.1-->
                                                <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--2.2.1.1--> 
                                                    <button class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 1; count = count+1" data-ng-init="0" data-ng-disabled="form2.$invalid" onClick="checkansSound()">Check</button>
                                                </div>
                                                <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2.1.2-->
                                                    <button class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 2" onClick="giveupSound()">Give Up</button>  
                                                </div> 
                                            </div> <!--close row 3.1.1-->                 
                                        </form>
                    <center>
                        <!-- check answer-->
                        <div data-ng-show="show === 1">
                            <!-- correct -->
                            <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                                <span class="yellow"><h3>Correct</h3></span>
                                <hr class="correct">

                                <div data-ng-if="<%=b %>%5 === 0">
                                    <jsp:include page="starcollect.jsp"></jsp:include>       
                        <%
                            b++;
                        %>          
                                </div>  
                                <div data-ng-if="count === 3 ">
                                    <a href="bonus.jsp" class="btnbonus">Bonus Time!!</a>
                                </div> 
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
            
        </div> <!--close column 3.1-->
            
        <div class="col-xs-12 col-md-4 col-lg-4 contentborder link"> <!--3.2--> 
            <a href="mquiz.jsp"><button class="btn btn-primary btn-1 icon-backward"><span>Back to Quiz List</span></button></a>
            <a href="video2.jsp"><button class="btn btn-primary btn-1 icon-backward"><span>Back to Video</span></button></a>
            <a href="ascore.jsp"><button class="btn btn-primary btn-1 icon-forward"><span>Check Accumulated Score</span></button></a>
            <a href="#addfeedback" data-toggle="collapse" data-target="#addfeedback"><button class="btn btn-primary btn-2 icon-down"><span>Feedback</span></button></a>
        
         <!--feedback form-->
            <hr class="normal">
            <center>
                <h4>Game of Quiz</h4>
                <div id="addfeedback" class="collapse">  
                    <form id="addForm" action="" method="POST"> 
                        <h5>FEEDBACK<h5/><hr/>
                        <input type="hidden" name="txtVideoID" value="0"/> <br/><br/>
                        <p>Just comment. We listen.</p>
                        <textarea name="txtfeedback"></textarea><br/><br/>
                        <button type="submit" name="btnAdd">Submit</button>
                    </form>
                </div>
            </center>
            <hr class="normal"><!--end of feedback form-->
            
        </div><!--close column 3.2-->
    </div> <!--close row 3-->  
</div> <!--close container-->   
        
        
<jsp:include page="footer.jsp"></jsp:include>
            
            
      