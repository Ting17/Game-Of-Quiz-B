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
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Quote</title>
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
            PreparedStatement pstmt, pstmt2;
            Statement stmt, stat;
            ResultSet result, rs, ress;
            Integer rewardID, adminID;
            String username, password;
        %>
        
        <%-- READ & UPDATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            adminID = (Integer)session.getAttribute("aid");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            
            if(request.getParameter("btnUpd")!=null){
                rewardID = Integer.parseInt(request.getParameter("hiddenId"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("UPDATE reward SET reward = ?, udate = NOW(),adminID = ? WHERE rewardID = ?");
                    pstmt.setString(1, request.getParameter("txtReward"));
                    pstmt.setInt(2, rewardID);
                    pstmt.setInt(3, adminID);
                    pstmt.executeUpdate();
                    response.sendRedirect("./quote.jsp");
                
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
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.2.1-->
                <h2>Update Quote</h2>
                <i>Press "Update Quote" to commit</i>
                <hr/>
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2-->
        
        
        <div class="row"><!--1.2.3--> 
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.3.1-->  
                <p class="right">(Original)</p>
                
                <p>Created on: <b><%=result.getString("cdate") %></b></p>
                <p>Last updated on: <b><%=result.getString("udate") %></b></p>
        <%
            stat=conn.createStatement();
            ress = stat.executeQuery("select * from admin where adminID ='" + result.getInt("adminID") + "'");       
            while(ress.next()) {
        %>        
                <p>Last updated by: <b><%=ress.getString("username") %></b></p>
        <%
            }
        %>
                <p>Current Quote:</p>
                <b><%=result.getString("reward")%></b>
            </div><!--end column 1.2.3.1-->
     
            <div class="col-xs-6 col-md-6 col-lg-6 border"><!--1.2.3.2-->
                <p>(Update here)</p>
                <form id="updForm" action="" method="POST">
                    <input type="hidden" name="hiddenId" id="hiddenId" value="<%=rewardID%>"/>
                    <label>Update Quote:</label>
                    <textarea name="txtReward"><%=result.getString("reward")%></textarea>
                    <button class="btn btn-primary" name="btnUpd" id="btnUpd">Update Quote</button>
                </form>     
            </div><!--end column 1.2.3.2-->
        </div><!--end row 1.2.3 & end of content section-->                        

    <script>
        CKEDITOR.replace('txtReward');
    </script>  
    
<jsp:include page="footer.jsp"></jsp:include>
