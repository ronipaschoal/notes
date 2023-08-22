<?php
include_once 'database.php';

$id = null;
if (!empty($_GET['id'])) {
    $id = $_REQUEST['id'];
}
try{
	$dbh = new PDO($servername, $username, $password);
  $sql = "SELECT * FROM notes where id = ?";
  $q = $dbh->prepare($sql);
  $q->execute(array($id));
	$sth = $q->fetch(PDO::FETCH_ASSOC);

	echo json_encode($sth);

} catch(PDOException $e) {
	echo 'Error: ' . $e->getMessage();
}
?>