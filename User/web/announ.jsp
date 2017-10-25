<%-- 
    Document   : announ
    Created on : Sep 3, 2017, 1:34:54 PM
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
<title>Announcement</title>
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
        
<script src="frameworks/js/paginationMethod2.js"></script> 
        
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

    <div class="row navvideo announcemenu"><!--1 b-->
        <div class="col-xs-12 col-md-12 col-lg-12"><!--1.1 b-->
            <ul>
                <li><a href="video2.jsp">EQUILIBRA Home</a></li>
                <li><a href="GOQ_home.jsp">More Quiz</a></li>
                <li><a data-toggle="modal" data-target="#ascore">Check Accumulated Score</a></li>
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
                <li class="active"><a href="announ.jsp">Announcement</a></li>
                <li><a href="Uguild.jsp">User Guild</a></li>
            </ul>
        </div><!--close column 1.1 b-->
    </div><!--close row 1 b-->
    
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
                    <li class="active"><span>Announcement</span></li>
                </ol>
             
                <div class="table-responsive">
                <table class="table" id="tablepaging">
                    <thead>
                        <tr>
                            <th id="announ" scope="col">Announcement</th>
                        </tr>
                    </thead>                      
                    <tbody>      
        <%
            while(result.next()) { 
        %>
                        <tr>
                            <td class="announ">
                                <h4><b><%=result.getString("announcement") %></b></h4>
                                <%=result.getString("udate") %>
                                <br/><br/><br/>
                                <%=result.getString("content") %>
                                <hr class="blue"/>
                            </td>
                        </tr>
        <%
            }
        %>
                    </tbody>
                </table>
                </div>
                <center >    
                    <div id="pgNum2"></div>
                </center>
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