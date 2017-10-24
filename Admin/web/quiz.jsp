<%-- 
    Document   : question
    Created on : Apr 25, 2017, 10:48:31 PM
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
<title>Quiz List</title>
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
            Statement stmt, st, stm,stat;
            ResultSet result, rs, res, rst;
            Integer adminID;
            String username, password, video,quizID, videoID; 
            String temp;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            adminID = (Integer)session.getAttribute("aid");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM quiz");
              
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");       
                
                stm=conn.createStatement();
                rst = stm.executeQuery("SELECT * FROM video");

            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            }  
        %>
        
<script src="frameworks/js/paginationMethod.js"></script> 

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
        <!--Content section-->
        <div class="row"><!--1.2.2-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.2.1-->
                <h2>Quiz List</h2>
            </div>
            <div class="col-xs-6 col-md-6 col-lg-6 right"><!--1.2.2.2-->
                <a class="glyphicon glyphicon-plus-sign" href="#addquiz?quizID=<%=quizID%>&videoID=<%=videoID%>" data-toggle="collapse" data-target="#addquiz"> New Quiz</a>
            </div>
        </div><!--end row 1.2.2-->

        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <div class="table-responsive">
                <table class="table table-stripped table-hover sortable" id="tablepaging">
                    <thead>
                        <tr>
                            <th id="no" scope="col">No.</th>
                            <th id="quiz" scope="col">Quiz</th>
                            <th id="cato" scope="col">Category</th>
                            <th id="vid" scope="col">VideoID</th>
                            <th id="adddate" scope="col">Created on</th>
                            <th id="updatedate" scope="col">Last Updated</th>
                            <th id="luBY" scope="col">Last Updated by</th>
                            <th id="edit" scope="col" class="tdcenter">Edit</th>
                            <th id="del" scope="col" class="tdcenter">Delete</th>
                        </tr>
                    </thead>                      
                    <tbody>
                <%
                    Integer quizNo = 1;
                    while(result.next()) {
                        quizID = result.getString("quizID");
                        videoID = result.getString("videoID");
                          
                        stat=conn.createStatement();
                        res = stat.executeQuery("select * from admin where adminID ='" + result.getInt("adminID") + "'");       
                        while(res.next()) {
                %>
                        <tr>
                            <td headers="no"><%=quizNo%></td>
                            <td headers="quiz"><a href="question.jsp?quizID=<%=quizID%>&videoID=<%=videoID%>"><%=result.getString("quizTopic") %></a></td>
                            <td headers="cato"><%=result.getString("category") %></td>
                            <td headers="vid"><%=videoID %></td>
                            <td headers="adddate"><%=result.getString("cdate") %></td>
                            <td headers="updatedate"><%=result.getString("udate") %></td>  
                            <td headers="luBY"><%=res.getString("username") %></td> 
                            <td headers="edit" class="tdcenter"><a class="glyphicon glyphicon-edit" href="updateQuiz.jsp?quizID=<%=quizID%>&videoID=<%=videoID%>"></a></td>
                            <td headers="del" class="tdcenter"><a class="glyphicon glyphicon-trash" href="deleteQuiz.jsp?quizID=<%=quizID%>" onclick="return confirm('Once confirm, this topic <%=result.getString("quizTopic") %> will be removed. Confirm to delete?')"></a></td>
                        </tr>     
                <%
                        quizNo++;
                    }}
                %>
                    </tbody>
                </table>
                <center class="pagi">    
                    <div id="pgNum"></div>
                </center>
                </div>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.4.1-->
                <div id="addquiz" class="collapse"> 
                    <hr class="hreffect"/>
                    <h3><u>New Quiz</u></h3>
                    <p>1. Fill in <b>Quiz Topic.</b></p>
                    <p>2. Fill in <b>Note/Video Transcript</b>. (Optional)</p>
                    <p>3. Select <b>Category</b>.</p>
                    <p>4. Select <b>Quiz for Video</b> to include quiz or select <b>none</b> for non-video quiz.</p>
                    <p>5. Click <b>Add Quiz</b> button to add quiz.</p>
                    <hr class="hreffect"/>
                <form id="addForm" action="addQuiz.jsp" method="POST">
                    <label>Quiz ID:</label>
                    <input name="txtID" class="form-control" required/>
                    <label>Quiz Topic:</label>
                    <input name="txtQuiz" class="form-control" required/>
                    <label>Note/Video Transcript:</label>
                    <textarea name="txtNote" class="form-control"></textarea>
                    
                <div class="form-group">  
                    <label>Category:</label>
                    <select name="txtCate">
                        <optgroup label="Language">
                            <option value="Eng">English</option>
                            <option value="BM">Bahasa Malaysia</option>
                            <option value="Mand">Mandarin</option>
                        </optgroup>
                        <optgroup label="Sains">
                            <option value="Sains">Sains</option>
                            <option value="Bio">Biology</option>
                        </optgroup>
                        <optgroup label="Math">
                            <option value="Math">Mathematic</option>
                            <option value="AddMath">Additional Math</option>
                            <option value="MathT">Math T</option>
                        </optgroup>
                        <optgroup label="Other">
                            <option value="Geo">Geography</option>
                        </optgroup>
                    </select>
                </div>
                <div class="form-group">  
                    <label>Quiz for video:</label>
                    <select name="txtVideo">
                        <option value="0">none</option>
                <%
                    while(rst.next()) { 
                %>                
                        <option value="<%=rst.getString("videoID")%>"><%=rst.getString("videoName")%></option>                        
                <% 
                    }
                %>
                    </select>
                </div>
                <div class="right">
                    <button class="btn btn-primary" type="submit" name="btnAdd" id="btnAdd">Add Quiz</button>
                </div>
                    <hr class="hreffect"/>
                </form>
                </div><!--close collapse--> 
            </div><!--end column 1.2.4.1-->
        </div><!--end row 1.2.4 & end of content section-->
      
    <script>
        CKEDITOR.replace('txtNote');
    </script>    
        
    <!-- pagination caller; java--> 
    <script src="frameworks/js/paginationCaller.js"></script>  
    
    <jsp:include page="footer.jsp"></jsp:include>
   