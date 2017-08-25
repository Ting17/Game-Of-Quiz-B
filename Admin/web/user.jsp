<%-- 
    Document   : user
    Created on : Jul 12, 2017, 9:13:12 PM
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
<title>User List</title>
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
            Statement stmt, st;
            ResultSet result, rs;
            String username, password;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM user");
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
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
        
        <!--Content section-->
        <div class="row"><!--1.2.2-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.2.1-->
                <h2>User List</h2>
                <div class="table-responsive">
                    <table class="table table-stripped table-hover sortable" id="tablepaging">
                        <thead>
                            <tr>
                                <th id="no" scope="col">No.</th>
                                <th id="user" scope="col">User</th>
                                <th id="res" scope="col">Result</th>
                                <th id="del" scope="col" class="tdcenter">Delete</th>
                            </tr>
                        </thead>                      
                        <tbody>
                    <%
                        Integer userNo = 1;
                        while(result.next() ) {
                    %>
                            <tr>
                                <td headers="no"><%=userNo%></td>
                                <td headers="user"><%=result.getString("username") %></td>
                                <td headers="res"><%=result.getString("result") %></td>
                                <td headers="del" class="tdcenter"><a class="glyphicon glyphicon-trash" href="deleteUser.jsp?id=<%=result.getInt("userID")%>" onclick="return confirm('Once confirm, <%=result.getString("username") %> will be removed from list. Confirm to delete?')"></a></td>
                            </tr>     
                    <%
                            userNo++; 
                        }
                    %>
                        </tbody>
                    </table>       
                    <center class="pagi">    
                        <div id="pgNum"></div>
                    </center>
                </div>
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2 & end of content section-->
        
    <jsp:include page="footer.jsp"></jsp:include>