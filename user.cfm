<cfif Not IsDefined ("session.user.userID")>
	<cflocation url="login.cfm">
</cfif>
<cfset Variables.pageTitle="MyAccount">
<cfinclude template="header.cfm">
<h1>
	My Account
</h1>
<!--- Start My Account Page Below --->
<cfquery name="getUser" datasource="#mySite.Account#">
	select *
	from users
	where userID=<cfqueryparam cfsqltype="cf_sql_int" value="#session.user.userID#">
</cfquery>
<cfoutput>
	<dl class="dl-horizontal">
		<dt>
			Photo
		</dt>
		<dd><a href="photoUpload.cfm">
		<cfif getUser.photo is "">
				<img src="/photos/default.jpg">
		<cfelse>
			<img src="photos/#getUser.photo#">
		</cfif>
		</a></dd>

		<dt>
			First Name
		</dt>
		<dd>
			#getUser.firstName#
		</dd>
		<dt>
			Last Name
		</dt>
		<dd>
			#getUser.lastName#
		</dd>
		<dt>
			Email
		</dt>
		<dd>
			#getUser.Email#
		</dd>
	</dl>
</cfoutput>

<cfinclude template="footer.cfm">
