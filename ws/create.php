<?php
include_once 'database.php';

$json = file_get_contents('php://input');
$data = json_decode($json);

if (!empty($data)) {
  
  $valid = true;

  $idError = null;
  $titleError = null;
  $contentError = null;
  $priorityError = null;
  $createdError = null;

  $id = $data->id;
  $title = $data->title;
  $content = $data->content;
  $priority = $data->priority;
  $createdAt = date('Y-m-d H:i:s', $data->createdAt/1000);

  if (empty($id)) {
    echo $idErro = 'id!';
    $valid = false;
  }
  if (empty($title)) {
    echo $titleError = 'title!';
    $valid = false;
  }
  if (empty($content)) {
    echo $contentError = 'content!';
    $valid = false;
  }
  if (is_null($priority)) {
    echo $priorityError = 'priority!';
    $valid = false;
  }
  echo $createdAt;
  if (empty($createdAt)) {
    echo  $createdError = 'created!';
    $valid = false;
  }
  if ($valid) {
    try{
      $dbh = new PDO($servername, $username, $password);
      $sql = "INSERT INTO notes(id, title, content, priority, created) VALUES(?, ?, ?, ?, ?)";
      $q = $dbh->prepare($sql);
      $q->execute(array($id, $title, $content, $priority, $created));

    } catch(PDOException $e) {
      echo 'Errorr: '.$e->getMessage();
    }
  } else {
    echo json_encode(" invalid");
  }
}
?>