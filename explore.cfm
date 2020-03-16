
<cfset Variables.pageTitle="Explore Lists">

<cfquery name="getUserLists" datasource="#mySite.Account#">
	select Lists.listId, Lists.userID, Lists.title, Lists.description, Lists.photo, users.firstName, users.lastName, Lists.dateCreated,
	(select Count(listID) from Likes Where Lists.listID = Likes.listID) as NumOfLikes<cfif IsDefined("session.user.userID")>,
	(select case when exists (select listID from Likes where Lists.listID = Likes.listID and userID = <cfqueryparam cfsqltype="cf_sql_int" value="#session.user.userID#">) then cast (1 as int) else cast (0 as int) end) as userLike</cfif>
	from Lists
	inner join users
	ON Lists.userID = users.userID
    <cfif IsDefined("url.c") or IsDefined("url.q")>where
                <cfif IsDefined("url.c") and url.c eq "following">Lists.userID IN (select followeeID from Follow where followerID = <cfqueryparam cfsqltype="cf_sql_int" value="#session.user.userID#">)
                <cfelseif IsDefined("url.c") and IsNumeric(url.c)>catID = <cfqueryparam cfsqltype="cf_sql_int" value="#url.c#">
        </cfif>
            <cfif IsDefined("url.q")>
                <cfif IsDefined("url.c")>and </cfif>(Lower(Lists.title) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#lcase(url.q)#%"> OR  Lower(Lists.description) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#lcase(url.q)#%">)
        </cfif>
    </cfif>
	order by NumOfLikes DESC, title
</cfquery>
<cfquery name="getTags" datasource="#mySite.Account#">
	select *, (select Count(catId) from Lists Where Lists.catID = Categories.catID) as NumOfLists
    from Categories
    order by NumOfLists DESC, Description
</cfquery>

<cfinclude template="header.cfm">
<br>
<center><h1>Explore Lists</h1></center>
<br>

<div class="table-responsive col-md-3">
	<cfset i=0>
<table class="table table-hover">
	<tbody>
			<tr>
				<td>
					<div class="category-title"><a href="explore.cfm">#Popular</a></div>
				</td>
			</tr>
            <tr>
				<cfif isDefined("session.user.userid")>
	            	<td>
	                	<div class="category-title"><a href="explore.cfm?c=following">#Following</a></div>
	                </td>
				</cfif>
            </tr>
			<cfoutput query="getTags">
				<tr>
                	<td>
                    	<div class="category-title"><a href="explore.cfm?c=#catID#">###description# (#NumOfLists#)</a></div>
                    </td>
                </tr>
			</cfoutput>
	</tbody>
</table>
</div>
<div class="getListTable">
<div class="table-responsive col-md-9">
<table class="table table-hover">
	<tbody>
		<cfoutput query="getUserLists">

			<tr>

				<td>
					<!--- Add list thumbnail to list of lists--->

							<cfif photo is "">
								<img src="/student/team2/photos/default.jpg" width="130">

							<cfelse>
								<img src="photos/listphotos/#photo#"  width="130">
							</cfif>
				</td>
				<td>

					<h4>
					<a href="list.cfm?id=#listID#">#title#</a>
					</h4>
					<p>
					#description#
					</p>
					<h5>
					 By: #firstName# #lastName#
					</h5>
					<h6>
					 Created On: #DateFormat(dateCreated, "mm/dd/yyyy")#
					</h6>
				</td>
				<cfif IsDefined ("session.user.userID")>
				<td>
					<br><br>
					<a class="btn btn-default btn-sm<cfif IsDefined("userLike") and userLike eq 1> like-active</cfif>" href="##" onclick="likeList(this, #listID#);return false;">
						<span class="glyphicon glyphicon-star">
						</span><span class="star-ctr"><cfif NumOfLikes gt 0> #NumOfLikes#</cfif></span>
					</a>
					<cfif  session.user.userID EQ getUserLists.userID >
					<!--- Create link buttons to view and edit the list. Pass the ID associated with each record in the URL of the link --->
                        <a class="btn btn-default btn-sm" href="./editList.cfm?id=#listID#">
                            <span class="glyphicon glyphicon-pencil">
                            </span>
                        </a>
                        <a class="btn btn-default btn-sm" href="./deleteList.cfm?id=#listID#">
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
</div>
</div>


<cfif isDefined("session.user.userid")><a href="./createList.cfm"><div class="fixedbutton">+</div></a></cfif>


<cfinclude template="footer.cfm">