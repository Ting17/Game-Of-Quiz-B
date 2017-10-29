<%-- 
    Document   : addQuestion
    Created on : Apr 26, 2017, 11:04:21 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html data-ng-app="myApp">
<head >     

<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Question</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/frameworks/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />
<link href="frameworks/css/questionstyle.css" rel="stylesheet" />

<!-- Rich Text -->
<script src="frameworks/ckeditor_4.7.2_standard/ckeditor/ckeditor.js"></script>


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
            Integer adminID;
            Statement stmt, st;
            String username,password,questionID,quizID,videoID;
        %>
        
        <%-- READ function & CREATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass"); 
            adminID = (Integer)session.getAttribute("aid");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("quizID") != null && request.getParameter("quizID")!= "" ){  
                quizID = request.getParameter("quizID");
                videoID = request.getParameter("videoID");
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
                
                st = conn.createStatement();
                res = st.executeQuery("select * from quiz where quizID='" + quizID + "'");
                
                if(request.getParameter("btnAdd") != null){
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        pstmt = conn.prepareStatement("INSERT INTO question(quizID, videoID, question, type, input1, input2, input3, input4, checked, cdate, udate,adminID) VALUES(?,?,?,?,?,?,?,?,?,NOW(),NOW(),?)");
                        pstmt.setString(1, quizID);
                        pstmt.setString(2, videoID);
                        pstmt.setString(3,request.getParameter("txtquestion"));
                        pstmt.setString(4,request.getParameter("txttype"));
                        pstmt.setString(5,request.getParameter("txtinput1"));
                        pstmt.setString(6,request.getParameter("txtinput2"));
                        pstmt.setString(7,request.getParameter("txtinput3"));
                        pstmt.setString(8,request.getParameter("txtinput4")); 
                        pstmt.setString(9,request.getParameter("txtchecked"));
                        pstmt.setInt(10,adminID);
                        pstmt.executeUpdate();
                        response.sendRedirect("./question.jsp?quizID=" + quizID + "&videoID=" + videoID);           
                    }catch(ClassNotFoundException cnfe){
                        out.println("Class not Found Execption:-" + cnfe.toString());
                    }catch(SQLException sqle){
                        out.println("SQL Query Exception:- " + sqle);
                    }
                } 
            }else{
                response.sendRedirect("./question.jsp?quizID=" + quizID + "&videoID=" + videoID);
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
                <a href="quizlist.jsp"><%=res.getString("quizTopic")%></a> > <a href="question.jsp?quizID=<%=quizID%>&videoID=<%=videoID%>">Question List</a> > Add New Question
        <%
            }
        %>
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2 & end of breadcrumb-->
            
        <!--Content section-->
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <h2>Add New Question</h2>
                <i>Press "Save" to commit</i>
                <hr/>
                <form id="addForm" action="" method="POST">
                    <!--quiz question add here-->
                    <div class="questioncontainer">
                        <b>Question:</b>  
                        <textarea name="txtquestion" class="form-control" placeholder="question"></textarea>
                    </div>

                <div class="container2">
                    <em>Select a type for question and continue</em>
                    <br/>
                    <span><input type="radio" name="txttype" value="MC" data-ng-click="show = 1" /> Multiple choice</span>
                    <span class="lefttab"><input type="radio" name="txttype" value="2C" data-ng-click="show = 2" /> Two Choice Selection</span>
                    <span class="lefttab"><input type="radio" name="txttype" value="BL" data-ng-click="show = 3" /> Fill in Blank</span>
                    <br/><br/>
                    <!--Multiple Choice-->
                    <div data-ng-if="show===1">
                        <div class="row"><!--1.2.3.1.1-->
                            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1.1.1-->
                                <p><i>Fill in rows below for A, B, C, D</i></p>
                                <p><i>Fill in the right answer in answer column</i></p>
                                <input class="form-control" type="text" id="a" name="txtinput1" placeholder="A"/>
                                <input class="form-control" type="text" id="b" name="txtinput2" placeholder="B"/>
                                <input class="form-control" type="text" id="c" name="txtinput3" placeholder="C"/>
                                <input class="form-control" type="text" id="d" name="txtinput4" placeholder="D"/>
                            </div>
                        </div>
                        <!-- answer -->
                        <div class="row wrap3"><!--1.2.3.1.2--> 
                            <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1--> 
                                <p><b>Answer:</b></p> 
                            </div>
                            <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.2.2--> 
                                <p><input class="form-control" type="text" name="txtchecked" placeholder="A? B? C? D?"/></p>
                            </div>
                        </div>
                    </div><!-- end of Multiple Choice-->
                     
                    <!--2 choice selection-->
                    <div data-ng-if="show===2">
                        <div class="row"><!--1.2.3.1.1-->
                            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1.1.1-->
                                <p><i>Fill in the first row (1) and second row (2) below; it can be True or False, Yes or No,etc....</i></p>
                                <p><i>Fill in the right answer in answer column</i></p>
                                <input class="form-control" type="text" id="a" name="txtinput1" placeholder="True? Yes? etc..."/>
                                <input class="form-control" type="text" id="b" name="txtinput2" placeholder="False? No? etc..."/>
                                <input class="form-control" type="hidden" id="c" name="txtinput3" placeholder=""/>
                                <input class="form-control" type="hidden" id="d" name="txtinput4" placeholder=""/>
                            </div>
                        </div>
                        <!-- answer -->
                        <div class="row wrap3"><!--1.2.3.1.2--> 
                            <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1--> 
                                <p><b>Answer:</b></p> 
                            </div>
                            <div class="col-xs-8 col-md-8 col-lg-8"><!-<!--1.2.3.1.2.2--> 
                                <p><input class="form-control" type="text" name="txtchecked" placeholder="1? 2?"/></p>
                            </div>
                        </div>
                    </div> <!-- end of 2 choice selection-->
                    
                    <!--Fill in Blank-->
                    <div data-ng-if="show===3">
                        <div class="row"><!--1.2.3.1.1-->
                            <div class="col-xs-12 col-md-12 col-lg-12 wrap3"><!--1.2.3.1.1.1-->
                                <p><i>Fill in rows below for Choice 1, 2, 3, 4.</i></p>
                                <p><i>Fill in the right answer in answer column</i></p>
                                <input class="form-control" type="text" id="a" name="txtinput1" placeholder="Choice 1"/>
                                <input class="form-control" type="text" id="b" name="txtinput2" placeholder="Choice 2"/>
                                <input class="form-control" type="text" id="c" name="txtinput3" placeholder="Choice 3"/>
                                <input class="form-control" type="text" id="d" name="txtinput4" placeholder="Choice 4"/>
                            </div>
                        </div>
                        <!-- answer -->
                        <div class="row wrap3"><!--1.2.3.1.2--> 
                            <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1.2.1--> 
                                <p><b>Answer:</b></p> 
                            </div>
                            <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1.2.2--> 
                                <p><input class="form-control" type="text" name="txtchecked" placeholder="1? 2? 3? 4?"/></p>
                            </div>
                        </div>
                    </div><!--end of Fill in Blank-->
                                
                    <br/>
                    <button type="submit" name="btnAdd" class="btn btn-primary">Save</button>
                    <a class="btn btn-primary" href="question.jsp?quizID=<%=quizID%>&videoID=<%=videoID%>">Cancel</a>
                </div> <!--close container 2--> 
                </form>
            </div><!--end column 1.2.3.1-->   
        </div><!--end row 1.2.3 & end of content section-->

<script>
    CKEDITOR.replace('txtquestion');
</script>

        
        <jsp:include page="footer.jsp"></jsp:include>