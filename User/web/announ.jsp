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
        
<script src="frameworks/js/paginationMethod1.js"></script> 
        
    <%  
        if (rs.next()) {
    %>
    <div class="row" id="top"><!--1-->
        <div class="col-xs-12 col-md-12 col-lg-12 banner"><!--1.1-->
            <div class="row">
                <div class="col-xs-12 col-md-10 col-lg-10"><h3>Game Of Quiz Area</h3></div>
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
                            <li class="active"><a href="announ.jsp">Announcement</a></li>
                            <li><a href="Uguide.jsp">User Guide</a></li>
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
                    <jsp:include page="quiz_advise.jsp"></jsp:include>  
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