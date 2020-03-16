<cfif Not IsDefined ("session.user.userID")>
	<cflocation url="login.cfm">
</cfif>
<cfif IsDefined("form.action")>

	<cfset Variables.Errors=ArrayNew(1)>
	<cfset url.ID=form.listId>
	<cfif Not IsDefined("form.title") or (IsDefined("form.title") and form.title is "")>
		<cfset temp=ArrayAppend(Variables.Errors, "Title is a required field")>
		<cfset url.ID=form.listId>
	</cfif>
	<cfif Not ArrayLen(Variables.Errors)>
		<cfquery name="checkTitle" datasource="#mySite.Account#">
			select title
			from Lists
			where title=<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.title#">
			and userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
			and listId  !=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.listId#">
		</cfquery>
		<cfif checkTitle.RecordCount>
			<cfset temp=ArrayClear(Variables.Errors)>
			<cfset temp=ArrayAppend(Variables.Errors, "A List is already created with the same title ""#form.title#""")>
			<cfset url.ID=form.listId>
		</cfif>
		<cfif Not ArrayLen(Variables.Errors) and IsDefined("form.listId") and isNumeric(form.listId)>
			<cfquery name="updateList" datasource="#mySite.Account#">
				UPDATE  Lists
				SET  title = '#form.title#',
				description = '#form.description#'
				where listId =<cfqueryparam cfsqltype="cf_sql_integer" value="#listId#">
		 	</cfquery>

			<cfset Variables.Success="List successfully updated">
			<cfset url.ID=form.listId>
		</cfif>
	</cfif>
</cfif>
<cfset Variables.pageTitle="Edit List">
<cfinclude template="header.cfm">
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

<form action="editList.cfm" method="post" class="well form-horizontal">
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

		<div class="form-group">
			<label class="col-sm-3 control-label" >
				Upload List Photo
			</label>
			<form action="editList.cfm" method="post" enctype="multipart/form-data">
				<div class="col-sm-9"><input type="file" name="upload"> <input type="submit" value="Upload Photo">
				<cfoutput> <dd> <img src="/student/team2/photos/default.jpg" width="200"> </dd> </cfoutput>
				</div> </form>
				 </div> <div class="clearfix"></div> <br><br>
	<hr class="separator">
<div class="form-group">
<div class="col-sm-offset-3 col-sm-9">
	<button name="action" type="submit" class="btn btn-primary"  href="./editList.cfm?id=#listID#"> Update </button> </div> </div> </fieldset> </form>
<cfinclude template="footer.cfm">
