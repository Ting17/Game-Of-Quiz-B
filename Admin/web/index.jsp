<%-- 
    Document   : index
    Created on : Oct 24, 2017, 10:48:01 AM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>       
<meta charset="UTF-8">       
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting, Kevin Pui-->
<!-- Last update: 2017-->
    
<title>Game of Quiz</title>
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
   
    <div class="row"><!--1--> 
        <div class="col-xs-7 col-md-7 col-lg-7 landing"><!--1.1--> 
        </div>
        
        <div class="col-xs-5 col-md-5 col-lg-5 "><!--1.2--> 
            <center class="loginwrap">
            <!--error message-->
            <p>${msg}</p>
            
            <h1>Login to your account</h1>
            <form method="post" action="home.jsp">
            <fieldset>
                <input type="text" class="login" name="username" value="" placeholder="Username" required><br/>
                <input type="password" class="login" name="password" value="" placeholder="password" required/><br/>
                <button type="submit" class="btn btn-primary btnlog">Login</button>
            </fieldset>
            </form>
            
            <b>New here?<a class="signupa" data-toggle="modal" data-target="#modal">Sign Up here</a></b> 
            </center>
                <!-- Signup Modal -->
                <div class="modal fade" id="modal" role="dialog"> 
                <div class="modal-dialog modal-content">
                    <center>
                    <div class="modal-header">
                        <h4 class="modal-title">Sign Up<span class="glyphicon glyphicon-pencil"></span></h4>
                        <p>It's free and always will be</p>
                    </div>
                    <div class="modal-body">
                    <form method="post" action="signup.jsp">
                    <fieldset>
                        <label>Username:</label><br/>
                        <input type="text" class="signup" name="username" placeholder="Username"><br/>
                        <label>Name:</label><br/>
                        <input type="text" class="signup" name="name" placeholder="name"/><br/>
                        <label>Department:</label><br/>
                        <input type="text" class="signup" name="department" placeholder="department"/><br/>
                        <label>Password:</label><br/>
                        <input type="text" class="signup" name="password" placeholder="password"/><br/>
                        
    <!-- PASSWORD -->
    <div class="form-inline">
        <label>Password</label>
        <div class="row">
        <div class="col-xs-6 col-sm-6 col-lg-6">
            <div class="form-group">
                <input type="password" name="Password" class="form-control" placeholder="Password">
            </div>
        </div>         
        <div class="col-xs-6 col-sm-6 col-lg-6">
            <!-- COMFIRMATION PASSWORD -->
            <div class="form-group">
                <input type="password" name="cpass" class="form-control" placeholder="Comfirmation password">
            </div>
        </div>
        </div>
    </div>
                                           
                        <button class="btn btn-primary" type="submit" name="signup">Sign Up</button>
                    </fieldset>
                    </form>
                    </div>
                    </center>
                </div>
                </div> 
        </div>  
    </div>

     
       
<!-- jQuery – required for Bootstrap's JavaScript plugins -->
<script src="frameworks/js/jquery.min.js"></script>
<!-- All Bootstrap plug-ins file -->
<script src="frameworks/js/bootstrap.min.js"></script>
<!-- Basic AngularJS-->
<script src="frameworks/js/angular.js"></script>
<!-- Angular-route-->
<script src="frameworks/js/angular-route.min.js"></script>  
    
</body>
</html>
