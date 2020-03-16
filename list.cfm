<cfquery name="getList" datasource="#mySite.Account#">
	select *
	from Lists
	where listId=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ID#">
</cfquery>
<cfquery name="getUser" datasource="#mySite.Account#">
	select *
	from users
	where userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#getList.userID#">
</cfquery>

<cfquery name="getListItems" datasource="#mySite.Account#">
	select *
	from ListItems
	where listId=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ID#">
</cfquery>


<!--- <cfquery name="insertLike" datasource="#mySite.Account#">
				insert into likes (userID,listID)
				values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getUser.userID#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getList.listID#">,
				)
</cfquery> --->


<cfif getList.recordcount>
	<cfset Variables.pageTitle=getList.title>

<cfelse>
	<cfset Variables.pageTitle="Error: List does not exist">
</cfif>

<cfinclude template="header.cfm">
<br><br>
<h1><cfoutput>#Variables.pageTitle#</cfoutput></h1>
<p><cfoutput>  Created On: #DateFormat(getList.dateCreated, "mm/dd/yyyy")#</cfoutput></p>
<cfoutput><div class="list-description">#getList.description#</cfoutput></div>
<cfoutput>
	<div class="user-wrapper">
		<a href="profile.cfm?id=#getList.userID#"><div class="profile-image" style='background-image: url("photos/#getUser.photo#")'></div>
		<span class="user-for-follow">#getUser.firstName# #getUser.lastName#</span></a>


		<!--- <cfif  IsDefined ("session.user.userID")>
			<form action="list.cfm" method="post" enctype="multipart/form-data">
				<button name="like" type="submit" class="btn btn-default" id="fSubmit"><div>Like <span class="glyphicon glyphicon-thumbs-up"></div></button>
			</form>
		</cfif> --->

<!--- When liked, like button should have class "btn btn-success" --->

	</div>
<br><br>
<center>
	<cfif getList.photo is "">
		<cfelse><img src="photos/listphotos/#getList.photo#"></center></cfif></cfoutput><br><br><br>
<cfset i=0>
	<table class="table table-hover">
	<tbody>
		<cfoutput query="getListItems">
			<tr>

				<td>

					<h4>
					<cfset i=i+1> #i#. #getListItems.ItemTitle#
					</h4>
					<p>
					#getListItems.Description#

					</p>

				</td>
				<cfif  IsDefined ("session.user.userID")>
				<td>
					<cfif  session.user.userID EQ getUser.userID >
					<!--- Create link buttons to view and edit the list. Pass the ID associated with each record in the URL of the link --->
					<a class="btn btn-default btn-sm" href="./editItem.cfm?id=#listID#&idi=#getListItems.ItemID#&ListTitle=#getList.title#">
						<span class="glyphicon glyphicon-pencil">
						</span>
					</a>

					<a class="btn btn-default btn-sm" href="./deleteItem.cfm?id=#listID#&idi=#getListItems.ItemID#&ListTitle=#getList.title#">
						<span class="glyphicon glyphicon-trash">
						</span>
					</a>

					</cfif>



				</td>
				</cfif>

			</tr>
		</cfoutput>
	</tbody>
</table>
<cfif  IsDefined ("session.user.userID")>
<cfif getList.userID is session.user.userID>
<p>
	<a class="btn btn-primary" href="addItem.cfm?id=<cfoutput>#getList.listId#</cfoutput>">
		Add List Item
	</a>
</p>
</cfif>
</cfif>
<cfinclude template="footer.cfm">