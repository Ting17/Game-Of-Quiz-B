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
            Statement stmt,stm,st;
            ResultSet result,res,rs;
            Integer quizID, a=1, b=1, c=1;
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
   
                    stm = conn.createStatement();
                    rs = stm.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
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
                <div class="col-xs-7 col-md-7 col-lg-7 title"><!--1.1.1.1--> 
                    <p>"The purpose of the quiz is not to shame or embarrass anyone, but to make sure everyone is on the same page"</p>
                </div>
                
                <div class="col-xs-2 col-md-2 col-lg-2"><!--1.1.1.2--> 
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
                </div> <!--close column 1.1.1.2-->
                
                <!--Translate function; google traslate-->
                <div class="col-xs-3 col-md-3 col-lg-3"> <!--1.1.1.3-->
                    <div id="google_translate_element"></div>
                    <script type="text/javascript">
                    function googleTranslateElementInit() {
                      new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
                    }
                    </script>
                    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
                </div><!--close column 1.1.1.3 & end of translate function/google translate-->
            </div> <!--close row 1.1.1-->
        </div> <!--close column 1.1-->
    </div> <!--close row 1-->    
    
    <div class="navvideo">
            <ul class="videoquizmenu">
              <li class="playmore"><a href="video2.jsp">Video Quiz</a></li>
              <li class="checkscore"><a data-toggle="modal" data-target="#ascore" >Check Accumulated Score</a></li>
            <!-- Modal -->
            <%  
                rs.previous();
                if (rs.next()) {
            %>        
                <div class="modal fade" id="ascore" role="dialog">
                <div class="modal-dialog">
                <div class="modal-content modalbg">
                    <!--Content-->
                    <div class="estrellas">
                        <span class="glyphicon glyphicon-star yellow"></span>
                        <span class="glyphicon glyphicon-star yellow"></span>
                        <span class="glyphicon glyphicon-star yellow"></span>
                        <span class="glyphicon glyphicon-star yellow"></span>
                        <span class="glyphicon glyphicon-star yellow"></span>
                        <span class="glyphicon glyphicon-star yellow"></span>
                        <span class="glyphicon glyphicon-star yellow"></span>
                    </div>   
                    <center class="ascore">
                        <h3><b><%=rs.getString("username")%></b></h3>
                        <br/>
                        <h4>You have collected</h4>
                        <h2 class="yellow"><%=rs.getString("result")%> Stars</h2>
                        <br/>
                        <p><i>**Collect more star as token for future event**</i></p>
                        <button class="btn btn-default btn-lg btn-block" data-dismiss="modal">Ok!</button> <br/>
                    </center> 
                </div>
                </div>
                </div> <!--close modal-->
            <%
                }
            %>              
              <li class="announcement"><a href="announ.jsp?videoID=0">Announcement</a></li>
            </ul>
       </div>
    
