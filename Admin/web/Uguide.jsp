<%-- 
    Document   : Uguide
    Created on : Oct 28, 2017, 2:19:24 PM
    Author     : Kevin Pui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui-->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Guide Page</title>
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
            Statement stmt;
            ResultSet rs;
            String username, password;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");  
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
            }
        %>
        
        <jsp:include page="navigator.jsp"></jsp:include>
        
        <!--Content section-->
        <div class="row"><!--1.2.2-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.2.1-->
                <h2>Admin Guide</h2>
                <hr/>
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2-->
        
        <div class="row"><!--1.2.3-->
            <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1-->
                <h3><b>User Guide</b></h3>
                <p>We encourage you to <span class="yellow">explore</span> around. So here is some basic guide to experience Game Of Quiz.</p>
                    
                <a data-toggle="collapse" data-target="#1" ><h4>Step 1 Choose your topic</h4></a>
                <div id="1" class="collapse">
                    <hr/>
                    <p>1. You can choose quizzes based on video in <b>Equilibra home page<b> or either quiz with video or quiz without video in <b>Quiz List page</b>.</p>
                    <p>2. In <b>Quiz List page</b> <span class="glyphicon glyphicon-facetime-video"></span> represent the quiz with video.</p>        
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
                
                <a data-toggle="collapse" data-target="#2"><h4>Step 2 Look for instructions/rules</h4></a>
                <div id="2" class="collapse"> 
                    <hr/>
                    <p>1. Look for Pusheen for instructions/rules <img src="resources/img/cat.gif" class="cat"/></p>
                    <p>2. Read the note to know how to collect star and claim "game time".</p>
                    <p>3. Stars will be your token for future event; "game time" is for your minute break.</p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
                
                <a data-toggle="collapse" data-target="#3"><h4>Step 3 Sent your feedback based on quiz you attend <i>(optional)</i></h4></a>
                <div id="3" class="collapse"> 
                    <hr/>
                    <p>1. Look for feedback button under Pusheen <img src="resources/img/cat.gif" class="cat"/></p>
                    <p>2. Click it and feedback form will show just right below it.</p>
                    <p>3. Submit your feedback based on the quiz you attending <u>ONLY</u>. You can write anything. Eg: Error/mistake found</p>
                    <hr class="hreffect"/>
                </div><!--close collapse-->
                
                <a data-toggle="collapse" data-target="#4"><h4>Step 4 Attend other quizzes or watch other videos else Logout your account</h4></a>
                <div id="4" class="collapse">
                    <hr/>
                    <p>1. You are encourage to attend other quizzes or other videos to gain more knowledge or as entertainment</p>
                    <p>2. Related video and video quizzes are sort based on category you currently answering. It is located right on top of footer (You can find it easily, for sure). You can watch related video or answer related video quiz.</p>
                    <p>3. Remember to Logout your account. Make it as a practice. You can logout through <b>Equilibra home page</b>, <b>Quiz list page</b>, <b>Announcement page</b> or <b>this page (User Guide).</b></p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
            </div><!--end column 1.2.3.1-->
            <div class="col-xs-4 col-md-4 col-lg-4 faq"><!--1.2.3.2-->
                <h4>Email Support</h4>
                <p>Can't find the answer to your question? Feel free to <a href="mailto:4331451@students.swinburne.edu.my">contact us</a>. We are always ready to assist you with any question you may have in mind</p>
            </div><!--end column 1.2.3.2-->
        </div><!--end row 1.2.3 & end of content section-->
        
    <jsp:include page="footer.jsp"></jsp:include>