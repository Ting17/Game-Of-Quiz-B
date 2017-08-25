<%-- 
    Document   : profile
    Created on : Jul 10, 2017, 10:39:10 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">       
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<title>Profile Page</title>
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
        Statement stmt,st1,st2,st3,st4,st5,st6;
        ResultSet result1,result2,result3,result4,result5,result6,rs;
        String username,password;
        Integer quizID;  
        PreparedStatement pstmt;

    %>

    <%-- login function--%>    
    <%
        username = (String)session.getAttribute("uname");
        password = (String)session.getAttribute("pass");
        
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            
            st1=conn.createStatement();
            result1 = st1.executeQuery("SELECT * FROM video");
            
            st2=conn.createStatement();
            result2 = st2.executeQuery("SELECT * FROM quiz");
            
            st3=conn.createStatement();
            result3 = st3.executeQuery("SELECT * FROM reward");
            
            st4=conn.createStatement();
            result4 = st4.executeQuery("SELECT * FROM user");
            
            st5=conn.createStatement();
            result5 = st5.executeQuery("SELECT * FROM feedback");
            
            st6=conn.createStatement();
            result6 = st6.executeQuery("SELECT * FROM announcement");
      
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
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.2.1-->
                <h3>Dashboard</h3>
            </div>
            <div class="col-xs-6 col-md-6 col-lg-6 right"><!--1.2.2.2-->
                <a data-toggle="modal" data-target="#modal">Profile detail</a> 
           
                <!-- View profile Modal -->
                <div class="modal fade" id="modal" role="dialog"> 
                <div class="modal-dialog modal-content">
                    <center>
                    <div class="modal-header">
                        <h3>Profile detail</h3>
                    </div>
                    <div class="modal-body mprofile">
                        <p><b>Name:</b></p><%=rs.getString("name")%>
                        <p><b>Username:</b></p><%=rs.getString("username")%>
                        <p><b>Department:</b></p><%=rs.getString("department")%>
                        <p><b>LDAP Integration:</b></p><%=rs.getString("ldap")%>
                    </div>
                    </center>
                </div>
                </div> 
            </div>
        </div><!--end row 1.2.2-->
               
        <div class="row"><!--1.2.3-->
            <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.1--> 
        <%  
            Integer count1 = 0;
            while(result1.next()) {
                count1++;
            }
        %>          
                <div class="panel panel-primary">
                    <div class="panel-heading"><h4>Total Videos</h4></div>
                    <div class="panel-body"><%=count1%></div>
                </div>
        
        <%  
            Integer count4 = 0;
            while(result4.next()) {
                count4++;
            }
        %>
                <div class="panel panel-primary">
                    <div class="panel-heading"><h4>Total User</h4></div>
                    <div class="panel-body"><%=count4%></div>
                </div>
                
            </div><!--end column 1.2.3.1-->
 
            <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.2-->
        <%  
            Integer count2 = 0;
            while(result2.next()) {
                count2++;
            }
        %>
                <div class="panel panel-primary">
                    <div class="panel-heading"><h4>Total Quizzes</h4></div>
                    <div class="panel-body"><%=count2%></div>
                </div>
        
        <%  
            Integer count5 = 0;
            while(result5.next()) {
                count5++;
            }
        %>
                <div class="panel panel-primary">
                    <div class="panel-heading"><h4>Total User Feedback</h4></div>
                    <div class="panel-body"><%=count5%></div>
                </div>
                
            </div><!--end column 1.2.3.2-->
 
            <div class="col-xs-4 col-md-4 col-lg-4"><!--1.2.3.3-->
        <%  
            Integer count3 = 0;
            while(result3.next()) {
                count3++;
            }
        %>
                <div class="panel panel-primary">
                    <div class="panel-heading"><h4>Total Rewards</h4></div>
                    <div class="panel-body"><%=count3%></div>
                </div>
                
        <%  
            Integer count6 = 0;
            while(result6.next()) {
                count6++;
            }
        %>
                <div class="panel panel-primary">
                    <div class="panel-heading"><h4>Total Announcement</h4></div>
                    <div class="panel-body"><%=count6%></div>
                </div>
            </div><!--end column 1.2.3.3-->
        </div><!--end row 1.2.3 & end of content section--> 
        
 
        <jsp:include page="footer.jsp"></jsp:include>


