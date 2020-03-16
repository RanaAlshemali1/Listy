<cfquery name="getUser" datasource="#mySite.Account#">
	select *,
	(select Count(followeeID) from Follow Where users.userID = Follow.FolloweeID) as NumOfFollows<cfif IsDefined("session.user.userID")>,
	(select case when exists (select followeeID from Follow where Follow.FolloweeID = Users.userID and followerID = <cfqueryparam cfsqltype="cf_sql_int" value="#session.user.userID#">) then cast (1 as int) else cast (0 as int) end) as userFollow</cfif>
	from users
	where userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ID#">
</cfquery>

<script>
	window.onload=function(){
		jQuery(document).ready(function(){
			jQuery("#displayLists").click(function(){
				jQuery("#userLists").load("./getUserLists.cfm?id=<cfoutput>#URL.id#</cfoutput>");
			});
		});
	};
</script>

<cfset Variables.pageTitle="#getUser.firstName# #getUser.lastName#">
<cfinclude template="header.cfm">
<cfoutput>
<h1>
	#getUser.firstName# #getUser.lastName#
<cfif session.user.userid eq getuser.userid>

					<cfelse><a class="btn btn-default btn-sm<cfif IsDefined("getuser.userFollow") and getuser.userFollow eq 1> follow-active</cfif>" href="##" onclick="followUser(this, #getUser.userid#);return false;">
						<span class="glyphicon glyphicon-user"> Follow
						</span><span class="star-ctr"><cfif getuser.NumOfFollows gt 0>#getuser.NumOfFollows#</cfif></span>
					</a>
					</cfif>
</h1>

<br>
<!--- Start My Account Page Below --->
	<dl class="dl-horizontal">
		<dt>
			Photo
		</dt>
		<dd><a href="photoUpload.cfm">
		<cfif getUser.photo is "">
				<img src="/photos/default.jpg">
		<cfelse>
			<img src="photos/#getUser.photo#">
		</cfif>
		</a></dd>

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
<button id="displayLists">User Lists</button>
<div id="userLists"></div>
</cfoutput>
<cfinclude template="footer.cfm">