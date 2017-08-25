<%-- 
    Document   : updateQuestion
    Created on : Apr 27, 2017, 12:21:45 PM
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
    
<title>Update Question</title>
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
            Statement stmt,st;
            ResultSet result,res,rs;
            Integer quizID,questionno,videoID;
            String username,password;
            
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            questionno = Integer.parseInt(request.getParameter("question"));
            quizID = Integer.parseInt(request.getParameter("quiz"));
            videoID = Integer.parseInt(request.getParameter("video"));
                
            if(request.getParameter("question") != null && request.getParameter("question")!= ""){                 
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("SELECT * FROM question WHERE questionID = '" +questionno+ "'");
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
            }else{
                response.sendRedirect("./question.jsp?quiz=" + quizID + "&video=" + videoID);
            }
            
            if(request.getParameter("btnUpd")!=null){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("UPDATE question SET question = ?, hints= ?, input1= ?, input2= ?, input3= ?, input4= ?, checked= ?, explanation= ? , udate= NOW() WHERE questionID = ?");
                    pstmt.setString(1,request.getParameter("txtquestion"));
                    pstmt.setString(2,request.getParameter("txthints"));
                    pstmt.setString(3,request.getParameter("txtinput1"));
                    pstmt.setString(4,request.getParameter("txtinput2"));
                    pstmt.setString(5,request.getParameter("txtinput3"));
                    pstmt.setString(6,request.getParameter("txtinput4")); 
                    pstmt.setString(7,request.getParameter("txtchecked"));
                    pstmt.setString(8,request.getParameter("txtexplain"));
                    pstmt.setInt(9, questionno);
                    pstmt.executeUpdate();
                    response.sendRedirect("./question.jsp?quiz=" + quizID + "&video=" + videoID);
                    return;
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
                <a href="quiz.jsp"><%=res.getString("quizTopic")%></a> > <a href="question.jsp?quiz=<%=quizID%>&video=<%=videoID%>">Question List</a> > Update
        <%
            }
        %>
            </div><!--end column-->
        </div><!--end row & end of breadcrumb-->
            
        <!--Content section-->
         <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <h2>Update <%=res.getString("quizTopic")%> Question <%=result.getInt("questionID")+1%></h2>
                <i>Press "Update Question" to commit</i>
                <hr/>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1-->
                <p class="right">(Original)</p>

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
                <p>(Update here)</p>
                <form id="updForm" action="" method="POST">
                    <h4 for="que">Question</h4>
                    <input type="hidden" id="que" name="hiddenId" id="hiddenId" value="<%=result.getInt("questionID")%>"/>
                    <textarea type="text" name="txtquestion" class="form-control" cols="70"><%=result.getString("question") %></textarea>
                    
                <!-- Format for multiple choice-->
                <%
                    if(result.getString("type").equals("M")){
                %>      
                    <h4>Multiple choice</h4>
                    <div class="form-group">
                        <label for="A" class="col-sm-1">A. </label>
                        <div class="col-sm-11">
                          <input type="text" id="A" name="txtinput1" class="form-control" value="<%=result.getString("input1") %>" size="4"/>
                        </div>
                        <label for="B" class="col-sm-1">B. </label>
                        <div class="col-sm-11">
                          <input type="text" id="B" name="txtinput2" class="form-control" value="<%=result.getString("input2") %>" size="4"/>
                        </div>
                        <label for="C" class="col-sm-1">C. </label>
                        <div class="col-sm-11">
                          <input type="text" id="C" name="txtinput3" class="form-control" value="<%=result.getString("input3") %>" size="4"/>
                        </div>
                        <label for="C" class="col-sm-1">D. </label>
                        <div class="col-sm-11">
                          <input type="text" id="D" name="txtinput4" class="form-control" value="<%=result.getString("input4") %>" size="4"/>
                        </div>
                    </div>
                    
                <!-- Format for Fill in the Blank -->
                <%
                    }else if(result.getString("type").equals("B")){
                %>
                    <h4>Fill in Blank</h4>
                    <input type="text" name="txtinput1" class="form-control" value="<%=result.getString("input1") %>"/>
                    <input type="text" name="txtinput2" class="form-control" value="<%=result.getString("input2") %>"/>
                    <input type="text" name="txtinput3" class="form-control" value="<%=result.getString("input3") %>"/>
                    <input type="text" name="txtinput4" class="form-control" value="<%=result.getString("input4") %>"/>
            
                <!-- Format for true/false -->
                <%
                    }else{
                %>    
                    <h4>True or False</h4>
                    <input type="hidden" class="form-control" name="txtinput1" value="<%=result.getString("input1") %>"/>
                    <input type="hidden" class="form-control" name="txtinput2" value="<%=result.getString("input2") %>"/>
                    <input type="hidden" class="form-control" name="txtinput3" value="<%=result.getString("input3") %>"/>
                    <input type="hidden" class="form-control" name="txtinput4" value="<%=result.getString("input4") %>"/>               
                <%
                    }
                %>                
                    <h4>Hints</h4>
                    <input type="text" name="txthints" class="form-control" value="<%=result.getString("hints") %>"/>

                    <h4>Answer</h4>
                    <input type="text" name="txtchecked" class="form-control" value="<%=result.getString("checked") %>"/>
                        
                    <h4>Explanation</h4></li>
                    <input type="text" name="txtexplain" class="form-control" value="<%=result.getString("explanation") %>"/>

                    <div class="form-group">
                        <br/>
                        <button class="btn btn-primary" type="submit" name="btnUpd" id="btnUpd">Update Question</button>
                        <a class="btn btn-primary" href="question.jsp?quiz=<%=quizID%>&video=<%=videoID%>">Cancel</a>
                        <button class="btn btn-primary" type="reset">Reset</button>
                    </div>        
                
              <!-- maybe add reset?-->
                </form>        
            </div><!--end column 1.2.4.2-->
        </div><!--end row 1.2.4 & end of content section-->
    
        <jsp:include page="footer.jsp"></jsp:include>