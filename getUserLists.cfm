<cfquery name="getUserLists" datasource="#mySite.Account#">
	select *
	from Lists
	where userID=<cfqueryparam cfsqltype="cf_sql_int" value="#URL.id#">
	order by listID Desc
</cfquery>
<div class="table-responsive col-md-9">
<table class="table table-hover">
	<tbody>
		<cfoutput query="getUserLists">

			<tr>

				<td>
					<!--- Add list thumbnail to list of lists--->

							<cfif getUserLists.photo is "">
								<img src="/student/team2/photos/default.jpg" width="130">

							<cfelse>
								<img src="photos/listphotos/#getUserLists.photo#"  width="130">
							</cfif>
				</td>
				<td>

					<h4>
					<a href="list.cfm?id=#listID#">#getUserLists.title#</a>
					</h4>
					<p>
					#getUserLists.description#

					</p>
					<h6>
					 Created On: #DateFormat(getUserLists.dateCreated, "mm/dd/yyyy")#
					</h6>
				</td>
				<cfif  IsDefined ("session.user.userID")>
				<td>
					<br><br>
					<a class="btn btn-default btn-sm" href="">
						<span class="glyphicon glyphicon-star">
						</span>
					</a>
					<br>
					<cfif  session.user.userID EQ getUserLists.userID >
					<!--- Create link buttons to view and edit the list. Pass the ID associated with each record in the URL of the link --->

					<a class="btn btn-default btn-sm" href="./deleteList.cfm?id=#listID#">
						<span class="glyphicon glyphicon-trash">
						</span>
					</a><br>
					</cfif>

				</td>
				</cfif>
			</tr>
		</cfoutput>
	</tbody>
</table>