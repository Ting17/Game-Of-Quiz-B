<%-- 
    Document   : EQ_home
    Created on : Jul 23, 2017, 10:55:23 AM
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
<title>EQUILIBRA</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<scriptvideowrap src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body>
        <%!
            Connection conn;
            Statement stmt,st,st2,st3,st4,st5,st6;
            ResultSet resultBio,resultQBio,resultEng,resultQEng,resultSci,resultQSci,rs;
            String username,password, videoID;
            Integer userID;
            Boolean check = false;
        %>

    <%-- login function & read function for videos--%>    
    <%
        username = request.getParameter("username");    
        password = request.getParameter("password");
        session.setAttribute("uname",username);
        session.setAttribute("pass",password);
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            
            st=conn.createStatement();
            resultQBio = st.executeQuery("SELECT * FROM quiz");
            
            st2=conn.createStatement();
            resultQEng = st2.executeQuery("SELECT * FROM quiz");
            
            st3=conn.createStatement();
            resultQSci = st3.executeQuery("SELECT * FROM quiz");
            
            st4=conn.createStatement();
            resultBio = st4.executeQuery("SELECT * FROM video WHERE category = 'Biology'");
            
            st5=conn.createStatement();
            resultEng = st5.executeQuery("SELECT * FROM video WHERE category = 'English'");
            
            st6=conn.createStatement();
            resultSci = st6.executeQuery("SELECT * FROM video WHERE category = 'Science & Techn'");
            
            stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
 
        }catch(ClassNotFoundException cnfe){
            out.println("Class not Found Execption:-" + cnfe.toString());
        }catch(SQLException sqle){
            out.println("SQL Query Exception:- " + sqle);
        }     
        
        if (rs.next()) {
    %>
    <div class="row" id="top"><!--1-->
        <div class="col-xs-12 col-md-12 col-lg-12 banner"><!--1.1-->
            <div class="row">
                <div class="col-xs-12 col-md-10 col-lg-10"><h3>EQUILIBRA</h3></div>
                <div class="col-xs-12 col-md-1 col-lg-1"><a>HI  <%=rs.getString("username")%></a></div>
                <div class="col-xs-12 col-md-1 col-lg-1"><a href='index.jsp'>Log out</a></div>
            </div>
        </div><!--end column 1.1-->
    </div><!--end row 1 & end of navigation-->
    <%
        }else  {
            String msg="Incorrect username or password";
            request.getSession().setAttribute("msg", msg);
            response.sendRedirect("index.jsp");
        }
    %>  
    
    <!--Game of Quiz menu bar-->
    <div class="row"><!--2 a-->
        <div class="col-xs-12 col-md-12 col-lg-12"><!--2.1 a-->
            <nav class="navbar menu">
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
                            <li class="active"><a href="video2.jsp">EQUILIBRA Home</a></li>
                            <li><a href="quizlist_user.jsp">Quiz List</a></li>
                            <li><a data-toggle="modal" data-target="#ascore" >Check Total Score</a></li>    
                            <li><a href="announ.jsp">Announcement</a></li>
                            <li><a href="Uguide.jsp">User Guide</a></li>
                        </ul> 
                    </div><!--end navigation collapse-->        
                </div><!--close container-fluid-->
            </nav>
        </div><!--end column 2.1 a-->
    </div><!--end of Game of Quiz menu bar & row 2 a-->
    
    <jsp:include page="checkscore.jsp"></jsp:include>  
    
    <!--subject/category-->
    <div class="row subject borderbottom"><!--2 b-->
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.1 b-->
            <a onclick="show('divEng')"><h4>English</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.2 b-->
            <a><h4>Mathematic</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.3 b-->
            <a onclick="show('divSci')"><h4>Technology</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.4 b-->
            <a onclick="show('divBio')"><h4>Biology</h4></a>
        </div>     
    </div><!--end of subject/category row 2 b-->
    
    <!--Content section-->
    <div class="container">    
        <div class="row"><!--3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--3.1-->
                <div id="divBio">
                <h2>Biology</h2>
            <%
                while(resultBio.next() && (resultBio.getString("category").equalsIgnoreCase("biology"))) {
            %>
                <div class="videowrap">       
                    <div class="row"><!--3.1.1-->
                        <div class="col-xs-12 col-md-4 col-lg-4"><!--3.1.1.1-->
                            <iframe src="<%=resultBio.getString("videoPath")%>" frameborder="0" allowfullscreen></iframe>
                        </div> <!--close column 3.1.1.1-->

                        <div class="col-xs-12 col-md-6 col-lg-6"><!--3.1.1.2-->
                            <h3><%=resultBio.getString("videoName") %></h3>
                            <p><%=resultBio.getString("videoDesc") %></p>
                        </div> <!--close column 3.1.1.2-->
                <%
                    check=false;
                    while(resultQBio.next()) {
                        videoID = resultQBio.getString("videoID");
                        if(resultBio.getString("videoID").equals(videoID)) {
                            check=true;    
                            break;
                        }
                    }   
                    if(check == true){
                %>
                        <div class="col-xs-12 col-md-2 col-lg-2 quizplay"><!--3.1.1.3-->
                            <a href="quiz_page.jsp?videoID=<%=resultQBio.getString("videoID")%>&quizID=<%=resultQBio.getString("quizID")%>&categ=<%=resultQBio.getString("category")%>" class="btn-lg btnplay">Play quiz</a>
                        </div> <!--close column 3.1.1.3-->
                <%
                    }
                %>
                    </div><!--end row 3.1.1-->
                </div><!--close videowrap-->
            <%
                }
            %>
                </div><!--end of divBio-->
                
                <div id="divEng">
                  <h2>English</h2>
            <%
                while(resultEng.next() && (resultEng.getString("category").equalsIgnoreCase("english"))) {
            %>
                <div class="videowrap">
                    <div class="row"><!--3.1.1-->
                        <div class="col-xs-12 col-md-4 col-lg-4"><!--3.1.1.1-->
                            <iframe src="<%=resultEng.getString("videoPath")%>" frameborder="0" allowfullscreen></iframe>
                        </div> <!--close column 3.1.1.1-->

                        <div class="col-xs-12 col-md-6 col-lg-6"><!--3.1.1.2-->
                            <h3><%=resultEng.getString("videoName") %></h3> 
                            <p><%=resultEng.getString("videoDesc") %></p>
                        </div> <!--close column 3.1.1.2-->         
                <%
                    check=false;
                    while(resultQEng.next()) {
                        videoID = resultQEng.getString("videoID");
                        if(resultEng.getString("videoID").equals(videoID)) {
                            check=true;    
                            break;
                        }
                    } 
                    if(check == true){
                %>
                        <div class="col-xs-12 col-md-2 col-lg-2 quizplay"><!--3.1.1.3-->
                            <a href="quiz_page.jsp?videoID=<%=resultQEng.getString("videoID")%>&quizID=<%=resultQEng.getString("quizID")%>&categ=<%=resultQEng.getString("category")%>" class="btn-lg btnplay">Play quiz</a>
                        </div> <!--close column 3.1.1.3-->
                <%
                    }
                %>
                    </div><!--end row 3.1.1-->
                </div><!--close video wrap-->
            <%
                }
            %>
                </div><!--end of divEng-->
                
                <div id="divSci">
                  <h2>Science & Technology</h2>
            <%
                while(resultSci.next() && (resultSci.getString("category").equalsIgnoreCase("science & techn"))) {
            %>
                <div class="videowrap">
                    <div class="row"><!--3.1.1-->
                        <div class="col-xs-12 col-md-4 col-lg-4"><!--3.1.1.1-->
                            <iframe src="<%=resultSci.getString("videoPath")%>" frameborder="0" allowfullscreen></iframe>
                        </div> <!--close column 3.1.1.1-->

                        <div class="col-xs-12 col-md-6 col-lg-6"><!--3.1.1.2-->
                            <h3><%=resultSci.getString("videoName") %></h3> 
                            <p><%=resultSci.getString("videoDesc") %></p>
                        </div> <!--close column 3.1.1.2-->
            
                <%
                    check=false;
                    while(resultQSci.next()) {
                        videoID = resultQSci.getString("videoID");
                        if(resultSci.getString("videoID").equals(videoID)) {
                            check=true;    
                            break;
                        }
                    }   
                    if(check == true){
                %>
                        <div class="col-xs-12 col-md-2 col-lg-2 quizplay"><!--3.1.1.3-->
                            <a href="quiz_page.jsp?videoID=<%=resultQSci.getString("videoID")%>&quizID=<%=resultQSci.getString("quizID")%>&categ=<%=resultQSci.getString("category")%>" class="btn-lg btnplay">Play quiz</a>
                        </div> <!--close column 3.1.1.3-->
                <%
                    }
                %>
                    </div><!--end row 3.1.1-->
                </div><!--close video wrap-->
            <%
                }
            %>
                </div><!--end of divSci-->
            </div><!--end column 3.1-->
        </div><!--end row 3--> 
    </div><!--close container--> 
    
    
<jsp:include page="footer.jsp"></jsp:include>