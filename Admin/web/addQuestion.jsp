<%-- 
    Document   : addQuestion
    Created on : Apr 26, 2017, 11:04:21 PM
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
<title>Add Question</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/frameworks/css/bootstrap.min.css" rel="stylesheet" media="screen">

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
            ResultSet result,res, rs;
            Integer quizID,videoID;
            Statement stmt, st;
            String username,password,questionID;
        %>
        
        <%-- READ function & CREATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass"); 
 
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("quiz") != null && request.getParameter("quiz")!= "" ){  
                quizID = Integer.parseInt(request.getParameter("quiz"));
                videoID = Integer.parseInt(request.getParameter("video"));
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
                
                st = conn.createStatement();
                res = st.executeQuery("select * from quiz where quizID='" + quizID + "'");
                
                if(request.getParameter("btnAdd") != null){
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        pstmt = conn.prepareStatement("INSERT INTO question(quizID, videoID, question, type, hints, input1, input2, input3, input4, checked, explanation, cdate, udate,lupdateBY) VALUES(?,?,?,?,?,?,?,?,?,?,?,NOW(),NOW(),?)");
                        pstmt.setInt(1, quizID);
                        pstmt.setInt(2, videoID);
                        pstmt.setString(3,request.getParameter("txtquestion"));
                        pstmt.setString(4,request.getParameter("txttype"));
                        pstmt.setString(5,request.getParameter("txthints"));
                        pstmt.setString(6,request.getParameter("txtinput1"));
                        pstmt.setString(7,request.getParameter("txtinput2"));
                        pstmt.setString(8,request.getParameter("txtinput3"));
                        pstmt.setString(9,request.getParameter("txtinput4")); 
                        pstmt.setString(10,request.getParameter("txtchecked"));
                        pstmt.setString(11,request.getParameter("txtexplain"));
                        pstmt.setString(12,username);
                        pstmt.executeUpdate();
                        response.sendRedirect("./question.jsp?quiz=" + quizID + "&video=" + videoID);           
                    }catch(ClassNotFoundException cnfe){
                        out.println("Class not Found Execption:-" + cnfe.toString());
                    }catch(SQLException sqle){
                        out.println("SQL Query Exception:- " + sqle);
                    }
                } 
            }else{
                response.sendRedirect("./question.jsp?quiz=" + quizID + "&video=" + videoID);
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
                <a href="quiz.jsp"><%=res.getString("quizTopic")%></a> > <a href="question.jsp?quiz=<%=quizID%>&video=<%=videoID%>">Question List</a> > Add New Question
        <%
            }
        %>
            </div><!--end column-->
        </div><!--end row & end of breadcrumb-->
            
        <!--Content section-->
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <h2>Add New Question</h2>
                <i>Press "Save" to commit</i>
                <hr/>
                <form id="addForm" action="" method="POST">
                    <!--quiz question add here-->
                    <div class="questioncontainer">
                        <div class="row"><!--1.2.3.1.1--> 
                        <div class="col-xs-4 col-md-4 col-lg-4 question"><!--1.2.3.1.1.1--> 
                            <b>Question:</b>  
                        </div>
                        <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.1.2--> 
                            <textarea name="txtquestion" class="form-control" placeholder="question"></textarea>
                        </div>
                        </div><!--end row 1.2.3.1.1-->
                    </div>

                <div class="container2">
                    <div class="row"><!--1.2.3.1.2--> 
                        <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1.2.1--> 
                            <em>Select a type for question and continue</em>
                            <br/>
                            <span><input type="radio" name="txttype" value="M" onclick="show('divM')" checked="checked"/> Multiple choice</span>
                            <span class="lefttab"><input type="radio" name="txttype" value="T" onclick="show('divT')" /> True or false</span>
                            <span class="lefttab"><input type="radio" name="txttype" value="B" onclick="show('divB')" /> Fill in Blank</span>
                            <br/><br/>
                        <!-- Format for multiple choice -->                                
                        <div id="divM">
                            <p><b>Multiple Choices:</b></p>
                            <p><input class="form-control" type="text" name="txtinput1" placeholder="A"/>
                            <input class="form-control" type="text" name="txtinput2" placeholder="B"/>
                            <input class="form-control" type="text" name="txtinput3" placeholder="C"/>
                            <input class="form-control" type="text" name="txtinput4" placeholder="D"/>
                            <br/>
                                
                            <!-- answer -->
                            <div class="row"><!--1.2.3.1.2.1.1--> 
                                <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1.1.1--> 
                                    <p><b>Answer:</b></p> 
                                </div>
                                <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.2.1.1.2--> 
                                    <p><input class="form-control" type="text" name="txtchecked" placeholder="A? B? C? D?"/></p>
                                </div>
                            </div>
                        </div><!-- close divM --> 

                        <!-- Format for fill in the blank -->
                        <div id="divT" style="display:none;">
                            <!-- answer -->
                            <div class="row"><!--1.2.3.1.2.1.1-->
                               <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1.1.1--> 
                                    <p><b>Answer:</b></p> 
                                </div>
                                <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.2.1.1.2-->  
                                    <p><input class="form-control" type="text" name="txtchecked" placeholder="True? False?" /></p>
                                </div>
                            </div>
                            <br/>                           
                        </div><!-- close divT --> 
                            
                        <!-- Format for fill in the blank -->
                        <div id="divB" style="display:none;">
                            <p><b>Choices:</b></p>
                            <input class="form-control" type="text" name="txtinput1" placeholder="Choice 1"/>
                            <input class="form-control" type="text" name="txtinput2" placeholder="Choice 2"/>
                            <input class="form-control" type="text" name="txtinput3" placeholder="Choice 3"/>
                            <input class="form-control" type="text" name="txtinput4" placeholder="Choice 4"/>
                                
                            <!-- answer -->
                            <div class="row"><!--1.2.3.1.2.1.1-->
                                <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1.1.1--> 
                                    <p><b>Answer:</b></p> 
                                </div>
                                <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.2.1.1.2-->
                                    <p><input class="form-control" type="text" name="txtchecked" placeholder="..." /></p>
                                </div>
                            </div>
                            <br/>
                        </div><!-- close divB --> 

                            <!-- hint-->
                            <div class="row"><!--1.2.3.1.2.1.2--> 
                                <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1.2.1-->
                                    <p><span class="hinticon glyphicon glyphicon-search"></span><b>Hint:</b></p>  
                                </div>
                                <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.2.1.2.2-->
                                    <p><input type="text" name="txthints" class="form-control"/></p>
                                </div>
                            </div><!--end row 1.2.3.1.2.1.2 & end of hint-->

                            <!-- explanation -->
                            <div class="row"><!--1.2.3.1.2.1.3--> 
                                <p><div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1.3.1-->
                                    <p><b>Explanation:</b></p>  
                                </div>
                                <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.2.1.3.2--> 
                                    <p><textarea name="txtexplain" class="form-control"></textarea></p>
                                </div>
                            </div><!--end row 1.2.3.1.2.1.3 & end of explanation-->
                            <br/>
                            <button type="submit" name="btnAdd" class="btn btn-primary">Save</button>
                            <a class="btn btn-primary" href="question.jsp?id=<%=quizID%>">Cancel</a>
                        </div><!--end column 1.2.3.1.2.1-->
                    </div><!--end row 1.2.3.1.2-->
                </div> <!--close container 2--> 
                </form>
            </div><!--end column 1.2.3.1-->   
        </div><!--end row 1.2.3 & end of content section-->

<script>
    var currentDiv = document.getElementById("divM");
    function show(divID) {
        var div = document.getElementById(divID);

        currentDiv.style.display = "none";
        div.style.display = "block";

        currentDiv = div;
    }
</script>

        <jsp:include page="footer.jsp"></jsp:include>