<cfif Not IsDefined ("session.user.userID")>
	<cflocation url="login.cfm">
</cfif>

<cfif isDefined("form.upload")>
	<!--- Upload the photo --->
	<cffile action="upload" filefield="upload" accept="image/jpg,image/jpeg" destination="C:\inetpub\wwwroot\student\#mySite.Account#\photos" nameconflict="makeunique">
	<!--- Read the uploaded photo --->
	<cfimage source="C:\inetpub\wwwroot\student\#mySite.Account#\photos\#cffile.ServerFile#" name="myImage">
	<!--- Turn on antialiasing to improve image quality. --->
	<cfset ImageSetAntialiasing(myImage,"on")>
	<!--- Resize photo--->
	<cfset ImageScaleToFit(myImage,150,150)>
	<!--- Write updated photo --->
	<cfimage source="#myImage#" action="write" overwrite="true" destination="C:\inetpub\wwwroot\student\#mySite.Account#\photos\#session.user.userID#.jpg">
<!--- Delete original file --->
	<cffile action="delete" file="C:\inetpub\wwwroot\student\#mySite.Account#\photos\#cffile.ServerFile#">
<cfquery name="getUser" datasource="#mySite.Account#">
		update users
		set photo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.user.userID#.jpg">
		where userID=<cfqueryparam cfsqltype="cf_sql_int" value="#session.user.userID#">
	</cfquery>
	<cflocation url="user.cfm">
</cfif>

<cfset Variables.pageTitle="Upload Photo">
<cfinclude template="header.cfm">
<h1>Upload Photo</h1>
<!--- Start Upload Photo Page Below --->
<form action="photoUpload.cfm" method="post" enctype="multipart/form-data">
<input type="file" name="upload">
<input type="submit" value="Upload Photo">
</form>

<cfinclude template="footer.cfm">
