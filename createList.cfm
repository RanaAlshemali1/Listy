<cfif Not IsDefined ("session.user.userID")>
	<cflocation url="login.cfm">
</cfif>
	<!--- <script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script> --->
<cfsavecontent variable="Variables.pageScript">
<script src="//cdn.ckeditor.com/4.5.5/standard/ckeditor.js"></script>
<!---<script>
	var i=1;
	var initVal = "Title is required";
	$(document)
				.ready(
						function() {
								CKEDITOR.replace('itemDescription1');
								$("#addItem").click(function(e)  {

										    i=i+1;
										    var titleForm = $("<div/>").addClass("form-group");
										    var titleLabel = $("<label/>").addClass("col-sm-3 control-label").text(i+". Item Title:");
											var titleForm2 = $("<div/>").addClass("col-sm-9");
											var titleInput = $("<input/>").attr("type", "text").attr("maxlength",100).attr("name","itemTitle"+i).addClass("form-control").val("<cfif IsDefined("form.itemTitle2")><cfoutput>#form.itemTitle2#</cfoutput></cfif>");
										    $(titleForm2).append(titleInput);
										    $(titleForm).append(titleLabel).append(titleForm2);
										    titleForm.appendTo( "#newItem" );

										    var descForm = $("<div/>").addClass("form-group");
										    var descLabel = $("<label/>").addClass("col-sm-3 control-label").text("Item Description:");
											var descForm2 = $("<div/>").addClass("col-sm-9");
										    var descInput = $("<textarea/>").attr("type", "text").attr("maxlength",200).attr({"name": "itemDescription"+i,"id": "itemDescription"+i }).addClass("form-control").attr("rows", 2);
										    $(descForm2).append(descInput);
										    $(descForm).append(descLabel).append(descForm2);
										    descForm.appendTo( "#newItem" );
											var sep=$("<hr/>").addClass("separator");
											sep.appendTo( "#newItem" );
											CKEDITOR.replace('itemDescription'+i);
								});

									 $("#fSubmit").attr("disabled", "true");
									    $("#LTid").blur(function(){
									        if ($(this).val() != initVal && $(this).val() != "") {
									            $("#fSubmit").removeAttr("disabled");
									        } else {
									            $("#fSubmit").attr("disabled", "true");
									        }
									    });
									    $("#fSubmit").attr("disabled", "true");
									    $("#ITid").blur(function(){
									        if ($(this).val() != initVal && $(this).val() != "") {
									            $("#fSubmit").removeAttr("disabled");
									        } else {
									            $("#fSubmit").attr("disabled", "true");
									        }
									    });

	});

								</script>--->
</cfsavecontent>
<cfif IsDefined("form.action")>

	<cfset Variables.Errors=ArrayNew(1)>
	<cfif Not IsDefined("form.title") or (IsDefined("form.title") and form.title is "")>
		<cfset temp=ArrayAppend(Variables.Errors, "List Title is a required field")>
	</cfif>
	<cfif Not ArrayLen(Variables.Errors)>
		<cfquery name="checkTitle" datasource="#mySite.Account#">
			select title
			from Lists
			where title=<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.title#">
			and userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
		</cfquery>
		<cfif checkTitle.RecordCount>
			<cfset temp=ArrayClear(Variables.Errors)>
			<cfset temp=ArrayAppend(Variables.Errors, "A List is already created with the same title ""#form.title#""")>
		</cfif>
		<cfif Not ArrayLen(Variables.Errors)>
			<cfquery name="createList" datasource="#mySite.Account#">
				insert into Lists (userID,title,description,catId)
				values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">,
					<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.title#">,
					<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.description#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#form.category#">
				)
			</cfquery>
			<cfquery name="getList" datasource="#mySite.Account#">
				select listId
				from Lists
				where title=<cfqueryparam cfsqltype="cf_sql_nchar" value="#form.title#">
				and userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
			</cfquery>
			<cfif  Len("#form.upload#")GTE 5 >
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
					where listID=<cfqueryparam cfsqltype="cf_sql_nchar" value="#getList.listID#">
				</cfquery>
			</cfif>
			<cfset Variables.Success="Your List is created successfully!">
			<cfoutput>
			 <cflocation url="list.cfm?id=#getList.listID#">
			 </cfoutput>
		</cfif>
	</cfif>
