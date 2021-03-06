<%-- 
    Document   : addNewQuiz
    Created on : Sep 26, 2017, 9:21:15 AM
    Author     : Kevin Pui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Quiz</title>
        <meta name="viewport" content="width=device-width, initialscale=1.0"/>
        <!-- Bootstrap -->
        <link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
        <!-- StyleSheet -->
        <link href="frameworks/css/style.css" rel="stylesheet" />
        <!-- Rich Text -->
        <script src="frameworks/ckeditor_4.7.2_standard/ckeditor/ckeditor.js"></script>
    </head>
    <body>
        <%!
            Connection conn;
            Statement stmt, st, stm;
            ResultSet result, rs, rst;
            Integer quizID,adminID;
            String username, password, category="", videoname, videoID;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            adminID = (Integer)session.getAttribute("aid");
            
            videoID = request.getParameter("videoID");
            category = request.getParameter("categ");
            
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
        <%
            if(category.equalsIgnoreCase("Science ")){
                category = "Science & Technology";
            }
            while(rst.next()){
                if(rst.getString("videoID").equals(videoID)){
                    videoname = rst.getString("videoName");
        %>
        
        <div class="row"><!--1.2.2-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.2.1-->
                <div id="addquiz"> 
                    <hr class="hreffect"/>
                    <a href="<%=rst.getString("videoPath")%>" class="video_layer" target="_blank"><h1 class="newheader"><%=videoname%> <span class="glyphicon glyphicon-facetime-video"></span></h1></a>
        <%
                        
                }   
            }
        %>
                    <h3><u>New Quiz</u></h3>
                    <p>1. Fill in <b>Quiz Topic.</b></p>
                    <p>2. Fill in <b>Note/Video Transcript</b>. (Optional)</p>
                    <p>3. Click <b>Add Quiz</b> button to add quiz.</p>
                    <hr class="hreffect"/>
                <form id="addForm" action="addQuiz.jsp" method="POST">
                    <h3>Category: <%=category%></h3>
                    <label>Quiz ID:</label>
                    <input name="txtID" class="form-control"/>
                    <label>Quiz Topic:</label>
                    <input name="txtQuiz" class="form-control"/>
                    <label>Note/Video Transcript:</label>
                    <textarea name="txtNote" class="form-control"></textarea>
                    
                <div class="form-group" style="display: none">  
                    <label>Category:</label>
                    <select name="txtCate">
                        <option><%=category%></option>
                    </select>
                </div>
         
                <div class="form-group" style="display: none">  
                    <label>Quiz for video:</label>
                    <select name="txtVideo">
                        <option><%=videoID%></option>
                    </select>
                </div>
                <div class="right">
                    <button class="btn btn-primary" type="submit" name="btnAdd" id="btnAdd">Add Quiz</button>
                </div>
                    <hr class="hreffect"/>
                </form>
                </div><!--close collapse--> 
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2 & end of content section-->
        
    <script>
            CKEDITOR.replace('txtNote');
 
            $('.video_layer').colorbox({iframe:true});
   
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
    <jsp:include page="footer.jsp"></jsp:include>
