<cfif IsDefined("form.email")>
	<!--- Form processing code goes here --->
	<cfif Not isValid("email", form.email)>
		<cfset Variables.Error="You must suplly a valid email address">

	<cfif IsDefined("form.title") and IsDefined("form.name") and IsDefined("form.text")>

		<cfmail type="html" from="#form.email#" to="helpDesk@something.com" subject="#form.title#">
				 #form.text#

		</cfmail>
		<cfset Variables.Success="Thank you! Your Email was sent to HelpDesk@something.com">
</cfif>
	</cfif>
</cfif>
<cfset Variables.pageTitle="Contact Us">
<cfinclude template="header.cfm">
<h1>
	<cfoutput>
		#Variables.pageTitle#
	</cfoutput>
</h1>
<form action="contact.cfm" method="post" class="well form-horizontal">
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
	<legend>
		Send Email
	</legend>
	<fieldset>
		<div class="form-group">
			<label class="col-sm-3 control-label">
				Name
			</label>
			<div class="col-sm-9">
				<input type="text" name="name" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="email">
				Email
			</label>
			<div class="col-sm-9">
				<input type="text" name="email" class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">
				Title
			</label>
			<div class="col-sm-9">
				<input type="text" name="title"  class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label"   for="comment">
				Text
			</label>
			<div class="col-sm-9">
				<textarea  type="text" rows="5" name="text" class="form-control">
				</textarea>
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
