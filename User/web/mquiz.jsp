<%-- 
    Document   : mquiz
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
<title>More Quiz</title>
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
            ResultSet result,rs; 
            String category, username,password;
            Integer videoID,quizID; 
        %>
 <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM quiz where videoID = 0");
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
            
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            }
        %>
        
    <div class="row" id="top"><!--1-->
        <div class="col-xs-12 col-md-12 col-lg-12"><!--1.1-->
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <h3>Game of Quiz Quiz area</h3>
                    </div>
                </div><!--close container-->
            </nav>
        </div><!--end column 1.1-->
    </div><!--end row 1 & end of navigation-->
       
    
    <div class="row subject"><!--2-->
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.1-->
            <a onclick="show('divEng')"><h4 >English</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.2-->
            <a><h4>Mathematic</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.3-->
            <a><h4>History</h4></a>
        </div>
        <div class="col-xs-3 col-md-3 col-lg-3 border"><!--2.4-->
            <a onclick="show('divBio')"><h4>Biology</h4></a>
        </div>           
    </div><!--end row 2-->

    <div class="container">
    <div class="row"><!--3--> 
        <div class="col-xs-12 col-md-8 col-lg-8 contentborder mques"> <!--3.1--> 
            <div class="table-responsive">
                <table class="table table-stripped table-hover sortable">
                    <thead>
                        <tr>
                            <th id="quiz" scope="col">Quiz</th>
                        </tr>
                    </thead>                      
                    <tbody>   
                    <%
                        while(result.next()) {
                            quizID = result.getInt("quizID");
                    %>
                        <tr>
                            <td headers="quiz" class="quiz">
                                <a href="mquestion.jsp?quizID=<%=quizID%>" title="<%=result.getString("category") %>"><button class="playmque"><span><%=result.getString("quizTopic") %></span></button></a>
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
            <button class="btn btn-primary btn-1 icon-backward" onclick="history.back()"><span>Back</span></button>
            <a href="video2.jsp"><button class="btn btn-primary btn-1 icon-backward"><span>Back to Main Video Page</span></button></a>
        </div><!--close column 3.2-->
    </div> <!--close row 3-->
    </div> <!--close container-->
                                   

<jsp:include page="footer.jsp"></jsp:include>
