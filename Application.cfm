<!--- We use the CGI scope to read your student account name based on the second directory
of the current path /student/your_username/some_directory/somefile --->
<cfset mySite.Account="#ListGetAt(cgi.script_name,2,'/')#">
<!--- The cfapplication tag defines the scope of the ColdFusion application.
For our application we enable Session variables and give it a life span of 30 minutes.
utilizing the CreateTimeSpan(days, hours, minutes, seconds) function --->
<cfapplication name="#mySite.Account#" sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
<cfset mySite.Path="#Left(cgi.script_name,FindNoCase("/#mySite.Account#/",cgi.script_name))##mySite.Account#/">
<cfset mySite.Name="Listy">
<cfset mySite.Author="ITEC 334 - Team 2">
