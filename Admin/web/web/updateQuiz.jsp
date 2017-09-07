<%-- 
    Document   : question
    Created on : Apr 25, 2017, 10:48:31 PM
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
<title>Update Quiz</title>
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
            PreparedStatement pstmt;
            Statement stmt, stm,st;
            ResultSet result, rs, res, re;
            Integer quizID, videoID;
            String username, password;
        %>
        
        <%-- READ & UPDATE function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            
            if(request.getParameter("quiz") != null && request.getParameter("quiz")!= ""){  
                quizID = Integer.parseInt(request.getParameter("quiz"));
                videoID = Integer.parseInt(request.getParameter("video"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("SELECT * FROM quiz WHERE quizID = ?");
                    pstmt.setInt(1,quizID);
                    result = pstmt.executeQuery();
                    result.first();

                    stm=conn.createStatement();
                    res = stm.executeQuery("SELECT * FROM video");
                    
                    st=conn.createStatement();
                    re = st.executeQuery("SELECT * FROM video where videoID ='" + videoID +"'");
                    
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
            } 
            
            if(request.getParameter("btnUpd")!=null){
                quizID = Integer.parseInt(request.getParameter("hiddenId"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("UPDATE quiz SET quizTopic = ?, category = ?, videoID = ?, udate = NOW(), lupdateBY = ? WHERE quizID = ?");
                    pstmt.setString(1, request.getParameter("txtName1"));
                    pstmt.setString(2,request.getParameter("txtCate"));
                    pstmt.setString(3,request.getParameter("txtVideo"));
                    pstmt.setString(4,username);
                    pstmt.setInt(5, quizID);
           
                    pstmt.executeUpdate();
                    response.sendRedirect("./quiz.jsp");
                
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
        <div class="row"><!--1.2.3-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.3.1-->
                <h2>Update Quiz</h2>
                <i>Press "Update Quiz" to commit</i>
                <hr/>
            </div><!--end column 1.2.3.1-->
        </div><!--end row 1.2.3-->
        
        <div class="row"><!--1.2.4-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.4.1-->
                <p class="right">(Original)</p>
                
                <p>Created on: <b><%=result.getString("cdate") %></b></p>
                <p>Last updated on: <b><%=result.getString("udate") %></b></p>
                <p>Last updated by: <b><%=result.getString("lupdateBY") %></b></p>
                <p>Current Quiz named: <b><%=result.getString("quizTopic")%></b></p>
                <p>Category: <b><%=result.getString("category")%></b></p>
                <p>Video related to this quiz:
                <%
                    while(re.next()) { 
                %>                
                        <b><%=re.getString("videoName")%></b>
                <% 
                    }
                %>
                </p>
                
            </div><!--end column 1.2.4.1-->
            
            <div class="col-xs-6 col-md-6 col-lg-6 border"><!--1.2.4.2-->
                <p>(Update here)</p>
                
                <form id="updForm" action="" method="POST">
                    <input type="hidden" name="hiddenId" id="hiddenId" value="<%=quizID%>"/>
                    <label>Update quiz name:</label>
                    <input type="text" name="txtName1" id="txtName" value="<%=result.getString("quizTopic")%>" size="40"/><br/><br/>
                    <label>Category:</label>
                    
                    <select name="txtCate">
                        <optgroup label="Language">
                            <option value="Eng">English</option>
                            <option value="BM">Bahasa Malaysia</option>
                            <option value="Mand">Mandarin</option>
                        </optgroup>
                        <optgroup label="Sains">
                            <option value="Sains">Sains</option>
                            <option value="Bio">Biology</option>
                        </optgroup>
                        <optgroup label="Math">
                            <option value="Math">Mathematic</option>
                            <option value="AddMath">Additional Math</option>
                            <option value="MathT">Math T</option>
                        </optgroup>
                        <optgroup label="Other">
                            <option value="Geo">Geography</option>
                        </optgroup>
                    </select><br/><br/>
                    
                    <label>Video related to this quiz:</label>
                    <select name="txtVideo">
                <%
                    while(res.next()) { 
                %>                
                        <option value="<%=res.getInt("videoID")%>"><%=res.getString("videoName")%></option>
                <% 
                    }
                %>
                    </select>
                    
                <div class="form-group">
                    <br/><br/>
                    <button class="btn btn-primary" name="btnUpd" id="btnUpd">Update Quiz</button>
                    <a class="btn btn-danger" href="quiz.jsp">Cancel</a>
                    <button class="btn btn-warning" type="reset">Reset</button>
                    <a class="btn btn-success" href="question.jsp?quiz=<%=quizID%>&video=<%=videoID%>">Go to this quiz questions <span class="glyphicon glyphicon-arrow-right"></span></a>          
                </div>  
                </form>
            </div><!--end column 1.2.4.2-->
        </div><!--end row 1.2.4 & end of content section-->
     
    <jsp:include page="footer.jsp"></jsp:include>
   