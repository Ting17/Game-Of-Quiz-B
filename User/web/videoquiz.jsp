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
            Statement stmt;
            ResultSet res;
            String category, username,password;
            Integer videoID; 
        %>

        <%-- READ function for question--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){  
                videoID = Integer.parseInt(request.getParameter("id"));
                category = request.getParameter("categ");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    stmt=conn.createStatement();
                    res = stmt.executeQuery("SELECT * FROM video WHERE videoID = '"+ videoID +"'");
       
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
                
                
                if(request.getParameter("btnAdd") != null){
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("INSERT INTO feedback(videoID, username, feedback, rdate) VALUES(?,?,?,NOW())");
                    pstmt.setInt(1,videoID);
                    pstmt.setString(2,username);
                    pstmt.setString(3,request.getParameter("txtfeedback"));
                    pstmt.executeUpdate();

                    response.sendRedirect("./videoquiz.jsp?id=" + videoID + "&categ=" + category);
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
                <div class="col-xs-12 col-md-8 col-lg-8 title"><!--1.1.1.1--> 
                    <p>"Push yourself because no one else is going to do it for you"</p>
                </div>
                
                <div class="col-xs-12 col-md-4 col-lg-4"><!--1.1.1.2--> 
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
    <div class="row"> <!--close row 1a-->
        <div class="col-xs-12 col-md-12 col-lg-12 right"> <!--close row 1a-->
            <div id="google_translate_element"></div>

            <script type="text/javascript">
            function googleTranslateElementInit() {
              new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
            }
            </script>

            <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
        </div>
    </div>
    
<div class="container">
        <%
            while(res.next() ) {
        %>
    <div class="row wrap"><!--2--> 
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
        </div> <!--close column 3.1-->

        <div class="col-xs-12 col-md-4 col-lg-4 contentborder link"><!--3.2--> 
            <a href="video2.jsp"><button class="btn btn-primary btn-1 icon-backward"><span>Back to Video</span></button></a>
            <a href="mquiz.jsp"><button class="btn btn-primary btn-1 icon-forward"><span>Play More Quiz</span></button></a>
            <a href="ascore.jsp"><button class="btn btn-primary btn-1 icon-forward"><span>Check Accumulated Score</span></button></a>
            <a href="#addfeedback" data-toggle="collapse" data-target="#addfeedback"><button class="btn btn-primary btn-2 icon-down"><span>Feedback</span></button></a>
            <a href="announ.jsp"><button class="btn btn-primary btn-1 icon-forward"><span>Announcement</span></button></a>

        </div> <!--close column 3.2-->
        <%
           }
        %>
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