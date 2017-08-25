<%-- 
    Document   : updateReward
    Created on : Jul 7, 2017, 1:54:55 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Reward</title>
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
            PreparedStatement pstmt, pstmt2;
            Statement stmt;
            ResultSet result, rs;
            Integer rewardID;
            String username, password;
        %>
        
        <%-- READ & UPDATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            
            if(request.getParameter("btnUpd")!=null){
                rewardID = Integer.parseInt(request.getParameter("hiddenId"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("UPDATE reward SET reward = ?, udate = NOW() WHERE rewardID = ?");
                    pstmt.setString(1, request.getParameter("txtReward"));
                    pstmt.setInt(2, rewardID);
                    pstmt.executeUpdate();
                    response.sendRedirect("./reward.jsp");
                
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }
            }
            
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){  
                rewardID = Integer.parseInt(request.getParameter("id"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("SELECT * FROM reward WHERE rewardID = ?");
                    pstmt.setInt(1,rewardID);
                    result = pstmt.executeQuery();
                    result.first();

                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
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
        
        <!--content section-->
        <div class="row"><!--1.2.2--> 
            <h4>Update Reward</h4><br/>
            <div class="col-xs-8 col-md-8 col-lg-8"><!--1.2.2.1-->  
                <p>Current Reward:</p>
                <b><%=result.getString("reward")%></b>
            </div>
            <div class="col-xs-2 col-md-2 col-lg-2"><!--1.2.2.2-->
                <p>Created on:</p> 
                <b><%=result.getString("cdate") %></b>
            </div>
            <div class="col-xs-2 col-md-2 col-lg-2"><!--1.2.2.3-->
                <p>Last updated on:</p>
                <b><%=result.getString("udate") %></b>
            </div>
        </div> <!--end row 1.2.2-->   
            
        <div class="row"><!--1.2.3--> 
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1--> 
                <br/><br/>
                <form id="updForm" action="" method="POST">
                    <input type="hidden" name="hiddenId" id="hiddenId" value="<%=rewardID%>"/>
                    <label>Update reward:</label>
                    <input type="text" name="txtReward" id="txtReward" value="<%=result.getString("reward")%>" size="70"/>
                    <button class="btn btn-primary" name="btnUpd" id="btnUpd">Update Reward</button>
                </form>     
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3 & end of content section-->                        

    <jsp:include page="footer.jsp"></jsp:include>
