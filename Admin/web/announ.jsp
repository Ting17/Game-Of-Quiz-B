<%-- 
    Document   : announ
    Created on : Jul 10, 2017, 7:58:51 PM
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
<title>Announcement</title>
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
            Statement stmt, st, stat;
            ResultSet result, rs, res;
            Integer announ,adminID;
            String username, password;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            adminID = (Integer)session.getAttribute("aid");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM announcement");
              
                stmt = conn.createStatement();
                rs = stmt.executeQuery("select * from admin where username='" + username + "'");       

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
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.2.1-->
                <h2>Announcement</h2>
                </div>
            <div class="col-xs-6 col-md-6 col-lg-6 right"><!--1.2.2.2-->
                <a class="glyphicon glyphicon-plus-sign" href="#addannoun" data-toggle="collapse" data-target="#addannoun"> New Announcement</a>
            </div>
        </div><!--end row 1.2.2-->
        
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->    
                <div class="table-responsive">
                <table class="table table-stripped table-hover sortable" id="tablepaging">
                    <thead>
                        <tr>
                            <th id="no" scope="col" >No.</th>
                            <th id="announ" scope="col" >Announcement</th>
                            <th id="admin" scope="col">Created by</th>
                            <th id="cdate" scope="col" class="tdcenter">Created on</th>
                            <th id="udate" scope="col" class="tdcenter">Last Updated</th>
                            <th id="more" scope="col" class="tdcenter">Preview</th>
                            <th id="edit" scope="col" class="tdcenter">Edit</th>
                            <th id="delete" scope="col" class="tdcenter">Delete</th>
                        </tr>
                    </thead>                      
                    <tbody>      
        <%
            announ = 1;
            while(result.next()) { 
                     
                stat=conn.createStatement();
                res = stat.executeQuery("select * from admin where adminID ='" + result.getInt("adminID") + "'");       
                while(res.next()) {
        %>
                        <tr>
                            <td headers="no"><%=announ%></td>
                            <td headers="announ"><%=result.getString("announcement") %></td>
                            <td headers="admin"><%=res.getString("username") %></td>
                            <th headers="cdate"><%=result.getString("cdate") %></th>
                            <th headers="udate"><%=result.getString("udate") %></th>
                            <td headers="more" class="tdcenter"><a class="glyphicon glyphicon-eye-open" href="showAnnoun.jsp?id=<%=result.getInt("announID")%>"></a></td>
                            <td headers="edit" class="tdcenter"><a class="glyphicon glyphicon-edit" href="updateAnnoun.jsp?id=<%=result.getInt("announID")%>"></a></td>
                            <td headers="del" class="tdcenter"><a class="glyphicon glyphicon-trash" href="deleteAnnoun.jsp?id=<%=result.getInt("announID")%>" onclick="return confirm('Once confirm, announcement selected will be removed. Confirm to delete?')"></a></td>
                        </tr>
        <%
                announ++;
            }}
        %>
                    </tbody>
                </table>
                <center class="pagi">    
                    <div id="pgNum"></div>
                </center>
                </div>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-12 col-md-12 col-lg-12" ><!--1.2.4.1-->
                <div id="addannoun" class="collapse"> 
                    <hr class="hreffect"/>
                    <h3><u>New Announcement</u></h3>
                    <p>1. Fill in <b>Announcement Title</b>.</p>
                    <p>1. Fill in <b>Announcement Content</b>.</p>
                    <p>2. Click <b>Add Announcement</b> button to add announcement.</p>
                    <hr class="hreffect"/>
                <form id="addForm" action="addAnnoun.jsp" method="POST">
                    <label>Announcement Title: </label>
                    <input type="text" name="txtAnnoun" id="txtAnnoun" size="70"/> <br/><br/>
                    <label>Announcement Content: </label>
                    <textarea name="txtContent" placeholder="Add content here...."></textarea><br/>
                    
                    <div class="right">
                        <button class="btn btn-primary " type="submit" name="btnAdd">Add Announcement</button>
                    </div>
                    <hr class="hreffect"/>
                </form>
                    
                </div><!--close collapse--> 
            </div><!--end column 1.2.4.1-->
        </div><!--end row 1.2.4 & end of content section-->
        
    <script>
        CKEDITOR.replace('txtContent');
    </script>  
        
    <jsp:include page="footer.jsp"></jsp:include>