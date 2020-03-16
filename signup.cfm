<cfif   IsDefined ("session.user.userID")>
	<cflocation url="userLists.cfm?id=#session.user.userID#">
</cfif>
<!--- User submitted the form? --->
<cfif IsDefined("form.action")>
	<cfset Variables.Errors=ArrayNew(1)>
	<cfif Not IsDefined("form.firstName") or (IsDefined("form.firstName") and form.firstName is "")>
		<cfset temp=ArrayAppend(Variables.Errors, "First Name is a required field")>
	</cfif>
	<cfif Not IsDefined("form.lastName") or (IsDefined("form.lastName") and form.lastName is "")>
		<cfset temp=ArrayAppend(Variables.Errors, "Last Name is a required field")>
	</cfif>
	<cfif Not IsDefined("form.EMail") or (IsDefined("form.Email") and Not isValid("email", form.email))>
		<cfset temp=ArrayAppend(Variables.Errors, "You must supply a valid email address")>
	</cfif>
	<cfif IsDefined("form.Pass") and form.Pass is not "" and IsDefined("form.validPass")>
		<cfif form.Pass is not form.validPass>
			<cfset temp=ArrayAppend(Variables.Errors, "Password validation failed")>
		</cfif>
	<cfelse>
		<cfset temp=ArrayAppend(Variables.Errors, "Password validation failed")>
	</cfif>
	<!--- If there are no validation input errors? --->
	<cfif Not ArrayLen(Variables.Errors)>
		<cfquery name="checkEmail" datasource="#mySite.Account#">
			select email
			from users
			where email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(form.email)#">
		</cfquery>
		<cfif checkEmail.recordcount>
			<cfset temp=ArrayClear(Variables.Errors)>
			<cfset temp=ArrayAppend(Variables.Errors, "An account is already associated with email #form.email#")>
		</cfif>
		<!--- Again, if there are no validation input errors? --->
		<cfif Not ArrayLen(Variables.Errors)>
			<cfquery name="insertUser" datasource="#mySite.Account#">
				insert into users (firstName,lastName,email,password)
				values(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstName#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastName#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(form.email)#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pass#">
				)
			</cfquery>
			<cfset session.newUser=LCase(form.email)>
			<cflocation url="login.cfm">
		</cfif>
	</cfif>
</cfif>
<cfset Variables.pageTitle="Create an Account">
<cfinclude template="header.cfm">
<h1>
	<cfoutput>
		#Variables.pageTitle#
	</cfoutput>
</h1>
<form action="signup.cfm" method="post" class="well form-horizontal" role="form">
	<fieldset>
		<legend>
			Sign up form
		</legend>
		<cfif IsDefined("Variables.Errors") and ArrayLen(Variables.Errors)>
			<div class="alert bg-danger text-danger">
				<button type="button" class="close" data-dismiss="alert">
					x
				</button>
				<p class="text-error">
					Form Submission Error!
				</p>
				<ul>
					<cfloop index="thisError" array="#Variables.Errors#">
						<li>
							<cfoutput>
								#thisError#
							</cfoutput>
						</li>
					</cfloop>
				</ul>
			</div>
		</cfif>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="firstName">
				First Name
			</label>
			<div class="col-sm-10">
				<input type="text" name="firstName" value="<cfif IsDefined("form.firstName")>
				<cfoutput>
					#form.firstName#
				</cfoutput>
				</cfif>" id="firstName" class="form-control" placeholder="First Name">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="lastName">
				Last Name
			</label>
			<div class="col-sm-10">
				<input type="text" name="lastName" value="<cfif IsDefined("getUser.recordcount")>
				<cfoutput>
					#form.lastName#
				</cfoutput>
				</cfif>" id="lastName" class="form-control" placeholder="Last Name">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="Email">
				Email
			</label>
			<div class="col-sm-10">
				<input type="text" name="Email" value="<cfif IsDefined("form.Email")>
				<cfoutput>
					#form.Email#
				</cfoutput>
				</cfif>" id="Email" class="form-control" placeholder="Email">
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
				<input type="password" name="Pass" id="Pass" class="form-control" placeholder="Password">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="validPass">
				Validate Password
			</label>
			<div class="col-sm-10">
				<input type="password" name="validPass" id="validPassword" class="form-control" placeholder="Password">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button name="action" type="submit" class="btn btn-primary">
					Create Account!
				</button>
			</div>
		</div>
	</fieldset>
</form>
<cfinclude template="footer.cfm">
