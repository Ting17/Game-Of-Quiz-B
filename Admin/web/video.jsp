<%-- 
    Document   : video
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
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Video List</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />


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
        Statement stmt, st,st2,st3,st4, st5, st6;
        ResultSet resultBio, resultQBio, resultEng, resultQEng, resultSci, resultQSci, rs;
        String username,password, videoID,quizID,quizID2,quizID3;
        Integer count = 0;
        Boolean check;
    %>

    <%-- READ function for videos--%>
    <%
        username = (String)session.getAttribute("uname");
        password = (String)session.getAttribute("pass");
        
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
            resultBio = st4.executeQuery("SELECT * FROM video WHERE category = 'Biology' ");  
            
            st5=conn.createStatement();
            resultEng = st5.executeQuery("SELECT * FROM video WHERE category = 'English' ");
            
            st6=conn.createStatement();
            resultSci = st6.executeQuery("SELECT * FROM video WHERE category = 'Science & Techn' ");
                      
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
        <div class="row"><!--1.2.2-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.2.1-->
                <b>Video Topic:</b> 
                <a onclick="show('divBio')">Biology |</a>
                <a onclick="show('divEng')">English |</a>
                <a onclick="show('divSci')">Science & Technology |</a>
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2--> 

        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <div id="divBio">
                <h3>Biology</h3>
        <%
            while(resultBio.next()) {  
        %>
                <div class="videowrap">       
                    <div class="row"><!--1.2.3.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.1.1-->
                            <video width="100%" controls>
                                <source src="<%=resultBio.getString("videoPath")%>" type="video/mp4">
                            </video>    
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.3.1.1.2-->
                            <h4><%=resultBio.getString("videoName") %></h4>
                            <p><%=resultBio.getString("videoDesc") %></p>
                        </div>  
            <%
                resultQBio.first();
                check=false;
  
                while(resultQBio.next()) {
                    videoID = resultQBio.getString("videoID");
                    if(resultBio.getString("videoID").equals(videoID)) {
                        quizID = resultQBio.getString("quizID");
                        check=true;    
                        break;
                    }
                }   
                if(check == false){
            %>    
                        <div class="col-xs-2 col-md-2 col-lg-2"> <!--1.2.3.1.1.3-->
                                <a href="addNewQuiz.jsp?video=<%=resultBio.getString("videoID")%>&categ=<%=resultBio.getString("category")%>"><button class="btn-lg videobtn"><span>Create quiz</span></button></a>
                        </div>                                
            <%
                }
                if (check==true) {
            %>
                            <div class="col-xs-2 col-md-2 col-lg-2"> 
                                    <a href="updateQuiz.jsp?quiz=<%=quizID%>&video=<%=resultBio.getString("videoID")%>"><button class="btn-lg videobtn">Edit quiz</button></a>
                            </div>                      
                            <div class="col-xs-2 col-md-2 col-lg-2"> 
                                    <a href="playquiz.jsp?id=<%=resultBio.getInt("videoID")%>&categ=<%=resultBio.getString("category")%>"><button class="btn-lg videobtn">Take quiz</button></a>
                            </div>   
            <%
                }
            %>     
                    </div> <!-- end of row 1.2.3.1.1-->
                </div>  
        <%
            }
        %>
                </div><!--end of divBio-->
                
                 <div id="divEng" style="display:none;">
                  <h3>English</h3>
        <%
            while(resultEng.next() && (resultEng.getString("category").equalsIgnoreCase("english"))) {
                check=false;
        %>
                <div class="videowrap">
                    <div class="row"><!--1.2.4.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.4.1.1.1-->
                            <video width="100%" controls>
                                <source src="<%=resultEng.getString("videoPath") %>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1.1.2-->
                            <h4><%=resultEng.getString("videoName") %></h4>
                            <p><%=resultEng.getString("videoDesc") %></p>
                        </div>            
                        
                        <div class="col-xs-2 col-md-2 col-lg-2"><!--1.2.4.1.1.3-->
            <%
                resultQEng.first();
                check=false;
  
                while(resultQEng.next()) {
                    videoID = resultQEng.getString("videoID");
                    if(resultEng.getString("videoID").equals(videoID)) {
                        quizID = resultQEng.getString("quizID");
                        check=true;    
                        break;
                    }
                }   
                if(check == false){
            %>
                                <a href="addNewQuiz.jsp?video=<%=resultEng.getString("videoID")%>&categ=<%=resultEng.getString("category")%>"><button class="btn-lg videobtn"><span>Create quiz</span></button></a>
            <%
                }
                if (check==true) {
            %>
                            <a href="updateQuiz.jsp?quiz=<%=quizID%>&video=<%=resultEng.getString("videoID")%>"><button class="btn-lg videobtn">Edit quiz</button></a>
                            <a href="playquiz.jsp?id=<%=resultEng.getInt("videoID")%>"><button class="btn-lg videobtn">Take quiz</button></a>
            <%
                }
            %> 
                        </div>
                    </div><!--end of row 1.2.4.1.1-->
                </div>      
        <%
            }
        %>
            </div><!--end of divEng-->       
        <%
            resultSci.previous();
        %>
            <div id="divSci" style="display:none;">
                <h3>Science & Technology</h3>
        <%
            while(resultSci.next() && (resultSci.getString("category").equalsIgnoreCase("science & techn"))) {
        %>
                <div class="videowrap">       
                    <div class="row"><!--1.2.3.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.1.1-->
                            <video width="100%" controls>
                                <source preload="auto" src="<%=resultSci.getString("videoPath")%>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.3.1.1.2-->
                            <h4><%=resultSci.getString("videoName") %></h4>
                            <p><%=resultSci.getString("videoDesc") %></p>
                        </div>  
                            
                        <div class="col-xs-2 col-md-2 col-lg-2"><!--1.2.4.1.1.3-->
            <%
                resultQSci.first();
                check=false;
                while(resultQSci.next()) {
                    videoID = resultQSci.getString("videoID");
                    if(resultSci.getString("videoID").equals(videoID)) {
                        quizID = resultQSci.getString("quizID");
                        check=true;    
                        break;
                    }
                }   
                if(check == false){
            %>
                                <a href="addNewQuiz.jsp?video=<%=resultSci.getString("videoID")%>&categ=<%=resultSci.getString("category")%>"><button class="btn-lg videobtn"><span>Create quiz</span></button></a>
            <%
                }
                if (check==true) {
            %>
                            <a href="updateQuiz.jsp?quiz=<%=quizID%>&video=<%=resultSci.getString("videoID")%>"><button class="btn-lg videobtn">Edit quiz</button></a>
                            <a href="playquiz.jsp?id=<%=resultSci.getInt("videoID")%>"><button class="btn-lg videobtn">Take quiz</button></a>
            <%
                }
            %> 
                        </div>
                    </div> <!-- end of row 1.2.3.1.1-->
                </div>
        <%
            }
        %>
                </div><!--end of divSci-->
            
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


