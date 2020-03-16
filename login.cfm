<cfif IsDefined("form.email") and IsDefined("form.pass")>
	<cfquery name="getUser" datasource="#mySite.Account#">
		select *
		from users
		where email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(form.email)#">
		and password=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pass#">
	</cfquery>
	<cfif getUser.recordcount>
		<cfquery name="getUser" datasource="#mySite.Account#">
			insert into userLogins (userID,ipAddress,lat,lon)
			values(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getUser.userID#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.REMOTE_ADDR#">,
				<cfqueryparam cfsqltype="cf_sql_float" value="#form.lat#">,
				<cfqueryparam cfsqltype="cf_sql_float" value="#form.lon#">

			)
		</cfquery>
		<cfset session.user=getUser>
	</cfif>
</cfif>
<cfif IsDefined("session.newUser")>
	<cfquery name="getUser" datasource="#mySite.Account#">
		select *
		from users
		where email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.newUser#">
	</cfquery>
	<cfif getUser.recordcount>
		<cfset StructClear(session)>
		<cfset session.user=getUser>
	</cfif>
</cfif>
<cfif IsDefined("getUser.recordcount") and getUser.recordcount>
	<cflocation url="./explore.cfm">
</cfif>
<cfset Variables.pageTitle="Login">
<cfinclude template="header.cfm">
<h1>
	Sign in
</h1>
<!--- Start Login Form Below --->

<form action="login.cfm" method="post" class="well form-horizontal">


	<cfif IsDefined("form.email")>
		<div class="alert bg-danger text-danger">
			<button type="button" class="close" data-dismiss="alert">
				x
			</button>
			<p class="text-danger">
				<cfif isValid("email", form.email)>
					Wrong Email and Password combination.
				<cfelse>
					Invalid email address.
				</cfif>
			</p>
		</div>
	</cfif>
	<fieldset>
			<input type="hidden" name="lat" value="">
<input type="hidden" name="lon" value="">
		<div class="form-group">
			<label class="col-sm-2 control-label" for="Email">
				Email
			</label>
			<div class="col-sm-10">
				<input type="text" name="Email" value="<cfif IsDefined("form.email")><cfoutput>#form.email#</cfoutput></cfif>" id="Email" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="pass">
				Password
			</label>
			<div class="col-sm-10">
				<input type="password" name="pass" id="pass" class="form-control">
				<span class="help-inline">
					<a href="forgot.cfm">
						Forgot password?
					</a>
				</span>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button name="action" type="submit" class="btn btn-primary">
					Sign in
				</button>
			</div>
		</div>
	</fieldset>
</form>
<cfinclude template="footer.cfm">