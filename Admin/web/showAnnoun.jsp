<%-- 
    Document   : showQuestion
    Created on : Sep 22, 2017, 5:05:42 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui -->
<!-- Last update: 2017-->
    
<title>Preview Announcement</title>
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
            PreparedStatement pstmt;
            ResultSet result,res,rs,ress;
            Integer announID; 
            String username,password;
            Statement stmt, st,stat;
        %>
        
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass"); 

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){  
                announID = Integer.parseInt(request.getParameter("id"));
                 
              try{
                Class.forName("com.mysql.jdbc.Driver");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from admin where username='" + username + "'");       
                 
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM announcement where announID='" + announID + "'");

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
    <%  
        if (result.next()) {
    %>
                <b>Announcement</b> 
                <a href="announ.jsp"><%=result.getString("announcement")%></a>
    
            </div><!--end column-->
        </div><!--end row & end of breadcrumb-->
            
        <!--Content section-->
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
            <h2>Preview Announcement</h2>
            <hr/>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1-->
                <p class="right">(announcement)</p>

                <p><b><%=result.getString("announcement") %></b></p>
                <p><b><%=result.getString("content") %></b></p>
            </div><!--end column 1.2.4.1-->
            
            <div class="col-xs-6 col-md-6 col-lg-6 border"><!--1.2.4.2-->
                <p>(detail for announcement)</p>
                <br/>
                <p><b>Created On:</b><%=result.getString("cdate") %></p>
                <p><b>Last Updated on</b><%=result.getString("udate") %></p>
    <%
        stat=conn.createStatement();
        res = stat.executeQuery("select * from admin where adminID ='" + result.getInt("adminID") + "'");       
        while(res.next()) {
    %>
                <p><b>Last Updated by:</b> <%=res.getString("username") %></p>
    <%
        }}
    %>            
                <a class="btn btn-primary" href="updateAnnoun.jsp?id=<%=result.getInt("announID")%>">Update</a>
                <a class="btn btn-success" href="announ.jsp">Back</a>
                <a class="btn btn-danger" href="deleteAnnoun.jsp?id=<%=result.getInt("announID")%>" onclick="return confirm('Once confirm, announcement selected will be removed. Confirm to delete?')">Delete</a>
            </div><!--end column 1.2.4.2-->   
        </div><!--end row 1.2.4 & end of content section-->

        <jsp:include page="footer.jsp"></jsp:include>