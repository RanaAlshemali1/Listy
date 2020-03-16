<cfif IsDefined("url.id") and IsNumeric(url.id) and IsDefined("session.user.userID")>
	<cfquery name="checkLike" datasource="#mySite.Account#">
        select *
        from Likes
        where listID=<cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">
        and userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
    </cfquery>
    <cfif checkLike.recordcount>
    	<cfquery name="removeLike" datasource="#mySite.Account#">
            delete from Likes
            where listID=<cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">
            and userID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
        </cfquery>
    <cfelse>
    	<cfquery name="Like" datasource="#mySite.Account#">
            insert into Likes(listID, userID)
            values (
				<cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">,
            	<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
            )
        </cfquery>
    </cfif>
    <cfquery name="getLikeCount" datasource="#mySite.Account#">
   		select count(listID) as numLikes from Likes
        where listID = <cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">
    </cfquery>
    <cfif getLikeCount.recordcount>
    	<cfoutput query="getLikeCount">#numLikes#</cfoutput>
    </cfif>
<cfelse>
	Action not allowed.
</cfif>