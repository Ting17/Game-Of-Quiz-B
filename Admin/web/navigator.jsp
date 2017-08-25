<%-- 
    Document   : header
    Created on : Jun 23, 2017, 10:37:39 AM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
  
            <a href="video.jsp" class="tabselect">Videos <span class="glyphicon glyphicon-menu-right"></span></a>
            <a href="quiz.jsp" class="tabselect">Quizzes <span class="glyphicon glyphicon-menu-right"></span></a>
            <a href="reward.jsp" class="tabselect">Rewards <span class="glyphicon glyphicon-menu-right"></span></a>
            <a href="user.jsp" class="tabselect">Users <span class="glyphicon glyphicon-menu-right"></span></a>
            <a href="feedback.jsp" class="tabselect">User Feedbacks <span class="glyphicon glyphicon-menu-right"></span></a>
            <a href="announ.jsp" class="tabselect">Announcements <span class="glyphicon glyphicon-menu-right"></span></a>
            <a href="help.jsp" class="tabselect">Helps <span class="glyphicon glyphicon-menu-right"></span></a>
        </div><!--end column 1.1 & close tab-->
        
        <div class="col-xs-10 col-md-10 col-lg-10"><!--1.2--> 
            <!-- navigation -->
            <div class="row" id="top"><!--1.2.1-->
                <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.1.1-->
                    <img src="resources/img/banner.jpg" alt="banner" />
                    <nav class="navbar navbar-default">
                    <div class="container-fluid">
                    <div class="navbar-header">
                        <p class="navbar-brand">Welcome Back Admin !!!</p>
                    </div>
    
                    <div class="navbar-header"> 
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-to-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button> 
                    </div>
        
                    <div class="navbar-collapse collapse" id="navbar-to-collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="">Athena</a></li>
                            <li>
                                <form class="navbar-form navbar-left" role="search" id="icon" name="cse" action="http://www.google.com/search" target="_blank">
                                <table>
                                    <tr>
                                        <td>
                                            <input type="hidden" name="ie" value="utd-8">
                                            <input class="form-control" type="text" name="q" size="20" maxlength="255" placeholder="Google site search">
                                            <input type="submit" value="Go!" class="btn btn-primary">
                                        </td>
                                    </tr>
                                </table>
                                </form>
                            </li> 
                            <li><a href='index.html'>Log out</a></li>
                        </ul>  
                    </div><!--end navigation collapse-->        
                    </div><!--close container-->
                    </nav>
                </div><!--end column 1.2.1.1-->
            </div><!--end row 1.2.1 & end of navigation-->