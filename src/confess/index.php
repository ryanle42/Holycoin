<?php
	if (isset($_POST["submit"])) {
		echo $_POST["confession"];
	}
?>

<html>
<head>
	<meta charset="UTF-8">
	<link type="text/css" rel="stylesheet" href="../css/style.css"/>
	<title>Confession Page</title>
</head>
<body>
	<h1><a href="../" class="home">HolyCoin</a></h1>
	<div class="header">
		<a class="indulgences" href="../indulgences">Indulgences</a>
		<a class="confess" href="./">Confess</a>
	</div>
	<h2>Confess your sins</h2>
	<form method="POST">
		<textarea id="confession-box" name="confession" required></textarea>
		<br/>
		<input type="submit" name="submit" value="Submit">
	</form>
</body>
</html>