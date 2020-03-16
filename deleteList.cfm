<cfif Not IsDefined ("session.user.userID")>
	<cflocation url="login.cfm">
</cfif>
<cfset Variables.pageTitle="Delete List">
<cfinclude template="header.cfm">
<cfif IsDefined("form.action")>

		<cfif IsDefined("form.listId") and isNumeric(form.listId)>

			<cfquery name="UserLists" datasource="#mySite.Account#">
							DELETE from Lists
							where userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
							and title=<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.title#">
							and listId=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.listId#">

						</cfquery>

			<cfset Variables.Success="List successfully deleted">
			<cflocation url="userLists.cfm">
			<cfset url.ID=form.listId>
		</cfif>

</cfif>
 <h1>
	<cfoutput>
		#Variables.pageTitle#
	</cfoutput>
</h1>
<cfif IsDefined("url.ID") and isNumeric(url.ID)>
	<cfquery name="list" datasource="#mySite.Account#">
			select *
			from Lists
			where listId=<cfqueryparam cfsqltype="cf_sql_int" value="#url.ID#">
		</cfquery>
</cfif>

<form action="deleteList.cfm" method="post" class="well form-horizontal">
	<cfif IsDefined("Variables.Errors") and ArrayLen(Variables.Errors)>
		<div class="alert bg-danger text-danger">
			<button type="button" class="close" data-dismiss="alert">
				x
			</button>
			<p class="text-error">
				List Submission Error!
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
		<input type="hidden" name="listId" value="<cfoutput>#list.listId#</cfoutput>">
		<div class="form-group">
			<label class="col-sm-3 control-label">
				List Title
			</label>
			<div class="col-sm-9">
				<input type="text" name="title"  maxlength="100" value="<cfif IsDefined("list.title")><cfoutput>#list.title#</cfoutput></cfif>"class="form-control">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">
				List Description
			</label>
			<div class="col-sm-9">
				<textarea class="form-control"  maxlength="200" rows="5" type="text" name="description" ><cfif IsDefined("list.description")><cfoutput>#list.description#</cfoutput></cfif></textarea>
			</div>
		</div>
		<hr class="separator">
		<div class="form-group">
			<label class="col-sm-3 control-label" >
				Upload List Photo
			</label>
<form action="deleteList.cfm" method="post" enctype="multipart/form-data"> <div class="col-sm-9"><input type="file" name="upload"> <input type="submit" value="Upload Photo"> <cfoutput> <dd> <img src="/student/team2/photos/default.jpg" width="200"> </dd> </cfoutput> </div> </form> </div> <div class="clearfix"></div> <br><br> <div class="form-group"> <div class="col-sm-offset-3 col-sm-9"> <button name="action" type="submit" class="btn btn-primary"  href="./editList.cfm?id=#listID#"> Delete</button> </div> </div> </fieldset> </form>
<cfinclude template="footer.cfm">
