<%-- 
    Document   : Uguide
    Created on : Oct 26, 2017, 11:49:11 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Guide</title>
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
            Statement stmt, st, stm;
            ResultSet result, rs;
            Integer announ, videoID;
            String username, password;
            Boolean check = false;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("videoID") != null){
                videoID = Integer.parseInt(request.getParameter("videoID"));
                check = false;
            }else{
                check = true;
            }
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM announcement");
              
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");       
                 
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            } 
        %>
        
<script src="frameworks/js/paginationMethod1.js"></script> 
        
    <%  
        if (rs.next()) {
    %>
    <div class="row" id="top"><!--1-->
        <div class="col-xs-12 col-md-12 col-lg-12 banner"><!--1.1-->
            <div class="row">
                <div class="col-xs-12 col-md-10 col-lg-10"><h3>EQUILIBRA</h3></div>
                <div class="col-xs-12 col-md-1 col-lg-1">
                    <a>HI  <%=rs.getString("username")%></a>
                    <div id="google_translate_element"></div>
                    <script type="text/javascript">
                    function googleTranslateElementInit() {
                      new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
                    }
                    </script>
                    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
                </div>
                <div class="col-xs-12 col-md-1 col-lg-1"><a href='index.jsp'>Log out</a></div>
            </div>  
        </div><!--end column 1.1-->
    </div><!--end row 1 & end of navigation-->
    <%
        }else  {
            response.sendRedirect("index.jsp");
        }
    %>   

    <!--Game of Quiz menu bar-->
    <div class="row"><!--2 a-->
        <div class="col-xs-12 col-md-12 col-lg-12"><!--2.1 a-->
            <nav class="navbar menu borderbottom">
                <div class="container-fluid">
                    <div class="navbar-header"> 
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-to-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button> 
                    </div> 
  
                    <div class="navbar-collapse collapse" id="navbar-to-collapse">
                        <ul class="nav nav-justified">
                            <li><a href="video2.jsp">EQUILIBRA Home</a></li>
                            <li><a href="quizlist_user.jsp">Quiz List</a></li>
                            <li><a data-toggle="modal" data-target="#ascore" >Check Total Score</a></li>
                            <li><a href="announ.jsp">Announcement</a></li>
                            <li class="active"><a href="Uguide.jsp">User Guide</a></li>
                        </ul> 
                    </div><!--end navigation collapse-->        
                </div><!--close container-fluid-->
            </nav>
        </div><!--end column 2.1 a-->
    </div><!--end of Game of Quiz menu bar & row 2 a-->
   
    <jsp:include page="checkscore.jsp"></jsp:include>       
    
    <div class="container ">   
        <!--Content section-->
        <div class="row"><!--2-->
            <div class="col-xs-12 col-md-9 col-lg-9 videoquestion contentborder"><!--2.1-->
                <ol class="breadcrumb breadcrumb-arrow">
                    <li><a href="video2.jsp">EQUILIBRA Home</a></li>
            <%
                if(check == false){
                    
                if(videoID ==0){
            %>
                    <li><a onclick="history.back()" href="#">Quiz without Video</a></li>
            <%
                } else{
            %>
                    <li><a onclick="history.back()" href="#">Video Quiz</a></li>
            <%
                }}
            %>
                    <li class="active"><span>User Guide</span></li>
                </ol>
             
                <div class="guide">
                    <h3><b>User Guide</b></h3>
                    <p>We encourage you to <span class="yellow">explore</span> around. So here is some basic guide to experience Game Of Quiz.</p>
                    
                    <a data-toggle="collapse" data-target="#1" ><h4>Step 1 Chose your topic</h4></a>
                    <div id="1" class="collapse">
                        <hr/>
                        <p>1. You can choose quizzes based on video in <b>Equilibra home page<b> or either quiz with video or quiz without video in <b>Quiz List page</b>.</p>
                        <p>2. In <b>Quiz List page</b> <span class="glyphicon glyphicon-facetime-video"></span> represent the quiz with video.</p>        
                        <hr class="hreffect"/>
                    </div><!--close collapse--> 
                
                    <a data-toggle="collapse" data-target="#2"><h4>Step 2 Look for instructions/rules</h4></a>
                    <div id="2" class="collapse"> 
                        <hr/>
                        <p>1. Look for Pusheen for instructions/rules <img src="resources/img/cat.gif"/></p>
                        <p>2. Read the note to know how to collect star and claim "game time".</p>
                        <p>3. Stars will be your token for future event; "game time" is for your minute break.</p>
                        <hr class="hreffect"/>
                    </div><!--close collapse--> 
                
                    <a data-toggle="collapse" data-target="#3"><h4>Step 3 Sent your feedback based on quiz you attend <i>(optional)</i></h4></a>
                    <div id="3" class="collapse"> 
                        <hr/>
                        <p>1. Look for feedback button under Pusheen <img src="resources/img/cat.gif"/></p>
                        <p>2. Click it and feedback form will show just right below it.</p>
                        <p>3. Submit your feedback based on the quiz you attending <u>ONLY</u>. You can write anything. Eg: Error/mistake found</p>
                        <hr class="hreffect"/>
                    </div><!--close collapse-->
                
                    <a data-toggle="collapse" data-target="#4"><h4>Step 4 Attend other quizzes or watch other videos else Logout your account</h4></a>
                    <div id="4" class="collapse">
                        <hr/>
                        <p>1. You are encourage to attend other quizzes or other videos to gain more knowledge or as entertainment</p>
                        <p>2. Related video and video quizzes are sort based on category you currently answering. It is located right on top of footer (You can find it easily, for sure). You can watch related video or answer related video quiz.</p>
                        <p>3. Remember to Logout your account. Make it as a practice. You can logout through <b>Equilibra home page</b>, <b>Quiz list page</b>, <b>Announcement page</b> or <b>this page (User Guide).</b></p>
                        <hr class="hreffect"/>
                    </div><!--close collapse--> 
                </div>  
            </div> <!--close column 2.1-->
                
            <div class="col-xs-12 col-md-3 col-lg-3 contentborder link"><!--2.2--> 
                <center>
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
                <%
                    if(check == false){
                %>
                    <a onclick="history.back()" class="redbtn buttonlayout"><span>Back</span></a>
                <%
                    }
                %>
            </center>
            </div> <!--close column 2.2-->
        </div><!--close row 2-->      
    </div> <!--end container--> 
        
    <jsp:include page="footer.jsp"></jsp:include>