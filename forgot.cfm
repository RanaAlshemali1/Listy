<cfif IsDefined("form.email")>
	<!--- Form processing code goes here --->
	<cfif Not isValid("email", form.email)>
		<cfset Variables.Error="You must suplly a valid email address">
	<cfelse>
		<cfquery name="getUser" datasource="#mySite.Account#">
		select *
		from users
		where email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(form.email)#">
</cfquery>
		<cfif getUser.recordcount>
			<cfmail type="html" from="helpdesk@mydomain.com" to="#getUser.email#" subject="Your #mySite.Name# Password">
				Dear #getUser.firstName#,
				<p>Here's your password:<strong> #getUser.password#</strong></p>

</cfmail>
			<cfset Variables.Success="The password was sent to #getUser.Email#">
		<cfelse>
			<cfset Variables.Error="The supplied email address does not match our records">
		</cfif>
	</cfif>
</cfif>
<cfset Variables.pageTitle="Forgot your password?">
<cfinclude template="header.cfm">
<h1>
	Forgot your password?
</h1>
<!--- Start Forgot Password Form Below --->
<form action="forgot.cfm" method="post" class="well">
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
	<fieldset>
		<div class="form-group">
			<label for="email">
				Enter your email address
			</label>
			<input type="text" name="email" id="email" class="form-control" placeholder="Your email...">
		</div>
		<button type="submit" class="btn btn-primary">
			Submit
		</button>
	</fieldset>
</form>
<cfinclude template="footer.cfm">
