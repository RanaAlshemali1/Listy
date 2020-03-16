<cfset Variables.pageTitle="User Information">
<cfinclude template="../header.cfm">
<h1>
	User Information
</h1>
<!--- User page content goes below --->
<cfif IsDefined("url.ID") and IsNumeric(url.ID)>
	<cfquery name="getUser" datasource="#mySite.Account#">
<!--- select the users table record where userID matches that of url.ID --->
	select *
	from users
	where userID=<cfqueryparam cfsqltype="cf_sql_int" value="#url.ID#">

</cfquery>
	<cfquery name="getUserLogins" datasource="#mySite.Account#">
<!--- select the userLogins table records where userID matches that of url.ID --->
	select *
	from userLogins
	where userID=<cfqueryparam cfsqltype="cf_sql_int" value="#url.ID#">
	ORDER BY loginDate DESC

</cfquery>
	<cfif IsDefined("getUser.recordcount") and getUser.recordcount>
		<cfoutput>
			<dl class="dl-horizontal">
				<dt>
					First Name
				</dt>
				<dd>
					#getUser.firstName#
				</dd>
				<dt>
					Last Name
				</dt>
				<dd>
					#getUser.lastName#
				</dd>
				<dt>
					Email
				</dt>
				<dd>
					#getUser.Email#
				</dd>

			</dl>
		</cfoutput>
	</cfif>
	<h3>
		User Logins
	</h3>
	<!---<cfif IsDefined("getUserLogins.recordcount") and getUserLogins.recordcount>--->
	<cfif getUserLogins.recordcount>


		<table class="table table-hover">
			<thead>
				<tr>
					<th>
						Date
					</th>
					<th>
						IP
					</th>
					<th>
						Lat/Lon
					</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="getUserLogins">
					<tr>
						<td>
							#DateFormat(getUserLogins.loginDate)# #TimeFormat(getUserLogins.loginDate)#
						</td>
						<td>
							#getUserLogins.ipAddress#
						</td>
						<td>
							<a href="http://maps.google.com/?q=#lat#,#lon#">#lat#/#lon#</a>
						</td>

					</tr>

				</cfoutput>
			</tbody>
		</table>
	<cfelse>
		<h3>
			No user login data is available for this user
		</h3>
	</cfif>
	<!---</cfif>--->
</cfif>

<cfinclude template="../footer.cfm">
