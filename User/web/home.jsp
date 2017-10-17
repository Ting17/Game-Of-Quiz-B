<%-- 
    Document   : video
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
            Statement stmt,stm, st,st2,st3,st4;
            ResultSet result,resultq,resultq2,resultq3,rs;
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
            resultq = st.executeQuery("SELECT * FROM quiz");
            
            st2=conn.createStatement();
            resultq2 = st2.executeQuery("SELECT * FROM quiz");
            
            st3=conn.createStatement();
            resultq3 = st3.executeQuery("SELECT * FROM quiz");
            
            stm=conn.createStatement();
            result = stm.executeQuery("SELECT * FROM video");
            
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
                        <h3>EQUILIBRA</h3>
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
                            <li><a>HI  <%=rs.getString("username")%></a></li>
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
    
    <div class="row subject"><!--2-->
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.1-->
            <a onclick="show('divEng')"><h4 >English</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.2-->
            <a><h4>Mathematic</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.3-->
            <a onclick="show('divSci')"><h4>Technology</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.4-->
            <a onclick="show('divBio')"><h4>Biology</h4></a>
        </div>           
    </div><!--end row 2-->

    <div class="navvideo">
            <ul>
              <li class="playmore"><a href="mquiz.jsp">More Quiz</a></li>
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
              <li class="announcement"><a href="announ.jsp">Announcement</a></li>
            </ul>
       </div>
    
    <!--Content section-->
    <div class="container">    
        <div class="row"><!--3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--3.1-->
                <div id="divBio">
                <h2>Biology</h2>
            <%
                result.previous();
                while(result.next() && (result.getString("category").equalsIgnoreCase("biology"))) {
            %>
                <div class="videowrap">       
                    <div class="row"><!--3.1.1-->
                        <div class="col-xs-12 col-md-4 col-lg-4"><!--3.1.1.1-->
                            <video class="videopg" controls>
                                <source src="<%=result.getString("videoPath")%>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-12 col-md-6 col-lg-6"><!--3.1.1.2-->
                            <h3><%=result.getString("videoName") %></h3>
                            <p><%=result.getString("videoDesc") %></p>
                        </div>  
                <%
                    resultq.first();
                    check=false;
                    while(resultq.next()) {
                        videoID = resultq.getString("videoID");
                        if(result.getString("videoID").equals(videoID)) {
                            check=true;    
                            break;
                        }
                    }   
                    if(check == true){
                %>
                        <div class="col-xs-12 col-md-2 col-lg-2 quizplay"><!--3.1.1.3-->
                            <a href="videoquiz.jsp?id=<%=result.getInt("videoID")%>&quiz=<%=resultq.getString("quizID")%>&categ=<%=result.getString("category")%>" class="btn-lg btnplay">Play quiz</a>
                        </div>
                <%
                    }
                %>
                    </div><!--end row 3.1.1-->
                </div><!--close video wrap-->
            <%
                }
            %>
                </div><!--end of divBio-->
                
                <div id="divEng">
                  <h2>English</h2>
            <%
                result.previous();
                while(result.next() && (result.getString("category").equalsIgnoreCase("english"))) {
            %>
                <div class="videowrap">
                    <div class="row"><!--3.1.1-->
                        <div class="col-xs-12 col-md-4 col-lg-4"><!--3.1.1.1-->
                            <video class="videopg" controls>
                                <source src="<%=result.getString("videoPath") %>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-12 col-md-6 col-lg-6"><!--3.1.1.2-->
                            <h3><%=result.getString("videoName") %></h3> 
                            <p><%=result.getString("videoDesc") %></p>
                        </div>            
                <%
                    resultq2.first();
                    check=false;
                    while(resultq2.next()) {
                        videoID = resultq2.getString("videoID");
                        if(result.getString("videoID").equals(videoID)) {
                            check=true;    
                            break;
                        }
                    } 
                    if(check == true){
                %>
                        <div class="col-xs-12 col-md-2 col-lg-2 quizplay"><!--3.1.1.3-->
                            <a href="videoquiz.jsp?id=<%=result.getInt("videoID")%>&quiz=<%=resultq2.getString("quizID")%>&categ=<%=result.getString("category")%>" class="btn-lg btnplay">Play quiz</a>
                        </div>
                <%
                    }
                %>
                    </div><!--end row 1.2.3.1.1-->
                </div><!--close video wrap-->
            <%
                }
            %>
                </div><!--end of divEng-->
                
                <div id="divSci">
                  <h2>Science & Technology</h2>
            <%
                result.previous();
                while(result.next() && (result.getString("category").equalsIgnoreCase("science & techn"))) {
            %>
                <div class="videowrap">
                    <div class="row"><!--3.1.1-->
                        <div class="col-xs-12 col-md-4 col-lg-4"><!--3.1.1.1-->
                            <video class="videopg" controls>
                                <source src="<%=result.getString("videoPath") %>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-12 col-md-6 col-lg-6"><!--3.1.1.2-->
                            <h3><%=result.getString("videoName") %></h3> 
                            <p><%=result.getString("videoDesc") %></p>
                        </div>            
                <%
                    resultq3.first();
                    check=false;
                    while(resultq3.next()) {
                        videoID = resultq3.getString("videoID");
                        if(result.getString("videoID").equals(videoID)) {
                            check=true;    
                            break;
                        }
                    }   
                    if(check == true){
                %>
                        <div class="col-xs-12 col-md-2 col-lg-2 quizplay"><!--3.1.1.3-->
                            <a href="videoquiz.jsp?id=<%=result.getInt("videoID")%>&quiz=<%=resultq3.getString("quizID")%>&categ=<%=result.getString("category")%>" class="btn-lg btnplay">Play quiz</a>
                        </div>
                <%
                    }
                %>
                    </div><!--end row 1.2.3.1.1-->
                </div><!--close video wrap-->
            <%
                }
            %>
                </div><!--end of divSci-->
            </div><!--end column 3.1-->
        </div><!--end row 3--> 
    </div><!--close container--> 
    
    
<jsp:include page="footer.jsp"></jsp:include>