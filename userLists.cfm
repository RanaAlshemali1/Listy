<cfset Variables.pageTitle="Your Lists">
<cfif Not IsDefined ("session.user.userID")>
	<cflocation url="login.cfm">
</cfif>
<cfquery name="getUserLists" datasource="#mySite.Account#">
	select *
	from Lists
	where userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
	order by listID Desc
</cfquery>
<cfinclude template="header.cfm">
<br>
<center><h1><cfoutput>#session.user.firstName#</cfoutput>'s Lists</h1></center>
<br>
<table class="table table-hover">
	<tbody>
		<cfoutput query="getUserLists">
			<tr>
				<td>
					<!--- Add list thumbnail to list of lists--->
							<cfif getUserLists.photo is "">
								<img src="/student/team2/photos/default.jpg" width="120">
							<cfelse>
								<img src="photos/listphotos/#getUserLists.photo#" width="120">
							</cfif>
				</td>
				<td>
					<h3>
					<a href="list.cfm?id=#listID#">#title#</a>
					</h3>
					<p>
					#description#
					</p>
					<h6>
					 Created On: #DateFormat(getUserLists.dateCreated, "mm/dd/yyyy")#
					</h6>
				</td>
				<td>
					<br>
					<!--- Create link buttons to view and edit the list. Pass the ID associated with each record in the URL of the link --->
					<a class="btn btn-default btn-sm" href="./editList.cfm?id=#listID#">
						<span class="glyphicon glyphicon-pencil">

						</span>
					</a>
					<a class="btn btn-default btn-sm" href="./deleteList.cfm?id=#listID#">
						<span class="glyphicon glyphicon-trash">
						</span>
					</a>
				</td>
			</tr>
		</cfoutput>
	</tbody>
</table>
<p>
	<a class="btn btn-primary" href="createList.cfm?new">
		Create New List
	</a>
</p>





<cfinclude template="footer.cfm">