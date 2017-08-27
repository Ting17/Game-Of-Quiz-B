<%-- 
    Document   : question
    Created on : Apr 29, 2017, 11:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html data-ng-app="myApp">
    
<head>
        
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Claim Reward</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="rewardstyle.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="languages.min.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Claim Reward</title>         
</head>

<body class="bonus3">
       <%!
            Connection conn;
            PreparedStatement pstmt;
            ResultSet result;
            Integer videoID;
        %>

        <%-- READ function for question--%>
        <%
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                pstmt = conn.prepareStatement("SELECT * FROM reward ORDER BY RAND ( ) LIMIT 1"); 
                result = pstmt.executeQuery(); 
                
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            } 
        %>
        
    <audio autoplay>
      <source src="sound/bonus3.mp3" type="audio/mpeg">
    </audio>


        <div class="row quotewrapper"><!--1-->
            <div class="col-xs-12 col-md-12 col-lg-12 quotewrap"><!--1.1-->
                <div class="quote-icon">&#8220;</div>
                <%
                    while(result.next() ) {
                %>                
                    <h3 class="quote-quote"><%=result.getString("reward") %></h3>
                <%
                    } 
                %>  
            </div> <!--close column 1.1-->
        </div> <!--close row 1-->

        <div class="row"><!--2-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--2.1-->
                <a class="btn btn-primary btn-lg qbutton" href="video2.jsp">Back to Video page</a>
                <a class="btn btn-default btn-lg qbutton" href="profile.jsp">Back to profile</a>
            </div><!--close column 2.1-->
        </div><!--close row 2-->

    
<!-- jQuery – required for Bootstrap's JavaScript plugins) -->
<script src="frameworks/js/jquery.min.js"></script>

<!-- All Bootstrap plug-ins file -->
<script src="frameworks/js/bootstrap.min.js"></script>
    
<!-- Basic AngularJS-->
<script src="frameworks/js/angular.js"></script>
        
<!-- Angular-route-->
<script src="frameworks/js/angular-route.min.js"></script>   

<!-- Configuration-->
<script src="frameworks/js/gameOQ.js"></script>    

</body>
</html>
        

        
       