</cfif>

<cfset Variables.pageTitle="Create New List">

<cfinclude template="header.cfm">
<h1>
	<cfoutput>
		#Variables.pageTitle#
	</cfoutput>
</h1>
<form action="createList.cfm" method="post" enctype="multipart/form-data" class="well form-horizontal">
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
		<div class="form-group">
			<label class="col-sm-3 control-label">
				List Title
			</label>
			<div class="col-sm-9">
				<input type="text" name="title" id="LTid" maxlength="100" value="<cfif IsDefined("form.title")><cfoutput>#form.title#</cfoutput></cfif>"class="form-control">
				<p class="help-block">
					Title is required.
				</p>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label">
				List Description
			</label>

			<div class="col-sm-9">
				 <textarea class="form-control" rows="3" type="text" name="description" maxlength="200"><cfif IsDefined("form.description")><cfoutput>#form.description#</cfoutput></cfif></textarea>
					<p class="help-block">
					Description is optional.
				</p>
			</div>
		</div>
<cfquery name="getCategories" datasource="#MySite.Account#">
                select * from categories order by description
        </cfquery>
<div class="form-group">
        <label class="col-sm-3 control-label" >Category:</label>
                <div class="col-sm-3">
<select class="form-control" name="category" value="">
        <option value="">Pick a category</option>
           <cfoutput query="getCategories">
                <option value="#catID#">#description#</option>
        </cfoutput>
</select></div></div>

		<div class="form-group">
			<label class="col-sm-3 control-label" >
				Upload List Photo
			</label>
<!---<form action="createList.cfm" method="post" enctype="multipart/form-data">--->
	<div class="col-sm-9">
		<input type="file" name="upload"><cfoutput><dd><img src="<cfif IsDefined("cffile.ServerFile")>photos/listphotos/<cfoutput>#cffile.ServerFile#</cfoutput><cfelse>/student/team2/photos/default.jpg</cfif>"width="130"></dd></cfoutput></div>

</form>
</div>
			<div class="clearfix"></div>
	<input type="hidden" name="uploadedPhoto" value="<cfif IsDefined("cffile.ServerFile")>photos/listphotos/<cfoutput>#cffile.ServerFile#</cfoutput></cfif>">
<hr class="separator">
<!--- <div id="newItem" >
<div id="insertItem">
<div class="form-group">
			<label class="col-sm-3 control-label">
				1. Item Title:

			</label>
			<div class="col-sm-9">
				<input type="text" name="itemTitle1" id="ITid" maxlength="100" value="<cfif IsDefined("form.itemTitle1")><cfoutput>#form.itemTitle1#</cfoutput></cfif>"class="form-control">
				<p class="help-block">
					You must enter at least one item.
				</p>
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label">
				Item Description:
			</label>

			<div class="col-sm-9">
				 <textarea class="form-control" rows="2" type="text" name="itemDescription1" id="itemDescription1" maxlength="200"><cfif IsDefined("form.itemDescription1")><cfoutput>#form.itemDescription1#</cfoutput></cfif></textarea>
			</div>
		</div>
<hr class="separator">		</div>
</div>

		<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				<button name="idItem" type="button" class="btn btn-primary" id="addItem" > Add New List Item </button>
			</div>
		</div> --->
				<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9">
				<button name="action" type="submit" class="btn btn-primary" id="fSubmit"> Submit </button>
			</div>
		</div>
	</fieldset>
</form>
<cfinclude template="footer.cfm">
