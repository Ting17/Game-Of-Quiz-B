<%-- 
    Document   : reward
    Created on : Jun 21, 2017, 12:25:37 PM
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
<title>Quote List</title>
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
            Statement stmt, stat, st;
            ResultSet result,rs, rst;
            String username,password;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                st=conn.createStatement();
                result = st.executeQuery("SELECT * FROM reward");
                
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
                    <a href="page.jsp" id="profile"><%=rs.getString("username")%></a>
                </div>
        <%
            }
        %>
        
        <jsp:include page="navigator.jsp"></jsp:include>
        
        <!--Content section-->
        <div class="row"><!--1.2.2-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.2.1-->
                <h2>Quotes List</h2>
            </div>
            <div class="col-xs-6 col-md-6 col-lg-6 right"><!--1.2.2.2-->
                <a class="glyphicon glyphicon-plus-sign" href="#addreward" data-toggle="collapse" data-target="#addreward"> New Quote</a>
            </div>
        </div><!--end row 1.2.2-->
        
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <div class="table-responsive">
                <table class="table table-stripped table-hover sortable" id="tablepaging">
                    <thead>
                        <tr>
                            <th id="no" scope="col">No.</th>
                            <th id="quiz" scope="col">Quote</th>
                            <th id="adddate" scope="col">Created on</th>
                            <th id="updatedate" scope="col">Last Update</th>
                            <th id="luBY" scope="col">Last Update by</th>
                            <th id="edit" scope="col" class="tdcenter">Edit</th>
                            <th id="del" scope="col" class="tdcenter">Delete</th>
                        </tr>
                    </thead>                      
                    <tbody>
                <%
                    Integer reward = 1;
                    while(result.next()) {
                        stat=conn.createStatement();
                        rst = stat.executeQuery("select * from admin where adminID ='" + result.getInt("adminID") + "'");       
                        while(rst.next()) {
                %>
                        <tr>
                            <td headers="no"><%=reward%></td>
                            <td headers="reward"><%=result.getString("reward") %></td>
                            <td headers="adddate"><%=result.getString("cdate") %></td>
                            <td headers="updatedate"><%=result.getString("udate") %></td>
                            <td headers="luBY"><%=rst.getString("username") %></td>
                            <td headers="edit" class="tdcenter"><a class="glyphicon glyphicon-edit" href="updateQuote.jsp?id=<%=result.getInt("rewardID")%>"></a></td>
                            <td headers="del" class="tdcenter"><a class="glyphicon glyphicon-trash" href="deleteQuote.jsp?id=<%=result.getInt("rewardID")%>" onclick="return confirm('Once confirm, this quote reward will be removed. Confirm to delete?')"></a></td>
                         </tr> 
                <%
                        reward++;
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
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.4.1-->
                <div id="addreward" class="collapse"> 
                    <hr class="hreffect"/>
                    <h3><u>New Quote</u></h3>
                    <p>1. Fill in <b>Quote Content</b>.</p>
                    <p>2. Click <b>Add Quote</b> button to add quotes.</p>
                    <hr class="hreffect"/>
                <form id="addForm" action="addQuote.jsp" method="POST">
                    <label>Quote Content:</label>
                    <textarea name="txtReward"></textarea>
                    
                    <div class="right">
                        <button class="btn btn-primary" type="submit" name="btnAdd" id="btnAdd">Add Quote</button>
                    </div>
                    <hr class="hreffect"/>
                </form>
                    
                </div><!--close collapse--> 
            </div><!--end column 1.2.4.1-->
        </div><!--end row 1.2.4 & end of content section-->
        
    <script>
        CKEDITOR.replace('txtReward');
    </script>  
    
    <!-- pagination caller; java--> 
    <script src="frameworks/js/paginationCaller.js"></script> 
       
    <jsp:include page="footer.jsp"></jsp:include>
