<%-- 
    Document   : question
    Created on : Apr 29, 2017, 11:59:49 PM
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
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8;">
<title>Play</title>
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
            Statement stmt,stm;
            ResultSet res,rs;
            String category, username,password;
            Integer videoID, quizID; 
        %>

        <%-- READ function for question--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){  
                videoID = Integer.parseInt(request.getParameter("id"));
                quizID = Integer.parseInt(request.getParameter("quiz"));
                category = request.getParameter("categ");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    stmt=conn.createStatement();
                    res = stmt.executeQuery("SELECT * FROM video WHERE videoID = '"+ videoID +"'");
                    
                    stm = conn.createStatement();
                    rs = stm.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");

                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
                
                if(request.getParameter("btnAdd") != null){
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("INSERT INTO feedback(videoID, quizID, username, feedback, rdate) VALUES(?,?,?,?,NOW())");
                    pstmt.setInt(1,videoID);
                    pstmt.setInt(2,quizID);
                    pstmt.setString(3,username);
                    pstmt.setString(4,request.getParameter("txtfeedback"));
                    pstmt.executeUpdate();

                    response.sendRedirect("./videoquiz.jsp?id=" + videoID + "&quiz=" + quizID +"&categ=" + category);
                    }catch(ClassNotFoundException cnfe){
                        out.println("Class not Found Execption:-" + cnfe.toString());
                    }catch(SQLException sqle){
                        out.println("SQL Query Exception:- " + sqle);
                    }  
                }  
            }else{
                response.sendRedirect("./index.html");
            }
        %>
        
<script src="frameworks/js/paginationMethod.js"></script> 

    <div class="row" id="top"><!--1--> 
        <div class="col-xs-12 col-md-12 col-lg-12 parallax"> <!--1.1--> 
            <div class="row"><!--1.1.1--> 
                <div class="col-xs-7 col-md-7 col-lg-7 title"><!--1.1.1.1--> 
                    <p>"Push yourself because no one else is going to do it for you"</p>
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
                            <li><p>Answer the <b>Last</b> question correctly for game time!!!!</p></li>
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
    
<div class="container">    
    <div class="col-xs-12 col-md-12 col-lg-12 ">
        <ol class="breadcrumb breadcrumb-arrow">
                    <li><a href="video2.jsp">Home</a></li>
                    <li class="active"><span>Video Quiz</span></li>
            </ol>
    </div>
        <%
            while(res.next() ) {
        %>
    <div class="row vwrap"><!--2--> 
        <div class="col-xs-12 col-md-8 col-lg-8 videoquestion contentborder"><!--2.1--> 
            <video class="videoque" controls>
                <source src="<%=res.getString("videoPath")%>" type="video/mp4">
            </video>
        </div>
        
        <div class="col-xs-12 col-md-4 col-lg-4 videoquestion" ><!--2.2--> 
            <jsp:include page="videoquestion.jsp"></jsp:include>
        </div> 
    </div> <!--close row 2-->
    
    <div class="row wrap"><!--3--> 
        <div class="col-xs-12 col-md-8 col-lg-8 contentborder"><!--3.1--> 
            <h3><%=res.getString("videoName") %></h3>
            <h4>Category << <%=res.getString("category") %> >></h4>
            <hr/>
            <p class="videodesc"><%=res.getString("videoDesc") %></p>        
            <a data-toggle="collapse" data-target="#transcript"><button class="btn btn-default btn-sm right">Transcript</button></a>
            <div id="transcript" class="collapse">  
                <hr/>
               <p><%=res.getString("transcript") %></p>
            </div>
        </div> <!--close column 3.1-->
        <%
           }
        %>
        <div class="col-xs-12 col-md-4 col-lg-4 contentborder link"><!--3.2--> 
            <a href="video2.jsp" class="redbtn" id="buttonlayout"><span>Back to Main Video Page</span></a>
            <a href="mquiz.jsp" class="orangebtn" id="buttonlayout"><span>Play More Quiz</span></a>
            <a data-toggle="modal" data-target="#ascore" class="yellowbtn" id="buttonlayout"><span>Check Accumulated Score</span></a>
            <!-- Modal -->
            <%  
                if (rs.next()) {
            %>        
                <div class="modal fade" id="ascore" role="dialog">
                <div class="modal-dialog">
                <div class="modal-content">
                <center>
                    <h3><b><%=rs.getString("username")%></b></h3>
                    <br/>
                    <h4>You have collected</h4>
                    <h2 class="yellow"><%=rs.getString("result")%> Stars</h2>
                    <br/>
                    <p><i>**Collect more star as token for future event**</i></p>
                </center> 
                </div>
                </div>
                </div> <!--close modal-->
            <%
                }
            %>
            <a href="announ.jsp" class="greenbtn" id="buttonlayout"><span>Announcement</span></a>
            <a data-toggle="collapse" data-target="#addfeedback" class="bluebtn" id="buttonlayout"><span>Feedback</span></a> 
        </div> <!--close column 3.2-->
    </div> <!--close row 3-->
                  
    <div class="row wrap2"><!--4-->
        <!--more video-->
        <div class="col-xs-12 col-md-9 col-lg-9 contentborder"><!--4.1--> 
            <h4>Related Videos</h4>
            <center>
            <div id="myCarousel" class="carousel slide " data-interval="false">
          
            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="item active">
                   <jsp:include page="table.jsp"></jsp:include>
                </div>

                <div class="item">
                    <jsp:include page="table.jsp"></jsp:include>
                </div>  
                    
                <div class="item">
                    <jsp:include page="table.jsp"></jsp:include>
                </div>
            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
                <span class="sr-only">Next</span>
            </a>
            </div>
            </center>
        </div><!--end of more video & end column 4.1--> 
        
        <!--feedback form-->
        <div class="col-xs-12 col-md-3 col-lg-3 contentborder link"><!--4.2-->
            <hr class="normal">
            <center>
                <h4>Game of Quiz</h4>
                
                <div id="addfeedback" class="collapse">  
                    <form id="addForm" action="" method="POST"> 
                        <h5>FEEDBACK<h5/><hr/>
                        <p>Just comment. We listen.</p>
                        <textarea name="txtfeedback"></textarea><br/><br/>
                        <button type="submit" name="btnAdd">Submit</button>
                    </form>
                </div>
            </center>
            <hr class="normal">
        </div><!--end column 4.2-->
    </div><!--end of feedback form & end row 4--> 
  
</div> <!--close container--> 


<jsp:include page="footer.jsp"></jsp:include>