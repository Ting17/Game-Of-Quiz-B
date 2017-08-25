<%-- 
    Document   : showQuestion
    Created on : Apr 27, 2017, 4:09:42 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<title>Preview Question</title>
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
            PreparedStatement pstmt;
            ResultSet result,res,rs;
            Integer questionNo,quizID,videoID; 
            String username,password;
            Statement stmt, st;
        %>
        
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass"); 

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("question") != null && request.getParameter("question")!= ""){  
                questionNo = Integer.parseInt(request.getParameter("question"));
                quizID = Integer.parseInt(request.getParameter("quiz"));
                videoID = Integer.parseInt(request.getParameter("video"));
                 
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("SELECT * FROM question WHERE questionID = ?");
                    pstmt.setInt(1,questionNo);
                    result = pstmt.executeQuery();
                    result.first();

                    st = conn.createStatement();
                    res = st.executeQuery("select * from quiz where quizID='" + quizID + "'");

                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
        
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
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
            }
        %>
        
        <jsp:include page="navigator.jsp"></jsp:include>
        <!--breadcrumb-->
        <div class="row"><!--1.2.2-->
            <div class="col-xs-12 col-md-12 col-lg-12 "><!--1.2.2.1-->
        <%  if (res.next()) {
        %>
                <b>Quiz:</b> 
                <a href="quiz.jsp"><%=res.getString("quizTopic")%></a> > <a href="question.jsp?quiz=<%=quizID%>&video=<%=videoID%>">Question List</a> > Preview
        <%
            }
        %>
            </div><!--end column-->
        </div><!--end row & end of breadcrumb-->
            
        <!--Content section-->
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
            <h2>Preview <%=res.getString("quizTopic")%> Question <%=result.getInt("questionID")+1%></h2>
            <hr/>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1-->
                <p class="right">(in user view)</p>
            <!--display quiz question-->
            <div id="<%=result.getInt("questionID") %>" class="questioncontainer">
                <h3> Question <%=result.getInt("questionID")+1%></h3> <hr/>
                <h4><%=result.getString("question") %></h4> 
            </div>
            
            <div class="container2"> 
        <!-- Format for multiple choice -->
        <%
            if(result.getString("type").equals("M")){
        %>     
                <ul class="answercontainer">
                    <li class="rowinput" ><%=result.getString("input1") %></li>
                    <li class="rowinput" ><%=result.getString("input2") %></li>
                    <li class="rowinput" ><%=result.getString("input3") %></li>
                    <li class="rowinput" ><%=result.getString("input4") %></li>
                </ul>
        <!-- Format for Fill in the Blank -->
        <%
            }else if(result.getString("type").equals("B")){
        %>
                <ul class="choice answercontainer">
                    <li>
                        <span><%=result.getString("input1") %></span>
                        <span class="lefttab"><%=result.getString("input2") %></span>
                        <span class="lefttab"><%=result.getString("input3") %></span>
                        <span class="lefttab"><%=result.getString("input4") %></span>
                    </li>
                </ul>  
        <%
            }
        %> 
                <!-- Show hint-->
                <p><span class="hinticon glyphicon glyphicon-search"></span><b>Hint:</b> <%=result.getString("hints") %></p>     

            <!-- Show answer -->
            <div class="checkshowanswer">
                <p><b>Answer: </b> <%=result.getString("checked")%><br/></p>
                <p><b>Explanation in detail:</b> <%=result.getString("explanation")%></p>
            </div>
            </div><!--close container2-->
            </div><!--end column 1.2.4.1-->
            
            <div class="col-xs-6 col-md-6 col-lg-6 border"><!--1.2.4.2-->
                <p>(detail for Question <%=result.getInt("questionID")+1%>)</p>
                <br/>
                <p><b>Under Topic:</b> <%=res.getString("quizTopic")%></p>
                <p><b>Created on:</b> <%=result.getString("cdate") %></p>
                <p><b>Last Updated:</b> <%=result.getString("udate") %></p>
                <p><b>Last Updated By:</b> <%=result.getString("lupdateBY") %></p>
                <p><b>Question:</b> <%=result.getString("question") %></p>
        <%
            if(result.getString("type").equals("M")){
        %> 
                <p><b>Question type:</b> Multiple Choice</p>
                <b>Multiple Choices:</b>
                <ul>
                    <li>A. <%=result.getString("input1") %></li>
                    <li>B. <%=result.getString("input2") %></li>
                    <li>C. <%=result.getString("input3") %></li>
                    <li>D. <%=result.getString("input4") %></li>
                </ul>
        <%
            }else if(result.getString("type").equals("B")){
        %>
                <p><b>Question type: </b>Fill in the Blank</p>
                <b>Choices:</b>
                <ul>
                    <li><%=result.getString("input1") %></li>
                    <li><%=result.getString("input2") %></li>
                    <li><%=result.getString("input3") %></li>
                    <li><%=result.getString("input4") %></li>
                </ul>
        <%
            }else{
        %>
                <p><b>Question type:</b> True or False</p>    
        <%
            }
        %>
                <p><b>Hint:</b> <%=result.getString("hints") %></p>     
                <p><b>Answer: </b> <%=result.getString("checked")%><br/></p>
                <p><b>Explanation in detail:</b> <%=result.getString("explanation")%></p>
                <hr/>
                <center>
                <div class="form-group">
                    <a class="btn btn-primary" href="updateQuestion.jsp?question=<%=result.getInt("questionID")%>&quiz=<%=quizID%>&video=<%=videoID%>">Edit</a>
                    <a class="btn btn-primary" href="deleteQuestion.jsp?question=<%=result.getInt("questionID")%>&quiz=<%=quizID%>" onclick="return confirm('Once confirm, question <%=result.getInt("questionID")+1%> will be removed. Confirm to delete?')"> Delete</a>
                    <a class="btn btn-primary" href="question.jsp?quiz=<%=quizID%>&video=<%=videoID%>">Back</a>
                </div>
                </center>
            </div><!--end column 1.2.4.2-->   
        </div><!--end row 1.2.4 & end of content section-->

        <jsp:include page="footer.jsp"></jsp:include>