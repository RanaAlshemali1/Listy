<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<cfoutput>#mySite.Path#</cfoutput>">
		<title>
			<cfoutput>
				<cfif IsDefined("Variables.PageTitle")>
					#Variables.PageTitle# |
				</cfif>
				#mySite.Name#
			</cfoutput>
		</title>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="icon" href="img/favicon.ico">
		<title>
			ITEC 334 Final Project HTML5 Boilerplate
		</title>
		<!-- Bootstrap core CSS -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<!-- Custom styles for this template -->
		<link href="css/custom.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
			<![endif]-->
	</head>
	<body>
		<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">
							Toggle navigation
						</span>
						<span class="icon-bar">
						</span>
						<span class="icon-bar">
						</span>
						<span class="icon-bar">
						</span>

					</button>
					<a class="navbar-brand" href="#home"><img src="img/logo.png" width="55px"></a>

				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li><a href="explore.cfm">Explore Lists</a></li>
						<cfif isDefined("session.user.userID")>
							<li><a href="userLists.cfm">My Lists</a></li>
							<li><a href="#">My Followers</a></li>
							<li><a href="createList.cfm">Create List</a></li>
						</cfif>
							<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								More
								<span class="caret">
								</span>
							</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="guide.cfm">Guide</a></li>
								<li><a href="about.cfm">About</a></li>
								<li><a href="contact.cfm">Contact</a></li>
							</ul>
						</li>
					</ul>
					<cfif IsDefined("session.user")>
						<ul class="nav navbar-nav pull-right">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<cfoutput>
										Hello #session.user.firstName#!
									</cfoutput>
									<span class="caret">
									</span>
								</a>
								<ul class="dropdown-menu" role="menu">
									<li>
										<a href="user.cfm">
											Profile
										</a>
									</li>
									<li>
										<a href="password.cfm">
											Change Password
										</a>
									</li>
									<li class="divider">
									</li>
									<cfif  session.user.admin EQ  1>
										<li>
											<a href="./admin">
												Administrator
											</a>
										</li>
									</cfif>
									<li>
										<a href="logout.cfm">
											Logout
										</a>
									</li>
								</ul>
							</li>
						</ul>
					<cfelse>
						<form action="login.cfm" method="post" class="navbar-form navbar-right" role="form">
							<input type="hidden" name="lat" value="">
							<input type="hidden" name="lon" value="">
							<div class="form-group">
								<input type="text" name="email" placeholder="Email" class="form-control">
							</div>
							<div class="form-group">
								<input type="password" name="pass" placeholder="Password" class="form-control">
							</div>
							<button type="submit" class="btn btn-success">
								Sign in
							</button>
						</form>
					</cfif>
					 <div class="col-sm-3 col-md-3 pull-right">
            <form class="navbar-form" role="search">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" name="q">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </form>
        </div>
				</div>
				<!--/.navbar-collapse -->

			</div>

		</div>
		<cfif IsDefined("Variables.jumbotron")>
			<!-- Main jumbotron for a primary marketing message or call to action -->
			<div class="jumbotron">
				<div class="container">
					<cfoutput>
						#Variables.jumbotron#
					</cfoutput>
				</div>
			</div>
		</cfif>
		<div class="container">
		<!-- START Page Body -->
