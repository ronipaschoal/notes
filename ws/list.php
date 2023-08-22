<?php
include_once 'database.php';

try{
	$dbh = new PDO($servername, $username, $password);
	$sql = 'SELECT * FROM notes';
	$sth = $dbh->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));

	$sth->execute();
	echo json_encode($sth->fetchAll());

} catch(PDOException $e) {
	echo 'Error: ' . $e->getMessage();
}
?>