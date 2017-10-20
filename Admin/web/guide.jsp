<%-- 
    Document   : help
    Created on : Jul 9, 2017, 2:15:15 PM
    Author     : tingting17
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
<title>Help Page</title>
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
        </div><!--end row 1.2.2 & end of content section-->
        
        <div class="row"><!--1.2.3-->
            <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.3.1-->
                <a data-toggle="collapse" data-target="#1" ><h4>Q1. How to create quiz.</h4></a>
                <div id="1" class="collapse">
                    <hr/>
                    <p>1. Go to 'Quizzes' on the left navigation menu. </p>
                    <p>2. Click on 'New Quiz' to expand the Quiz form. </p>
                    <p>3. After filling up the Quiz form, click 'Add Quiz' button to add new quiz. </p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
                
                <a data-toggle="collapse" data-target="#2"><h4>Q2. How to create quote.</h4></a>
                <div id="2" class="collapse"> 
                    <hr/>
                    <p>1. Go to 'Quote Rewards' on the left navigation menu. </p>
                    <p>2. Click on 'New Quote' to expand the Quote form. </p>
                    <p>3. After filling up the Quote form, click 'Add Quote' button to add new quote. </p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
                
                <a data-toggle="collapse" data-target="#3"><h4>Q3. How to create announcement.</h4></a>
                <div id="3" class="collapse"> 
                    <hr/>
                    <p>1. Go to 'Announcements' on the left navigation menu. </p>
                    <p>2. Click on 'New Announcement' to expand the Announcement form. </p>
                    <p>3. After filling up the Announcement form, click 'Add Announcement' button to add new announcement. </p>
                    <hr class="hreffect"/>
                </div><!--close collapse-->
                
                <a data-toggle="collapse" data-target="#4"><h4>Q4. Display change after leaving it for a period of time without using</h4></a>
                <div id="4" class="collapse">
                    <hr/>
                    <p>Logout and login again.</p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
               
                <a data-toggle="collapse" data-target="#5"><h4>Q5. Upload, Edit, Delete Video</h4></a>
                <div id="5" class="collapse"> 
                    <hr/>
                    <p>Login to <b>ATHENA</b></p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
                
                <a data-toggle="collapse" data-target="#6"><h4>Q6. Check feedback posted by user</h4></a>
                <div id="6" class="collapse"> 
                    <hr/>
                    <p>Contact database person in charge.</p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
                
                <a data-toggle="collapse" data-target="#7"><h4>Q7. Change the pagination number view per page</h4></a>
                <div id="7" class="collapse"> 
                    <hr/>
                    <p>Contact developer team and provide a reason.</p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
                
                <a data-toggle="collapse" data-target="#8"><h4>Q8. VideoID = 0 </h4></a>
                <div id="8" class="collapse"> 
                    <hr/>
                    <p>If videoID = 0 means the it is a quiz without video.</p>
                    <hr class="hreffect"/>
                </div><!--close collapse--> 
            </div><!--end column 1.2.3.1-->
                
            <div class="col-xs-4 col-md-4 col-lg-4 faq"><!--1.2.3.2-->
                <h4>Email Support</h4>
                <p>Can't find the answer to your question? Feel free to <a href="mailto:4331451@students.swinburne.edu.my">contact us</a>. We are always ready to assist you with any question you may have in mind</p>
            </div><!--end column 1.2.3.2-->
        </div><!--end row 1.2.3 & end of content section-->
        
    <jsp:include page="footer.jsp"></jsp:include>