<!-- END Page Body -->
<hr>
<footer>
	<iframe src="//www.facebook.com/plugins/like.php?href=<cfoutput> http://itec334.american.edu#cgi.script_name#</cfoutput>&amp;width&amp;layout=standard&amp;action=like&amp;show_faces=true&amp;share=true&amp;height=80&amp;appId=" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:80px;" allowTransparency="true">
	</iframe>
	<p>

		<cfoutput>
			<p>&copy; <cfoutput>#mySite.Author# #Year(Now())# <b>This project is part of American University's ITEC-334 Online Business Application course.</b></cfoutput></p>
		</cfoutput>
	</p>
</footer>
</div>
<!-- /container -->
<!-- Bootstrap core JavaScript
	================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="js/ie10-viewport-bug-workaround.js"></script>
<script src="js/shared.js"></script>
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-69716410-1', 'auto');
ga('send', 'pageview');
</script>
<cfif Not IsDefined("session.user")>
	<script>
		navigator.geolocation.getCurrentPosition(writeLocation);
		function writeLocation(position)
		{
			var lat = position.coords.latitude;
			var lon = position.coords.longitude;
			jQuery('input[name=lat]').val(lat);
			jQuery('input[name=lon]').val(lon);
		}
	</script>
</cfif>
<cfif IsDefined("Variables.pageScript")><cfoutput>#Variables.pageScript#</cfoutput></cfif>
</body> </html>
