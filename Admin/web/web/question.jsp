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
<title>Question List</title>
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
            ResultSet result,res,rs;
            Integer quizID, questionNo, videoID;
            String username,password,questionID,title;
            Statement stmt, st;
        %>
        
        <%-- READ function--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("quiz") != null && request.getParameter("quiz")!= ""){  
                quizID = Integer.parseInt(request.getParameter("quiz"));
                videoID = Integer.parseInt(request.getParameter("video"));
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    pstmt = conn.prepareStatement("SELECT * FROM question WHERE quizID ='" + quizID+"'");
                    result = pstmt.executeQuery();

                    st = conn.createStatement();
                    res = st.executeQuery("select * from quiz where quizID='" + quizID + "'");

                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("select * from admin where username='" + username + "' and password='" + password + "'");

                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
            }else{
                response.sendRedirect("./index.html");
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
                    <a href="profile.jsp" id="profile"><%=rs.getString("name")%></a>
                </div>
        <%
            }
        %>
        
        <jsp:include page="navigator.jsp"></jsp:include>
        <!--breadcrumb-->
        <div class="row"><!--1.2.2-->
            <div class="col-xs-12 col-md-12 col-lg-12 "><!--1.2.2.1-->
        <%  if (res.next()) {
        %>
                <b>Quiz:</b> 
                <a href="quiz.jsp"><%=res.getString("quizTopic")%></a> > Question List
        <%
            }
        %>
            </div><!--end column 1.2.2.1-->
        </div><!--end row 1.2.2 & end of breadcrumb-->
            
        <!--Content section-->
        <div class="row"><!--1.2.3-->
            <div class="col-xs-6 col-md-6 col-lg-6"><!--1.2.3.1-->
                <h2>Question List</h2>
            </div>
            <div class="col-xs-6 col-md-6 col-lg-6 right"><!--1.2.3.2-->
                <a class="glyphicon glyphicon-plus-sign" href="addQuestion.jsp?quiz=<%=quizID%>&video=<%=videoID%>"> New Question</a>
            </div>
        </div><!--end row 1.2.3 -->
            
        <div class="row"><!--1.2.4-->
            <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.4.1-->   
                <div class="table-responsive">
                <table class="table table-stripped table-hover sortable" id="tablepaging">
                    <thead>
                        <tr>
                            <th id="no" scope="col" >No.</th>
                            <th id="quez" scope="col" >Question</th>
                            <th id="typeq" scope="col" class="tdcenter">Type</th>
                            <th id="more" scope="col" class="tdcenter">Preview</th>
                            <th id="edit" scope="col" class="tdcenter">Edit</th>
                            <th id="delete" scope="col" class="tdcenter">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
        <%
            questionNo = 1;
            while(result.next()) {
                quizID = result.getInt("quizID");
                if(result.getString("type").equals("M")){
                    title="Multiple-Choice";
                }else if(result.getString("type").equals("B")){
                    title="Fill-in-Blank";
                }else{
                    title="True-or-False";
                }
        %>
                        <tr>
                            <td headers="no"><%=questionNo%></td>
                            <td headers="quez"><%=result.getString("question") %></td>
                            <td headers="typeq" class="tdcenter" title=<%=title%>><%=result.getString("type") %></td>
                            <td headers="more" class="tdcenter"><a class="glyphicon glyphicon-eye-open" href="showQuestion.jsp?question=<%=result.getInt("questionID")%>&quiz=<%=result.getInt("quizID")%>&video=<%=videoID%>"></a></td>
                            <td headers="edit" class="tdcenter"><a class="glyphicon glyphicon-edit" href="updateQuestion.jsp?question=<%=result.getInt("questionID")%>&quiz=<%=result.getInt("quizID")%>&video=<%=videoID%>"></a></td>
                            <td headers="del" class="tdcenter"><a class="glyphicon glyphicon-trash" href="deleteQuestion.jsp?question=<%=result.getInt("questionID")%>&quiz=<%=result.getInt("quizID")%>&video=<%=videoID%>" onclick="return confirm('Once confirm, question <%=result.getInt("questionID")+1 %> will be removed. Confirm to delete?')"></a></td>
                        </tr>
        <%
                questionNo++;
            }
        %>
                    </tbody>   
                </table>
                <center class="pagi">    
                    <div id="pgNum"></div>
                </center>
                </div>
            </div><!--end column 1.2.4.1-->
        </div><!--end row 1.2.4.1 & end of content section-->

          
    <jsp:include page="footer.jsp"></jsp:include>
   
    
                                 