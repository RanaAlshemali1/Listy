<cfif IsDefined("form.userID") and isNumeric(form.userID)>
	<cfquery name="updateUser" datasource="#mySite.Account#">
		UPDATE  users
		SET  firstName = '#form.firstName#',
		lastName = '#form.lastName#',
		email = '#form.Email#',
		password = '#form.Pass#'
		where userID =<cfqueryparam cfsqltype="cf_sql_integer" value="#form.userID#">

<!--- SQL update statement here, make sure you have a where clause (where userID matches form.userID) or else ALL your records will be updated with the submitted data --->
</cfquery>
	<cfset Variables.Success="Record successfully updated">
	<cfset url.ID=form.userID>
</cfif>
<cfif IsDefined("Variables.Success")>
	<div class="alert bg-success text-success">
		<cfoutput>
			#Variables.Success#
		</cfoutput>
	</div>
</cfif>
<cfset Variables.pageTitle="Edit User Information">
<cfinclude template="../header.cfm">
<h1>
	Edit User Information
</h1>
<!--- Edit User form goes below --->
<cfif IsDefined("url.ID") and IsNumeric(url.ID)>
	<cfquery name="getUser" datasource="#mySite.Account#">
<!--- select the users table record where userID matches that of url.ID --->
	select *
	from users
	where userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ID#">
</cfquery>
</cfif>
<form action="admin/editUser.cfm" method="post" class="well form-horizontal" role="form">
	<fieldset>
		<input type="hidden" name="userID" value="<cfoutput>#getUser.userID#</cfoutput>">
		<div class="form-group">
			<label class="col-sm-2 control-label" for="firstName">
				First Name
			</label>
			<div class="col-sm-10">
				<input type="text" name="firstName" id="firstName" value="<cfoutput>#getUser.firstName#</cfoutput>"  class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="lastName">
				Last Name
			</label>
			<div class="col-sm-10">
				<input type="text" name="lastName" id="lastName" value="<cfoutput>#getUser.lastName#</cfoutput>" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="Email">
				Email
			</label>
			<div class="col-sm-10">
				<input type="text" name="Email" id="Email" value="<cfoutput>#getUser.email#</cfoutput>" class="form-control">
				<p class="help-block">
					Must be a valid email address.
				</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="Pass">
				Password
			</label>
			<div class="col-sm-10">
				<input type="text" name="Pass" id="Pass" value="<cfoutput>#getUser.password#</cfoutput>" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button name="action" type="submit" class="btn btn-primary">
					Edit Account!
				</button>
			</div>
		</div>
	</fieldset>
</form>
<cfinclude template="../footer.cfm">
