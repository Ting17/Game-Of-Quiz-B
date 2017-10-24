<%-- 
    Document   : relatedVideo
    Created on : Aug 8, 2017, 2:58:48 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

         <%!
            Connection conn;
            Statement st;
            ResultSet result;
            String category; 
            Integer videoID; 
        %>

        <%-- READ function for question--%>
        <%
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            videoID = Integer.parseInt(request.getParameter("videoID"));
            category = request.getParameter("categ");
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                st=conn.createStatement();
                
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            } 
        %>
        
    <table>
        <tr>
        <%
            if(videoID == 0){
               result = st.executeQuery("SELECT * FROM video WHERE category = '"+ category +"' ORDER BY RAND ( ) LIMIT 2");
            }
            else{
               result = st.executeQuery("SELECT * FROM video WHERE category = '"+ category +"' and  videoID != '"+ videoID +"' ORDER BY RAND ( ) LIMIT 2");
            }

            while(result.next() ) {  
        %>     
            <td>
                <div class="row">
                    <div class="col-xs-12 col-md-12 col-lg-12">
                       <iframe src="<%=result.getString("videoPath")%>" frameborder="0" allowfullscreen></iframe>
                        <div class="carousel-caption">
                            <h3><%=result.getString("videoName") %></h3>
                            <a href="quiz_page.jsp?videoID=<%=result.getInt("videoID")%>&quizID=<%=result.getInt("videoID")%>&categ=<%=result.getString("category")%>" class="btn btn-primary">Watch Now</a>
                        </div> 
                    </div>
                </div>
            </td>
            
        <%
            }
        %>    
            
        </tr>
    </table>
        
        

