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
            Statement stmt, st;
            ResultSet result, rs;
            Integer announ;
            String username, password;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
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
    
    <div class="container ">   
        <!--Content section-->
        <div class="row"><!--1.2.2-->
            <div class="col-xs-12 col-md-9 col-lg-9 contentborder"><!--1.2.2.1-->
                <h2>Announcement</h2>
             
                <div class="table-responsive">
                <table class="table table-stripped table-hover sortable" id="tablepaging2">
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
                            <td headers="announ">
                                <div class="row"><!--1.2.3-->
                                    <div class="col-xs-10 col-md-10 col-lg-10">
                                        <h3><%=result.getString("announcement") %></h3>
                                    </div>
                                    <div class="col-xs-2 col-md-2 col-lg-2">
                                        <%=result.getString("udate") %>
                                    </div>
                                </div>
                                
                                <div class="row"><!--1.2.3-->
                                    <div class="col-xs-12 col-md-12 col-lg-12">
                                        <%=result.getString("content") %>
                                    </div>
                                </div>
                            </td>
                        </tr>
        <%
            }
        %>
                    </tbody>
                </table>
                </div>
                <center class="pagi">    
                    <div id="pgNum2"></div>
                </center>
            </div>
                
            <div class="col-xs-12 col-md-3 col-lg-3 contentborder link"><!--3.2--> 
                <a href="video2.jsp"><button class="btn btn-primary btn-1 icon-backward"><span>Back to Video</span></button></a>
                <a href="mquiz.jsp"><button class="btn btn-primary btn-1 icon-forward"><span>Play More Quiz</span></button></a>
                <a href="ascore.jsp"><button class="btn btn-primary btn-1 icon-forward"><span>Accumulated Score</span></button></a>
            </div> <!--close column 3.2-->
        </div><!--end column 1.2.3.1-->
    </div> 
        
    <jsp:include page="footer.jsp"></jsp:include>