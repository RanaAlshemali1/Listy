<cfif isDefined("session.user.userID")>
	<cflocation url="explore.cfm">
</cfif>
<cfsavecontent variable="Variables.jumbotron">
<br><br><br>
	<h1>Join Listy Today!</h1>
	<p>Listy is a fun way to create, share and explore lists about anything that interests you.</p>
	<p>
		<br>
		<a href="signup.cfm" class=" btn btn-primary btn-lg" role="button">
			Create an Account &raquo;
		</a>
		<br><br><br><br>
	</p>

				</div>
			</div>
</cfsavecontent>

<cfinclude template="header.cfm">
		<div class="container">

			<!-- START Page Body -->

			<!-- Example row of columns -->
			<div class="row">
				<div class="col-md-4">
					<h2>Create Lists</h2>
					<p>Whether it's your favorite restaurants or the places you want to visit, Listy lets you create lists about the things that matter to you. With Listy you can also add photos and other media to make your lists stand out. </p>
					<p><a class="btn btn-default" href="guide.cfm" role="button">View details &raquo;</a></p>
				</div>
				<div class="col-md-4">
					<h2>Follow Friends</h2>
					<p> Listy lets you stay up to date on your friends' interests. Follow your firends or other Listy members and see the lists that they create.</p>
					<p><a class="btn btn-default" href="guide.cfm" role="button">View details &raquo;</a></p>
				</div>
				<div class="col-md-4">
					<h2>Explore</h2>
					<p></p>
					<p>See what's popular, discover trending tags and save your favorite lists.</p> <a class="btn btn-default" href="guide.cfm" role="button">View details &raquo;</a></p>
				</div>
			</div>
<cfinclude template="footer.cfm">