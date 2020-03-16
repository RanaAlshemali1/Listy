
<script src="//cdn.ckeditor.com/4.5.5/standard/ckeditor.js"></script>

<cfif IsDefined("form.action")>

	<cfset Variables.Errors=ArrayNew(1)>
	<cfset url.ID=form.listId>
	<cfif Not IsDefined("form.itemTitle1") or (IsDefined("form.itemTitle1") and form.itemTitle1 is "")>
		<cfset temp=ArrayAppend(Variables.Errors, "Item Title is a required field")>
				<cfset url.ID=form.listId>
	</cfif>
		<cfif Not ArrayLen(Variables.Errors)>
		<cfquery name="checkTitle" datasource="#mySite.Account#">
			select ItemTitle
			from ListItems
			where ItemTitle=<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.itemTitle1#">
			and listID =<cfqueryparam cfsqltype="cf_sql_integer" value="#listId#">

		</cfquery>

		<cfif checkTitle.RecordCount >
			<cfset temp=ArrayClear(Variables.Errors)>
			<cfset temp=ArrayAppend(Variables.Errors, "A List Item in your list is already created with the same title ""#form.itemTitle1#""")>
			<cfset url.ID=form.listId>

		</cfif>
	<cfif Not ArrayLen(Variables.Errors)>

		<cfif Not ArrayLen(Variables.Errors)>
			<cfquery name="creatItem" datasource="#mySite.Account#">
				insert into ListItems (listID, ItemTitle,description)
				values(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#form.listID#">,
					<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.itemTitle1#">,
					<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.itemDescription#">
				)
			</cfquery>

			<cfif isDefined("form.upload")>
				<!--- Upload the photo --->
				<cffile action="upload" filefield="upload" accept="image/jpg,image/jpeg,image/gif,image/png" destination="C:\inetpub\wwwroot\student\#mySite.Account#\photos\listphotos" nameconflict="makeunique">
				<!--- Read the uploaded photo --->
				<cfimage source="C:\inetpub\wwwroot\student\#mySite.Account#\photos\listphotos\#cffile.ServerFile#" name="myImage">
				<!--- Turn on antialiasing to improve image quality. --->
				<cfset ImageSetAntialiasing(myImage,"on")>
				<!--- Resize photo--->
				<cfset ImageScaleToFit(myImage,600,600)>
				<!--- Write updated photo --->
				<cfimage source="#myImage#" action="write" overwrite="true" destination="C:\inetpub\wwwroot\student\#mySite.Account#\photos\listphotos\#cffile.ServerFile#">
				<!--- Delete original file --->
				<!--- <cffile action="delete" file="C:\inetpub\wwwroot\student\#mySite.Account#\photos\#cffile.ServerFile#"> --->
				<!--- <cfquery name="getUser" datasource="#mySite.Account#">
					update users
					set photo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.user.userID#.jpg">
					where userID=<cfqueryparam cfsqltype="cf_sql_int" value="#session.user.userID#">
				</cfquery>
				<cflocation url="user.cfm"> --->
				<cfquery name="setPhoto" datasource="#mySite.Account#">
					update lists
					set photo=<cfqueryparam cfsqltype="cf_sql_nchar" value="#cffile.ServerFile#">
					where listID=<cfqueryparam cfsqltype="cf_sql_nchar" value="#list.listID#">
				</cfquery>
			</cfif>
			<cfset Variables.Success="Your Item is Added successfully!">
	<cfset url.ID=form.listId>
			<cflocation url="list.cfm?id=#form.listId#">
		</cfif>
	</cfif>
		</cfif>
</cfif>
<cfif IsDefined("url.ID") and isNumeric(url.ID)>
	<cfquery name="list" datasource="#mySite.Account#">
			select *
			from Lists
			where listId=<cfqueryparam cfsqltype="cf_sql_int" value="#url.ID#">
		</cfquery>

</cfif>
<cfinclude template="header.cfm">
<div id="newItem" >
<br><br><br>
<form action="addItem.cfm" method="post" enctype="multipart/form-data" class="well form-horizontal">
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
				Item Title:

			</label>
			<div class="col-sm-9">
				<input type="text" name="itemTitle1" id="ITid" maxlength="100" value="<cfif IsDefined("form.itemTitle1")><cfoutput>#form.itemTitle1#</cfoutput></cfif>"class="form-control">
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
				 <textarea class="form-control" rows="2" type="text" name="itemDescription" id="itemDescription"><cfif IsDefined("form.itemDescription1")><cfoutput>#form.itemDescription#</cfoutput></cfif></textarea>
				 <script>CKEDITOR.replace('itemDescription');</script>
			</div>
		</div>

				<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				<button name="action" type="submit" class="btn btn-primary" id="fSubmit"> Add New List Item! </button>
			</div>
		</div>
	</fieldset>
</form>
<cfinclude template="footer.cfm">
