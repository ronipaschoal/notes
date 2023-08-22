<?php
include_once 'database.php';

if (true || $_SERVER["REQUEST_METHOD"] == "POST") {
  $idError = null;
  $titleError = null;
  $contentError = null;
  $priorityError = null;
  $createdError = null;

  if (!empty($_POST)) {
      $valid = True;
      $novoUsuario = False;
      if (!empty($_POST['id'])) {
          $id = $_POST['id'];
      } else {
          $idError = 'need id!';
          $valid = False;
      }

      if (!empty($_POST['title'])) {
          $title = $_POST['title'];
      } else {
          $titleError = 'need title!';
          $valid = False;
      }

      if (!empty($_POST['content'])) {
          $content = $_POST['content'];
      } else {
          $contentError = 'need content!';
          $valid = False;
      }

      if (!empty($_POST['priority'])) {
          $priority = $_POST['priority'];
      } else {
          $priorityError = 'need priority!';
          $valid = False;
      }

      if (!empty($_POST['created'])) {
          $created = $_POST['created'];
      } else {
          $createdError = 'need created!';
          $valid = False;
      }
  }
  if ($valid) {
    try{
      $dbh = new PDO($servername, $username, $password);
      $sql = "INSERT INTO notes(id, title, content, priority, created) VALUES(?, ?, ?, ?, ?)";
      $q = $dbh->prepare($sql);
      $q->execute(array($id, $title, $content, $priority, $created));

      echo json_encode($q);

    } catch(PDOException $e) {
      echo 'Errorr: ' . $e->getMessage();
    }
  } else {
    echo json_encode("invalid");
  }
}
?>