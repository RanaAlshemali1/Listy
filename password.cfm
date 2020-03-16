<cfif IsDefined("form.action")>
	<!--- Form processing code goes here --->
	<cfif IsDefined("form.oldPass")
		and IsDefined("form.newPass")
		and IsDefined("form.validPass")
		and Len(form.newPass) gte 4
		and (form.newPass is form.validPass)
		>
		<cfquery name="getUser" datasource="#mySite.Account#">
			select *
			from users
			where userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#"> and password =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldPass#">


	</cfquery>
		<cfif getUser.recordcount>
			<cfquery name="getUser" datasource="#mySite.Account#">
				UPDATE  users
				SET  password = '#form.newPass#'
				where userID =<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
</cfquery>
			<cfset Variables.Success="Password was successfully changed!">
		<cfelse>
			<cfset Variables.Error="Old Password did not match our records. Please try again!">
		</cfif>
	<cfelse>
		<cfset Variables.Error="Password change error.  Please try again!">
	</cfif>
</cfif>
<cfif IsDefined("Variables.Error")>
	<div class="alert bg-danger text-danger">
		<button type="button" class="close" data-dismiss="alert">
			x
		</button>
		<p class="text-danger">
			<cfoutput>
				#Variables.Error#
			</cfoutput>
		</p>
	</div>
<cfelseif IsDefined("Variables.Success")>
	<div class="alert bg-success text-success">
		<p class="text-success">
			<cfoutput>
				#Variables.Success#
			</cfoutput>
		</p>
	</div>
</cfif>
<cfset Variables.pageTitle="Change Password">
<cfinclude template="header.cfm">
<h1>
	Change Password
</h1>
<!--- Start Change Password Form Below --->
<form action="password.cfm" method="post" class="well form-horizontal">
	<fieldset>
		<div class="form-group">
			<label class="col-sm-3 control-label">
				Old Password
			</label>
			<div class="col-sm-9">
				<input type="password" name="oldPass" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="pass">
				New Password
			</label>
			<div class="col-sm-9">
				<input type="password" name="newPass" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="pass">
				Validate New Password
			</label>
			<div class="col-sm-9">
				<input type="password" name="validPass" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				<button name="action" type="submit" class="btn btn-primary">
					Submit
				</button>
			</div>
		</div>
	</fieldset>
</form>
<cfinclude template="footer.cfm">
