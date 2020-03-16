<cfif Not IsDefined ("session.user.userID")>
	<cflocation url="login.cfm">
</cfif>
<script src="//cdn.ckeditor.com/4.5.5/standard/ckeditor.js"></script>
<cfif IsDefined("form.action")>
			<cfset url.id=form.listID>
			<cfset url.idi=form.itemID>
			<cfset url.ListTitle= form.listTitle>

	<cfset Variables.Errors=ArrayNew(1)>

	<cfif Not IsDefined("form.itemTitle1") or (IsDefined("form.itemTitle1") and form.itemTitle1 is "")>
		<cfset temp=ArrayAppend(Variables.Errors, "Item title is a required field")>

	</cfif>
	<cfif Not ArrayLen(Variables.Errors)>
		<cfquery name="checkTitle" datasource="#mySite.Account#">
			select ItemTitle
			from ListItems
			where ItemTitle=<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.itemTitle1#">
			and listID =<cfqueryparam cfsqltype="cf_sql_integer" value="#listId#">
			and ItemID !=<cfqueryparam cfsqltype="cf_sql_integer" value="#itemID#">

		</cfquery>

		<cfif checkTitle.RecordCount >
			<cfset temp=ArrayClear(Variables.Errors)>
			<cfset temp=ArrayAppend(Variables.Errors, "A List Item in your list is already created with the same title ""#form.itemTitle1#""")>
			<cfset url.ID=form.listId>

		</cfif>
		<cfif Not ArrayLen(Variables.Errors) and IsDefined("listID") and isNumeric(listID)>
			<cfquery name="updateList" datasource="#mySite.Account#">
				UPDATE  ListItems
				SET  ItemTitle = '#form.itemTitle1#',
				description = '#form.itemDescription#'
				where listId =<cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
				and ItemID  =<cfqueryparam cfsqltype="cf_sql_integer" value="#url.idi#">
		 	</cfquery>

			<cfset Variables.Success="List Item successfully updated">
			<cfset url.ID=form.listId>
			<cflocation url="list.cfm?id=#listId#">
		</cfif>
	</cfif>
</cfif>

<br>
<cfset Variables.pageTitle="Edit ""#url.ListTitle#'s"" Item">
<cfinclude template="header.cfm">
<h1>
	<cfoutput>
		#Variables.pageTitle#
	</cfoutput>
</h1>
<cfif IsDefined("url.ID") and isNumeric(url.ID)>
	<cfquery name="list" datasource="#mySite.Account#">
			select *
			from ListItems
			where ItemID=<cfqueryparam cfsqltype="cf_sql_int" value="#url.idi#">
			and listId =<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ID#">
		</cfquery>
		<cfset listTitle=url.ListTitle>

</cfif>
<br>
<cfinclude template="header.cfm">
<form action="editItem.cfm" method="post" enctype="multipart/form-data" class="well form-horizontal">
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
		<input type="hidden" name="itemID" value="<cfoutput>#list.ItemID#</cfoutput>">
		<input type="hidden" name="listTitle" value="<cfoutput>#listTitle#</cfoutput>">
		<div class="form-group">
			<label class="col-sm-3 control-label">
				Item Title:

			</label>
			<div class="col-sm-9">
				<input type="text" name="itemTitle1" id="ITid" maxlength="100" value="<cfif IsDefined("list.ItemTitle")><cfoutput>#list.ItemTitle#</cfoutput></cfif>"class="form-control">
				<p class="help-block">
					You must enter an item.
				</p>
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label">
				Item Description:
			</label>

			<div class="col-sm-9">
				 <textarea class="form-control" rows="2" type="text" name="itemDescription" id="itemDescription"><cfif IsDefined("list.Description")><cfoutput>#list.Description#</cfoutput></cfif></textarea>
				 <script>CKEDITOR.replace('itemDescription');</script>
			</div>
		</div>

				<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				<button name="action" type="submit" class="btn btn-primary" id="fSubmit" > Update List Item! </button>
			</div>
		</div>
	</fieldset>
</form>
<cfinclude template="footer.cfm">