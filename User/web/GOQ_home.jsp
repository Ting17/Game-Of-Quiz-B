<%-- 
    Document   : GOQ_home
    Created on : Aug 25, 2017, 6:15:26 PM
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
<title>Game of Quiz Home</title>
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
            Statement stmt,st;
            ResultSet result,rs; 
            String username,password;
            Integer quizID, videoID, announceID; 
            Boolean check = false, check2 = false;
        %>
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            if(request.getParameter("videoID") != null){
                videoID = Integer.parseInt(request.getParameter("videoID"));
                check = false;
            }else{
                check = true;
            }
            if(request.getParameter("announceID") != null){
                announceID = Integer.parseInt(request.getParameter("announceID"));
                check2 = false;
            }else{
                check2 = true;
            }
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM quiz");
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
            
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            }
        %>
        
    <%  
        if (rs.next()) {
    %>
        <div class="row" id="top"><!--1-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.1-->
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <h3>Game of Quiz Quiz area</h3>
                        </div>

                        <div class="navbar-header"> 
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-to-collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button> 
                        </div>

                        <div class="navbar-collapse collapse" id="navbar-to-collapse">
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="">HI  <%=rs.getString("username")%></a></li>
                                <li><a href='index.html'>Log out</a></li>
                            </ul> 
                        </div><!--end navigation collapse-->        
                    </div><!--close container-->
                </nav>
            </div><!--end column 1.1-->
        </div><!--end row 1 & end of navigation-->
    <%
        }else  {
            out.println(request.getAttribute("errorMessage"));
        response.sendRedirect("index.html");
        }
    %>   
       
    <div class="row subject"><!--2 a-->
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.1 a-->
            <a onclick="show('divEng')"><h4 >English</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.2 a-->
            <a><h4>Mathematic</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.3 a-->
            <a><h4>History</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.4 a-->
            <a onclick="show('divBio')"><h4>Biology</h4></a>
        </div>           
    </div><!--end row 2-->
    
    <div class="row navvideo"><!--2 b-->
        <div class="col-xs-12 col-md-12 col-lg-12"><!--2.1 b-->
            <ul>
                <li><a href="video2.jsp">EQUILIBRA Home</a></li>
                <li class="active"><a href="GOQ_home.jsp">More Quiz</a></li>
                <li><a data-toggle="modal" data-target="#ascore" >Check Accumulated Score</a></li>
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
                <li><a href="announ.jsp">Announcement</a></li>
                <li><a href="Uguild.jsp">User Guild</a></li>
            </ul>
        </div><!--end column 2.1 b-->
    </div><!--end row 2 b-->
    
    <div class="container">

    <div class="row"><!--3--> 
        <div class="col-xs-12 col-md-8 col-lg-8 contentborder quizlist videoquestion"> <!--3.1--> 
            <ol class="breadcrumb breadcrumb-arrow">
                <li><a href="video2.jsp">EQUILIBRA Home</a></li>
            <%
                if(check == false){

                if(videoID == 0){
            %>
                <li><a onclick="history.back()" href="#">Quiz without Video</a></li>
            <%
                } else{
            %>
                <li><a onclick="history.back()" href="#">Video Quiz</a></li>
            <%
                }}
                if(check2 == false) {
            %>
                <li><a onclick="history.back()" href="#">Announcement</a></li>
            <%
                }
            %>
                <li class="active"><span>More Quiz</span></li>
            </ol>
                
            <div class="table-responsive">
                <table class="table table-stripped table-hover sortable">
                    <thead>
                        <tr>
                            <th id="quiz" scope="col">Quiz Without Video</th>
                        </tr>
                    </thead>                      
                    <tbody>   
                    <%  
                        while(result.next()) {
                            quizID = result.getInt("quizID");
                    %>
                        <tr>
                            <td headers="quiz" class="quiz">
                        <%  
                            if(result.getInt("videoID") != 0){
                        %>
                        <a href="quiz_page.jsp?videoID=0&quizID=<%=quizID%>&categ=<%=result.getString("category")%>" title="<%=result.getString("category") %>" class="playmque"><span class="glyphicon glyphicon-facetime-video"> <%=result.getString("quizTopic") %></span></a>
                        <% 
                            }else{
                        %>
                            <a href="quiz_page.jsp?videoID=<%=result.getInt("videoID")%>&quizID=<%=quizID%>&categ=<%=result.getString("category")%>" title="<%=result.getString("category") %>" class="playmque"><span><%=result.getString("quizTopic") %></span></a>
                        <% 
                            }
                        %>
                            </td>
                        </tr>
                    <%
                        }
                    %>    
                    </tbody>  
                </table>       
            </div>   
        </div> <!--end column 3.1-->
              
        <div class="col-xs-12 col-md-4 col-lg-4 contentborder link"> <!--3.2--> 
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
        </div><!--close column 3.2-->
    </div> <!--close row 3-->
    </div> <!--close container-->
                                   

<jsp:include page="footer.jsp"></jsp:include>