<script>
	var userAgent = "Mozilla\x2F5.0\x20\x28Macintosh\x3B\x20Intel\x20Mac\x20OS\x20X\x2010.14\x3B\x20rv\x3A66.0\x29\x20Gecko\x2F20100101\x20Firefox\x2F66.0";
	if (userAgent.search(/iPad|iPhone/) >=0)
		__cfclient_platform = "ios";
	else if (userAgent.search(/Android/) >= 0)
		__cfclient_platform = "android";
	else
		__cfclient_platform = "pg_emulator";	
</script>
