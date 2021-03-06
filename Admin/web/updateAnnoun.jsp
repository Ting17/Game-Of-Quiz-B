<%-- 
    Document   : updateAnnoun
    Created on : Aug 28, 2017, 1:54:55 PM
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
<title>Update Announcement</title>
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
            ResultSet result, rs, rst;
            Integer announID,adminID;
            String username, password;
        %>
        
        <%-- READ & UPDATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            adminID = (Integer)session.getAttribute("aid");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            
            if(request.getParameter("btnUpd")!=null){
                announID = Integer.parseInt(request.getParameter("hiddenId"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("UPDATE announcement SET announcement = ?, content = ?, adminID = ?, udate = NOW() WHERE announID = '" + announID +"'");
                    pstmt.setString(1, request.getParameter("txtAnnoun"));
                    pstmt.setString(2, request.getParameter("txtContent"));
                    pstmt.setInt(3, adminID);
                    pstmt.executeUpdate();
                    response.sendRedirect("./announ.jsp");
                
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                }
            }
            
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){  
                announID = Integer.parseInt(request.getParameter("id"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("SELECT * FROM announcement WHERE announID = '" + announID +"'");
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
                <h2>Update Announcement</h2>
                <i>Press "Update Announcement" to commit</i>
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
            rst = stat.executeQuery("select * from admin where adminID ='" + result.getInt("adminID") + "'");       
            while(rst.next()) {
        %>         
                <p>Last updated by: <b><%=rst.getString("username") %></b></p> 
        <%
            }
        %>
                <p>Current Announcement Title:</p>
                <b><%=result.getString("announcement")%></b>
                <p>Current Announcement Content:</p>
                <b><%=result.getString("content")%></b>
            </div><!--end column 1.2.3.1-->
    
            <div class="col-xs-6 col-md-6 col-lg-6 border"><!--1.2.3.2-->
                <p>(Update here)</p>
                <form id="updForm" action="" method="POST">
                    <input type="hidden" name="hiddenId" id="hiddenId" value="<%=announID%>"/>
                    <label>Update Announcement Title:</label>
                    <input type="text" name="txtAnnoun" id="txtAnnoun" size="70" value="<%=result.getString("announcement")%>"/> <br/><br/>
                    <label>Update Announcement Content:</label>
                    <textarea name="txtContent"><%=result.getString("content")%></textarea>
                    <button class="btn btn-primary" name="btnUpd" id="btnUpd">Update Announcement</button>
                </form>     
            </div><!--end column 1.2.3.2-->
        </div><!--end row 1.2.3 & end of content section-->                        

    <script>
        CKEDITOR.replace('txtContent');
    </script>  
    
<jsp:include page="footer.jsp"></jsp:include>