<div class="container">
        <%  
            if (res.next()) {
        %>
  
    <div class="row"><!--2-->
        <div class="col-xs-12 col-md-8 col-lg-8 videoquestion "><!--3.1-->
            <ol class="breadcrumb-arrow">
                <li><a href="video2.jsp">Home</a></li>
                <li><a onclick="history.back()" href="#">More Quiz</a></li>
                <li class="active"><span>Quiz Question</span></li>
            </ol>
        <%
            if(res.getString("note").isEmpty()){     
        %> 
        <div class="parallax title nonote">
            <center>Chill, will upload soon</center>
        </div>
        <%    
            }else{
        %>
        <p><%=res.getString("note") %></p>
        <%
            }
        %>              
        </div>
   
        <div class="col-xs-12 col-md-4 col-lg-4 videoquestion"><!--3.1-->
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
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1" ><!--2.2.2.1-->
                                            <a class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 1" data-ng-disabled="form1.$invalid" onClick="checkansSound()">Check</a>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2..2-->
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
                <div data-ng-if="<%=a %>%5 === 0">
                    <button class="chestbtn" onclick="changeImage1()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange1" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage2()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange2" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage3()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange3" src="resources/img/chestclosed.png"></button>

                    <div data-ng-if="btnclicked === 3" class="chestreward">
                    <%
                        Random rand = new Random();
                        int n1 = rand.nextInt(3)+1;
                        int n2 = rand.nextInt(3)+1;
                        int n3 = rand.nextInt(3)+1;

                        if(n1==1){
                    %>
                        <a href="bonus.jsp" class="btnbonus">Game Time!!</a>
                    <% 
                        } if(n1==2){
                    %>
                        <jsp:include page="starcollect3.jsp"></jsp:include>
                    <% 
                        } if(n1==3){
                    %>
                        <p>Too bad. Try Again Next Time</p>
                    <% 
                        }
                    %>
                    </div> 
                </div><!-- end of chest box for 5th question-->
                
                <!--star for every question except for the 5th-->
                <div data-ng-if="<%=a %>%5 !== 0">
                    <jsp:include page="starcollect.jsp"></jsp:include>  
                </div><!--end of star for every question except for the 5th-->
                
            </div> <!-- end of correct answer-->
            <%
                a++;
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
                                    
                                    <center>
                                        <h4>Answer:</h4>
                                        <input type="text" name="answer" data-ng-model="checkeds" size="40%" required/>
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
                <hr class="correct yellow">
                
                <!--chest box for 5th question-->
                <div data-ng-if="<%=b %>%5 === 0">
                    <button class="chestbtn" onclick="changeImage1()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange1" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage2()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange2" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage3()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange3" src="resources/img/chestclosed.png"></button>

                    <div data-ng-if="btnclicked === 3" class="chestreward">
                    <%
                        Random rand2 = new Random();
                        int m1 = rand2.nextInt(3)+1;
                        int m2 = rand2.nextInt(3)+1;
                        int m3 = rand2.nextInt(3)+1;

                        if(m1==1){
                    %>
                        <a href="bonus.jsp" class="btnbonus">Game Time!!</a>
                    <% 
                        } if(m1==2){
                    %>
                        <jsp:include page="starcollect3.jsp"></jsp:include>
                    <% 
                        } if(m1==3){
                    %>
                        <p>Too bad. Try Again Next Time</p>
                    <% 
                        }
                    %>
                    </div> 
                </div><!-- end of chest box for 5th question-->
                
                <!--star for every question except for the 5th-->
                <div data-ng-if="<%=b %>%5 !== 0">
                    <jsp:include page="starcollect.jsp"></jsp:include>  
                </div><!--end of star for every question except for the 5th-->
                
            </div> <!-- end of correct answer-->
            <%
                b++;
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
                            </div> <!--end of Fill in the Blank -->

                            <!-- User input for two choice selection -->
                            <div data-ng-if="'<%=result.getString("type")%>' === '2C'">
                                <form name="form3">
                                    <div class="col-xs-6 col-md-6 col-lg-6 "><!--2.2.1.1--> 
                                        <label for="A">
                                            <input type="radio" data-ng-model="checkeds" value="A" id="A" name="multiradio" required/> <%=result.getString("input1") %>
                                        </label>
                                    </div>
                                    <div class="col-xs-6 col-md-6 col-lg-6"><!--2.2.1.2--> 
                                        <label for="B">
                                            <input type="radio" data-ng-model="checkeds" value="B" id="B" name="multiradio" /> <%=result.getString("input2") %>
                                        </label>
                                    </div>
                                    <div class="row"><!--2.2.1-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--2.2.1.1--> 
                                            <button class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 1" data-ng-disabled="form3.$invalid" onClick="checkansSound()">Check</button>
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
                <hr class="correct yellow">
                
                <!--chest box for 5th question-->
                <div data-ng-if="<%=c %>%5 === 0">
                    <button class="chestbtn" onclick="changeImage1()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange1" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage2()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange2" src="resources/img/chestclosed.png"></button>
                    <button class="chestbtn" onclick="changeImage3()" data-ng-click="btnclicked = 3"><img id="imgClickAndChange3" src="resources/img/chestclosed.png"></button>

                    <div data-ng-if="btnclicked === 3" class="chestreward">
                    <%
                        Random rand3 = new Random();
                        int o1 = rand3.nextInt(3)+1;
                        int o2 = rand3.nextInt(3)+1;
                        int o3 = rand3.nextInt(3)+1;

                        if(o1==1){
                    %>
                        <a href="bonus.jsp" class="btnbonus">Game Time!!</a>
                    <% 
                        } if(o1==2){
                    %>
                        <jsp:include page="starcollect3.jsp"></jsp:include>
                    <% 
                        } if(o1==3){
                    %>
                        <p>Too bad. Try Again Next Time</p>
                    <% 
                        }
                    %>
                    </div> 
                </div><!-- end of chest box for 5th question-->
                
                <!--star for every question except for the 5th-->
                <div data-ng-if="<%=c %>%5 !== 0">
                    <jsp:include page="starcollect.jsp"></jsp:include>  
                </div><!--end of star for every question except for the 5th-->
                
            </div> <!-- end of correct answer-->
            <%
                c++;
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
        </div> <!--close column 3.1-->
    </div> <!--close row 3-->

    <div class="row wrap"><!--3--> 
        <!--video description and transcript-->
        <div class="col-xs-12 col-md-8 col-lg-8 contentborder"><!--3.1-->
            <div class="row"><!--3.1.1--> 
                <div class="col-xs-12 col-md-12 col-lg-12 interwrap"><!--3.1.1.1--> 
                    <h3>Quiz: <%=res.getString("quizTopic")%></h3>
                    <h5>Category << <%=res.getString("category") %> >></h5>
                    <hr/>
                </div><!--close column 3.1.1.1--> 
            </div><!--close row 3.1.1-->  
            
            <div class="row"><!--3.1.2--> 
                <div class="col-xs-12 col-md-12 col-lg-12 wrap2"><!--3.1.2.1--> 
                    <p class="">DESCRIPTION</p>        
                    
                </div> <!--close column 3.1.2.1--> 
            </div> <!--close row 3.1.2--> 
        </div> <!--end of video description and transcript and end of column 3.1-->
        <%
           }
        %>
        <div class="col-xs-12 col-md-4 col-lg-4 contentborder link"><!--3.2--> 
            <a href="video2.jsp" class="redbtn buttonlayout"><span>Back to Main Video Page</span></a>
            <a data-toggle="collapse" data-target="#addfeedback" class="bluebtn buttonlayout"><span>Feedback</span></a> 
        </div> <!--close column 3.2-->
    </div> <!--close row 3-->
                  
    <div class="row wrap"><!--4-->
        <!--more video-->
        <div class="col-xs-12 col-md-8 col-lg-8 contentborder"><!--4.1--> 
            <div class="row"><!--4.1.1--> 
                <div class="col-xs-12 col-md-12 col-lg-12 interwrap"><!--4.1.1.1-->
                    <!--Future purpose; anything can be add here-->
                </div> <!--close column 4.1.1.1--> 
            </div> <!--close row 4.1.1--> 
            
        </div><!--end of more video & end column 4.1--> 
        
        <!--feedback form-->
        <div class="col-xs-12 col-md-4 col-lg-4 contentborder link"><!--4.2-->
            <div class="row"><!--4.2.1--> 
                <div class="col-xs-12 col-md-12 col-lg-12 interwrap"><!--4.2.1.1-->
                    <hr class="normal">
                    <center>
                        <h4>Game of Quiz</h4>
                    </center>
                    <br/>
                </div> <!--close column 4.2.1.1--> 
            </div> <!--close row 4.2.1--> 
            <div class="row"><!--4.2.2--> 
                <div class="col-xs-12 col-md-12 col-lg-12"><!--4.2.2.1--> 
                    <center>
                        <div id="addfeedback" class="collapse">  
                            <form id="addForm" action="" method="POST"> 
                                <h5>FEEDBACK<h5/><hr/>
                                <p>Just comment. We listen.</p>
                                <textarea name="txtfeedback"></textarea><br/><br/>
                                <button type="submit" name="btnAdd">Submit</button>
                            </form>
                        </div>
                    </center>
                </div> <!--close column 4.2.2.1--> 
            </div> <!--close row 4.2.2--> 
          <div class="row"><!--4.2.1--> 
                <div class="col-xs-12 col-md-12 col-lg-12 interwrap"><!--4.2.1.1-->
                    
                    <hr class="normal">
                </div> <!--close column 4.2.1.1--> 
            </div> <!--close row 4.2.1--> 
        </div><!--end of feedback form & end column 4.2-->
    </div><!--close row 4--> 
</div> <!--close container-->   
        
                
<jsp:include page="footer.jsp"></jsp:include>
            