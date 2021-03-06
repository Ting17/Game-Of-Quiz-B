<%-- 
    Document   : updateQuestion
    Created on : Apr 27, 2017, 12:21:45 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html data-ng-app="myApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<title>Update Question</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />   
<!-- StyleSheet -->
<link href="frameworks/css/style.css" rel="stylesheet" />
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
            Statement stmt,st;
            ResultSet result,res,rs;
            Integer questionno,adminID;
            String username,password,videoID,quizID;
            
        %>
        
        <%-- READ & UPDATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            adminID = (Integer)session.getAttribute("aid");           
           
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            questionno = Integer.parseInt(request.getParameter("question"));
            quizID = request.getParameter("quizID");
            videoID = request.getParameter("videoID");
                
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
                    pstmt = conn.prepareStatement("UPDATE question SET question = ?, input1= ?, input2= ?, input3= ?, input4= ?, checked= ?, udate= NOW(), adminID= ? WHERE questionID ='" + questionno +"' and quizID='" + quizID + "'and videoID='" + videoID + "'");
                    pstmt.setString(1,request.getParameter("txtquestion"));
                    pstmt.setString(2,request.getParameter("txtinput1"));
                    pstmt.setString(3,request.getParameter("txtinput2"));
                    pstmt.setString(4,request.getParameter("txtinput3"));
                    pstmt.setString(5,request.getParameter("txtinput4")); 
                    pstmt.setString(6,request.getParameter("txtchecked"));
                    pstmt.setInt(7, adminID);
                    pstmt.executeUpdate();
                    response.sendRedirect("./question.jsp?quizID=" + quizID + "&videoID=" + videoID);
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
        <%  
            if (res.next()) {
        %>
                <b>Quiz:</b> 
                <a href="quizlist.jsp"><%=res.getString("quizTopic")%></a> > <a href="question.jsp?quizID=<%=quizID%>&videoID=<%=videoID%>">Question List</a> > Update
        <%
            }
        %>   
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2 & end of breadcrumb-->
         
        <!--Content section-->
         <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <h2>Update Question(ID): <%=questionno+1%></h2>
                <i>Press "Update Question" to commit</i>
                <hr/>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1-->
                <p class="right">(Original)</p>

                <!--display quiz question-->
                <div id="<%=result.getInt("questionID") %>" class="questioncontainer">
                    <h4> Question </h4> <hr/>
                    <h4><%=result.getString("question") %></h4>
                </div>

                <div class="container2"> 
            <!-- Format for multiple choice -->
            <%
                if(result.getString("type").equals("MC")){
            %>
                    <ul class="answercontainer">
                        <li class="rowinput" ><%=result.getString("input1") %></li>
                        <li class="rowinput" ><%=result.getString("input2") %></li>
                        <li class="rowinput" ><%=result.getString("input3") %></li>
                        <li class="rowinput" ><%=result.getString("input4") %></li>
                    </ul>
                    <center>
                        <p><b>Answer: </b> <%=result.getString("checked")%><br/></p>
                    </center>
            <!-- Format for Fill in the Blank -->
            <%
                }else if(result.getString("type").equals("BL")){
            %>
                    <ul class="choice answercontainer">
                        <li>
                            <span><%=result.getString("input1") %></span>
                            <span class="lefttab"><%=result.getString("input2") %></span>
                            <span class="lefttab"><%=result.getString("input3") %></span>
                            <span class="lefttab"><%=result.getString("input4") %></span>
                        </li>
                    </ul>
                    <center>
                        <p><b>Answer: </b> <%=result.getString("checked")%><br/></p>
                    </center>
            <%
                }else if(result.getString("type").equals("2C")){
            %>
                    <center>
                    <ul>
                        <li>
                            <span><%=result.getString("input1") %></span>
                            <span class="lefttab"><%=result.getString("input2") %></span>
                        </li>
                    </ul> 
                    <div data-ng-if="'<%=result.getString("checked")%>'=== '1'">
                        <b class="answer">Answer: <%=result.getString("input1")%></b>
                    </div>
                    <div data-ng-if="'<%=result.getString("checked")%>'=== '2'">
                        <b class="answer">Answer: <%=result.getString("input2")%></b>
                    </div>
                    </center>
            <%
                }
            %> 
                </div><!--close container2-->         
            </div><!--end column 1.2.4.1-->
            
            <div class="col-xs-6 col-md-6 col-lg-6 border"><!--1.2.4.2-->
                <p>(Update here)</p>
                <form id="updForm" action="" method="POST">
                    <h4 for="que">Question</h4>
                    <input type="hidden" id="que" name="hiddenId" id="hiddenId" value="<%=result.getInt("questionID")%>"/>
                    <textarea name="txtquestion" class="form-control"><%=result.getString("question") %></textarea>
                <!-- Format for multiple choice-->
                <%
                    if(result.getString("type").equals("MC")){
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
                    }else if(result.getString("type").equals("BL")){
                %>
                    <h4>Fill in Blank</h4>
                    <input type="text" name="txtinput1" class="form-control" value="<%=result.getString("input1") %>"/>
                    <input type="text" name="txtinput2" class="form-control" value="<%=result.getString("input2") %>"/>
                    <input type="text" name="txtinput3" class="form-control" value="<%=result.getString("input3") %>"/>
                    <input type="text" name="txtinput4" class="form-control" value="<%=result.getString("input4") %>"/>
            
                <!-- Format for 2 choice selection -->
                <%
                    }else if(result.getString("type").equals("2C")){
                %>    
                    <h4>2 Choice selection</h4>
                        <label for="A" class="col-sm-1">1. </label>
                        <div class="col-sm-11">
                            <input type="text" class="form-control" name="txtinput1" value="<%=result.getString("input1") %>"/>
                        </div>
                        <label for="B" class="col-sm-1">2. </label>
                        <div class="col-sm-11">
                            <input type="text" class="form-control" name="txtinput2" value="<%=result.getString("input2") %>"/>
                        </div>
                            <input type="hidden" class="form-control" name="txtinput3" value="<%=result.getString("input3") %>"/>
                            <input type="hidden" class="form-control" name="txtinput4" value="<%=result.getString("input4") %>"/>               
                <%
                    }
                %>  
                    <h4>Answer</h4>
                    <input type="text" name="txtchecked" class="form-control" value="<%=result.getString("checked") %>"/>
                    
                    <div class="form-group">
                        <br/>
                        <button class="btn btn-primary" type="submit" name="btnUpd" id="btnUpd">Update Question</button>
                        <a class="btn btn-primary" href="question.jsp?quizID=<%=quizID%>&videoID=<%=videoID%>">Cancel</a>
                        <button class="btn btn-primary" type="reset">Reset</button>
                    </div>   
                </form>        
            </div><!--end column 1.2.4.2-->
        </div><!--end row 1.2.4 & end of content section-->
    
    <script>
        CKEDITOR.replace('txtquestion');
    </script>
    
<jsp:include page="footer.jsp"></jsp:include>