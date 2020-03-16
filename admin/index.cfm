<cfset Variables.pageTitle="Administrator Main Page">
<cfinclude template="../header.cfm">
<h1>
	Administrator Main Page
</h1>
<!--- Administrator page content goes below --->
<cfquery name="getAllUsers" datasource="#mySite.Account#">
	select *
	from users
	order by lastName, firstName
</cfquery>
<p>
	The following registered users are currently on record
</p>
<table class="table table-hover">
	<thead>
		<tr>
			<th>
				First Name
			</th>
			<th>
				Last Name
			</th>
			<th>
				Email
			</th>
			<th>
				Is Admin
			</th>
			<th>
			</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="getAllUsers">
			<tr>
				<td>
					#firstName#
				</td>
				<td>
					#lastName#
				</td>
				<td>
					#email#
				</td>
				<td>
					#Admin#
				</td>
				<td>
					<!--- Create link buttons to view and edit the user. Pass the ID associated with each record in the URL of the link --->
					<a class="btn btn-default btn-sm" href="./admin/user.cfm?id=#userID#">
						<span class="glyphicon glyphicon-user">
						</span>
					</a>
					<a class="btn btn-default btn-sm" href="./admin/editUser.cfm?id=#userID#">
						<span class="glyphicon glyphicon-pencil">
						</span>
					</a>
				</td>
			</tr>
		</cfoutput>
	</tbody>
</table>
<p>
	<a class="btn btn-primary" href="./admin/user.cfm?new">
		Create New Account
	</a>
</p>
<cfinclude template="../footer.cfm">
