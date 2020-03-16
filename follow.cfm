<cfif IsDefined("url.id") and IsNumeric(url.id) and IsDefined("session.user.userID")>
	<cfquery name="checkFollow" datasource="#mySite.Account#">
        select *
        from Follow
        where followeeID=<cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">
        and followerID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
    </cfquery>
    <cfif checkFollow.recordcount>
    	<cfquery name="removeFollow" datasource="#mySite.Account#">
            delete from Follow
            where followeeID=<cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">
            and followerID=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
        </cfquery>
    <cfelse>
    	<cfquery name="Follow" datasource="#mySite.Account#">
            insert into Follow(followeeID, followerID)
            values (
				<cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">,
            	<cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.userID#">
            )
        </cfquery>
    </cfif>
    <cfquery name="getFollowCount" datasource="#mySite.Account#">
   		select count(followeeID) as numFollows from Follow
        where followeeID = <cfqueryparam cfsqltype="cf_sql_int" value="#url.id#">
    </cfquery>
    <cfif getFollowCount.recordcount>
    	<cfoutput query="getFollowCount">#numFollows#</cfoutput>
    </cfif>
<cfelse>
	Action not allowed.
</cfif>