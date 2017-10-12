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
        Statement stmt, st,st2,st3,st4;
        ResultSet result, rs, resultq,resultq2,resultq3;
        String username,password, videoID,quizID,quizID2,quizID3;
        Integer count;
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
            resultq = st.executeQuery("SELECT * FROM quiz");
            
            st2=conn.createStatement();
            resultq2 = st2.executeQuery("SELECT * FROM quiz");
            
            st3=conn.createStatement();
            resultq3 = st3.executeQuery("SELECT * FROM quiz");
            
            st4=conn.createStatement();
            result = st4.executeQuery("SELECT * FROM video");          
                      
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
            while(result.next() && (result.getString("category").equalsIgnoreCase("biology"))) {  
                    
            %>
                <div class="videowrap">       
                    <div class="row"><!--1.2.3.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.1.1-->
                            <video width="100%" controls>
                                <source src="<%=result.getString("videoPath")%>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.3.1.1.2-->
                            <h4><%=result.getString("videoName") %></h4>
                            <p><%=result.getString("videoDesc") %></p>
                        </div>  
                        <%
                            resultq.first();
                        %>
                        <%
                            check=false;
  
                            while(resultq.next()) {
                                videoID = resultq.getString("videoID");
                                if(result.getString("videoID").equals(videoID)) {
                                    quizID = resultq.getString("quizID");
                                    check=true;    
                                    break;
                                }
                            }   
                        %>
                        <%
                            if(check == false){
                        %>    
                        <div class="col-xs-2 col-md-2 col-lg-2"> <!--1.2.3.1.1.3-->
                                <a href="addNewQuiz.jsp?video=<%=result.getString("videoID")%>&categ=<%=result.getString("category")%>"><button class="btn-lg videobtn"><span>Create quiz</span></button></a>
                        </div>                                
                        <%
                            }
                        %>
                        <% 
                            if (check==true) {
                        %>
                            <div class="col-xs-2 col-md-2 col-lg-2"> 
                                    <a href="updateQuiz.jsp?quiz=<%=quizID%>&video=<%=result.getString("videoID")%>"><button class="btn-lg videobtn">Edit quiz</button></a>
                            </div>                      
                            <div class="col-xs-2 col-md-2 col-lg-2"> 
                                    <a href="playquiz.jsp?id=<%=result.getInt("videoID")%>&categ=<%=result.getString("category")%>"><button class="btn-lg videobtn">Test quiz</button></a>
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
                <%
                    result.previous();
                %>
                 <div id="divEng" style="display:none;">
                  <h3>English</h3>
        <%
            while(result.next() && (result.getString("category").equalsIgnoreCase("english"))) {
                check=false;
        %>
                <div class="videowrap">
                    <div class="row"><!--1.2.4.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.4.1.1.1-->
                            <video width="100%" controls>
                                <source src="<%=result.getString("videoPath") %>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1.1.2-->
                            <h4><%=result.getString("videoName") %></h4>
                            <p><%=result.getString("videoDesc") %></p>
                        </div>            
                        
                        <div class="col-xs-2 col-md-2 col-lg-2"><!--1.2.4.1.1.3-->
                        <%
                            resultq2.first();
                        %>
                        <%
                            check=false;
  
                            while(resultq2.next()) {
                                videoID = resultq2.getString("videoID");
                                if(result.getString("videoID").equals(videoID)) {
                                    quizID = resultq2.getString("quizID");
                                    check=true;    
                                    break;
                                }
                            }   
                        %>
                            <%
                                if(check == false){
                            %>
                                <a href="addNewQuiz.jsp?video=<%=result.getString("videoID")%>&categ=<%=result.getString("category")%>"><button class="btn-lg videobtn"><span>Create quiz</span></button></a>
                        <%
                            }
                        %>
                <% 
                    if (check==true) {
                %>
                            <a href="updateQuiz.jsp?quiz=<%=quizID%>&video=<%=result.getString("videoID")%>"><button class="btn-lg videobtn">Edit quiz</button></a>
                            <a href="playquiz.jsp?id=<%=result.getInt("videoID")%>"><button class="btn-lg videobtn">Test quiz</button></a>
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
                result.previous();
            %>
            <div id="divSci" style="display:none;">
                <h3>Science & Technology</h3>
        <%
            while(result.next() && (result.getString("category").equalsIgnoreCase("science & techn"))) {
            %>
                <div class="videowrap">       
                    <div class="row"><!--1.2.3.1.1-->
                        <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.1.1-->
                            <video width="100%" controls>
                                <source src="<%=result.getString("videoPath")%>" type="video/mp4">
                            </video>
                        </div>

                        <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.3.1.1.2-->
                            <h4><%=result.getString("videoName") %></h4>
                            <p><%=result.getString("videoDesc") %></p>
                        </div>  
                            
                        <div class="col-xs-2 col-md-2 col-lg-2"><!--1.2.4.1.1.3-->
                        <%
                            resultq3.first();
                        %>
                        <%
                            check=false;
  
                            while(resultq3.next()) {
                                videoID = resultq3.getString("videoID");
                                if(result.getString("videoID").equals(videoID)) {
                                    quizID = resultq3.getString("quizID");
                                    check=true;    
                                    break;
                                }
                            }   
                        %>
                            <%
                                if(check == false){
                            %>
                                <a href="addNewQuiz.jsp?video=<%=result.getString("videoID")%>&categ=<%=result.getString("category")%>"><button class="btn-lg videobtn"><span>Create quiz</span></button></a>
                        <%
                            }
                        %>
                <% 
                    if (check==true) {
                %>
                            <a href="updateQuiz.jsp?quiz=<%=quizID%>&video=<%=result.getString("videoID")%>"><button class="btn-lg videobtn">Edit quiz</button></a>
                            <a href="playquiz.jsp?id=<%=result.getInt("videoID")%>"><button class="btn-lg videobtn">Test quiz</button></a>
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


