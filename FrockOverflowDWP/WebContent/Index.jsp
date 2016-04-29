<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRopZtWL58-FuZutGY-IaFC-KRMbTIediMqw5EmyEjqCg5_5twmsA">

    <title>Top Secret Research and Design</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/landing-page.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<form action="GetQuestionByID.do" method="GET">
	What question would you like to return?<input type="text" name="param" value=""><br>
	<input type="submit" name="submit" value="submit"/>
</form>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
        <div class="container topnav">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
               
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="index.jsp">Home</a>
                    </li>
                    <li>
                        <a href="http://www.timothybrunk.com">Timothy Brunk</a>
                    </li>
                    <li>
                        <a href="About.jsp">About</a>
                    </li>
                    <li>
                        <a href="MyGrade.jsp">My Grade</a>
                    </li>
                   
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>


    <!-- Header -->
    <a name="about"></a>
    <div class="intro-header">
        <div class="container">

            <div class="row">
                <div class="col-lg-12">
                    <div class="intro-message">
                        <h1>Top Secret Research and Design</h1>
                        <h3>Employee Database</h3>
                        <hr class="intro-divider">
                        <ul class="list-inline intro-social-buttons">
                            <li>
                            <form action="GetAllEmployees.do" method="POST" >
                                <input type ="submit" value="List All Employees" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i> <span class="network-name"></span>
                               </form> 
                            </li>
                            <li>
                            <form action="AddEmployee.do" method="POST" > 
                                <input type="submit" value="Add New Employee" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i> <span class="network-name"></span>
                                
                                </form>
                            </li><br><br>
                            <li>
                            <form action="GetQuestionByID.do" method="GET">
                        <input id="idtext" type="text" name="id" placeholder="Search By Id Number" required style="width: 200px; height: 40px;"/>
                                <input type="submit" value="Search By Id" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i> <span class="network-name"></span>
                                </form>
                            </li>
                            <br>
                            <br>
                            <li>
                            <form action="GetEmployeeByName.do" method="GET">
                        <input id="idtext" type="text" name="firstname" placeholder="FirstName" required style="width: 200px; height: 40px;"/>
                        <input id="idtext" type="text" name="lastname" placeholder="LastName" required style="width: 200px; height: 40px;"/>
                                <input type="submit" value="Search by Name" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i> <span class="network-name"></span>
                                </form>
                            </li>
                        
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    
</body>

</html>
