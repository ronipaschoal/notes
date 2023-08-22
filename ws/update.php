<?php
include_once 'database.php';

if (!empty($_POST)) {

  $idError = null;
  $titleError = null;
  $contentError = null;
  $priorityError = null;
  $createdError = null;

  $id = $_POST['id'];
  $title = $_POST['title'];
  $content = $_POST['content'];
  $priority = $_POST['priority'];
  $created = $_POST['created'];

  $valid = true;
  if (empty($id)) {
     echo $idErro = 'id!';
      $valid = false;
  }
  
  if (empty($title)) {
    echo  $titleError = 'title!';
      $valid = false;
  }

  if (empty($content)) {
    echo $contentError = 'content!';
    $valid = false;
  }

  if (empty($priority)) {
    echo $priorityError = 'priority!';
      $valid = false;
  }

  if (empty($created)) {
    echo  $createdError = 'created!';
      $valid = false;
  }

 if ($valid) {
    try{
      $dbh = new PDO($servername, $username, $password);
      $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      $sql = "UPDATE notes set id = ?, title = ?, content = ?, priority = ?, created = ? WHERE id = ?";
      $q = $dbh->prepare($sql);
      $q->execute(array($id, $title, $content, $priority, $created, $id));

      echo json_encode($q);

    } catch(PDOException $e) {
      echo 'Errorr: ' . $e->getMessage();
    }
  } else {
    echo json_encode("invalid");
  }
}
?>