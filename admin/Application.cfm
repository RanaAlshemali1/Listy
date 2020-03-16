<cfinclude template="../Application.cfm">
<cfif Not(IsDefined("session.user.admin") and session.user.admin is "1")>
	<cflocation url="../">
</cfif>
