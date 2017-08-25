<%-- 
    Document   : question
    Created on : Apr 29, 2017, 11:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Video List</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="languages.min.css" rel="stylesheet" />


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
        ResultSet result,rs;
        String username,password;
    %>

    <%-- READ function for videos--%>
    <%
        username = (String)session.getAttribute("uname");
        password = (String)session.getAttribute("pass");
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            st=conn.createStatement();
            result = st.executeQuery("SELECT * FROM video");
            
            stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
        
        }catch(ClassNotFoundException cnfe){
            out.println("Class not Found Execption:-" + cnfe.toString());
        }catch(SQLException sqle){
            out.println("SQL Query Exception:- " + sqle);
        }
    %>
        
    <div class="container">
    <%     
        if (rs.next()) {
    %>
    <div class="row"><!--1--> 
        <!-- tab -->
        <div class="col-xs-2 col-md-2 col-lg-2 tab"><!--1.1--> 
            <div id="circle">
                <a href="profile.jsp" id="profile"><%=rs.getString("username")%></a>
            </div>
    <%
        }else {
            out.println("Invalid password");
            response.sendRedirect("index.html");
        }
    %>
        
    <jsp:include page="navigator.jsp"></jsp:include> 

        <!--Content section-->
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <b>Video Topic:</b> 
                <a onclick="show('divBio')">Biology |</a>
                <a onclick="show('divEng')">English |</a>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3--> 

        <div class="row"><!--1.2.4-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.4.1-->
                <div id="divBio">
                <h3>Biology</h3>
        <%
            while(result.next() && (result.getString("category").equalsIgnoreCase("biology"))) {          
        %>
                <div class="videowrap">       
                    <div class="row"><!--1.2.4.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.4.1.1.1-->
                            <video width="100%" controls>
                                <source src="<%=result.getString("videoPath")%>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1.1.2-->
                            
                    <h4><%=result.getString("videoName") %></h4>
                            <p><%=result.getString("videoDesc") %></p>
                        </div>            

                            <!-- this ned discuss-->
                            <!--3.2.1.3
                            <div class="col-xs-2 col-md-2 col-lg-2 quizbtn"> 
                                <a href="topic.jsp"><button class="btn-lg btncreate">Create quiz</button></a>
                            </div>-->
                    </div>
                </div>
        <%
            }
        %>
                </div><!--end of divBio-->
                
                 <div id="divEng" style="display:none;">
                  <h3>English</h3>
        <%
            while(result.next() && (result.getString("category").equalsIgnoreCase("english"))) {
        %>
                <div class="videowrap">
                    <h4><%=result.getString("videoName") %></h4> 
                    <div class="row"><!--1.2.4.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.4.1.1.1-->
                            <video width="100%" controls>
                                <source src="<%=result.getString("videoPath") %>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1.1.2-->
                            <p><%=result.getString("videoDesc") %></p>
                        </div>            

                        <!-- this ned discuss-->
                        <!--3.2.1.3
                        <div class="col-xs-2 col-md-2 col-lg-2 quizbtn"> 
                            <a href="topic.jsp"><button class="btn-lg btncreate">Create quiz</button></a>
                        </div>-->
                    </div>
                </div>
        <%
            }
        %>
            </div><!--end of divEng-->       
            </div><!--end column 1.2.4.1-->
        </div><!--end row 1.2.4--> 

    
       
                           
            
<script>
    var currentDiv = document.getElementById("divBio");
    function show(divID) {
        var div = document.getElementById(divID);

        currentDiv.style.display = "none";
        div.style.display = "block";

        currentDiv = div;
    }
</script>

    
<!-- footer -->
    <jsp:include page="footer.jsp"></jsp:include>


