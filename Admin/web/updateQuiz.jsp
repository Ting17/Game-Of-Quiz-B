<%-- 
    Document   : updateQuiz
    Created on : Apr 25, 2017, 10:48:31 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui  -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Quiz</title>
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
            Statement stmt, stm, st, stat,s; 
            ResultSet result, rs, res, re, rst;
            Integer adminID;
            String username, password,quizID, videoID;
        %>
        
        <%-- READ & UPDATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            adminID = (Integer)session.getAttribute("aid");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            
            if(request.getParameter("quizID") != null && request.getParameter("quizID")!= ""){  
                quizID = request.getParameter("quizID");
                videoID = request.getParameter("videoID");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    
                    s=conn.createStatement();
                    result = s.executeQuery("SELECT * FROM quiz WHERE quizID ='" + quizID + "'"); 
                    result.first();
                    stm=conn.createStatement();
                    res = stm.executeQuery("SELECT * FROM video");
                    
                    st=conn.createStatement();
                    re = st.executeQuery("SELECT * FROM video where videoID ='" + videoID +"'");
                    
                    stat=conn.createStatement();
                    rst = stat.executeQuery("select * from admin where adminID ='" + result.getInt("adminID") + "'"); 
                    
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
                    
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
            } 
            
            if(request.getParameter("btnUpd")!=null){
                quizID = request.getParameter("hiddenId");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("UPDATE quiz SET quizTopic = ?, category = ?, videoID = ?, note = ?, udate = NOW(), adminID = ? WHERE quizID = ?");
                    pstmt.setString(1, request.getParameter("txtName1"));
                    pstmt.setString(2,request.getParameter("txtCate"));
                    pstmt.setString(3,request.getParameter("txtVideo"));
                    pstmt.setString(4,request.getParameter("txtQuiz"));
                    pstmt.setInt(5,adminID);
                    pstmt.setString(6,quizID);
           
                    pstmt.executeUpdate();
                    response.sendRedirect("./quizlist.jsp");
                
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
                <b>Quiz:</b> 
                <a onclick="history.back()"><%=result.getString("quizTopic")%></a> > Update
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2 & end of breadcrumb-->
        
        <!--content section-->
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <h2>Update Quiz</h2>
                <i>Press "Update Quiz" to commit</i>
                <hr/>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1-->
                <p class="right">(Original)</p>
        <%
            while(rst.next()) {
        %> 
                <p>Created on: <b><%=result.getString("cdate") %></b></p>
                <p>Last updated on: <b><%=result.getString("udate") %></b></p>
                <p>Last updated by: <b><%=rst.getString("username") %></b></p>
                <p>Current Quiz title: <b><%=result.getString("quizTopic")%></b></p>
                <p>Category: <b><%=result.getString("category")%></b></p>
        <%
            }   
            if(re.next()) {
        %>
               <p>Video related to this quiz:<a href="<%=re.getString("videoPath")%>" class="video_layer" target="_blank"><b><%=re.getString("videoName")%></b></a></p> 
                <script>
                $('.video_layer').colorbox({iframe:true});
                </script>     
                <%
                    }
                %>
                <p>Note/Transcript:</p>
                <div class="note">
                    <p><b><%=result.getString("note")%></b></p>
                </div>
            </div><!--end column 1.2.4.1-->
    <script>
        jQuery('.youtube-player').each(function(){
            jQuery(this).on('click', '.youtube-link-start', function(){
                jQuery(this).parent().addClass('active');
                var loc = $(this).siblings('iframe').attr('src');
                var startloc = loc + "?autoplay=1";
                $(this).siblings('iframe').attr('src', startloc);
            });
            jQuery(this).on('click', '.youtube-link-stop', function(){
                jQuery(this).parent().removeClass('active');
                var loc = $(this).siblings('iframe').attr('src');
                var stoploc = loc.replace("?autoplay=1", "");
                $(this).siblings('iframe').attr('src', stoploc);
            });
        });
    </script>
            <div class="col-xs-6 col-md-6 col-lg-6 border"><!--1.2.4.2-->
                <p>(Update here)</p>
                
                <form id="updForm" action="" method="POST">
                    <input type="hidden" name="hiddenId" id="hiddenId" value="<%=quizID%>"/>
                    <label>Update quiz title:</label>
                    <input type="text" name="txtName1" id="txtName" value="<%=result.getString("quizTopic")%>" size="40"/><br/><br/>
                    <label>Category:</label>
                    
                    <select name="txtCate">
                        <optgroup label="Language">
                            <option value="English">English</option>
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
                            <option value="Geography">Geography</option>
                            <option value="History">History</option>
                        </optgroup>
                    </select><br/><br/>
                    
                    <label>Video related to this quiz:</label>
                    <select name="txtVideo">
                        <option value="0">none</option>
                <%
                    while(res.next()) { 
                %>                
                        <option value="<%=res.getString("videoID")%>"><%=res.getString("videoName")%></option>
                <% 
                    }
                %>
                    </select><br/><br/>
                    
                    <label>Note/Transcript:</label>
                    <textarea name="txtQuiz" class="form-control"><%=result.getString("note") %></textarea>
                    
                <div class="form-group">
                    <br/><br/>
                    <button class="btn btn-primary" name="btnUpd" id="btnUpd">Update Quiz</button>
                    <a class="btn btn-danger" href="quizlist.jsp">Cancel</a>
                    <button class="btn btn-warning" type="reset">Reset</button>
                    <a class="btn btn-success" href="question.jsp?quizID=<%=quizID%>&videoID=<%=videoID%>">Go to this quiz questions <span class="glyphicon glyphicon-arrow-right"></span></a>          
                </div>  
                </form>
            </div><!--end column 1.2.4.2-->
        </div><!--end row 1.2.4 & end of content section-->
     
        <script>
            CKEDITOR.replace('txtQuiz');
        </script>
        
    <jsp:include page="footer.jsp"></jsp:include>