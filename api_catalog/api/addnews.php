<?php

header('Access-Control-Allow-Origin: *');
header('Cache-Control: no-cache, no-store, max-age=0. must-revalidate');
header('X-Content-Type-Options: nonsniff');

include "connect.php";

$title = $_POST["title"];
$desc = $_POST["desc"];
$date = $_POST["date"];

$nama_file = $_FILES['url_image']['name'];
$tmp_name = $_FILES['url_image']['tmp_name'];

try {
    move_uploaded_file($tmp_name, 'archive/' . $nama_file);
    $statement = $database_connection->prepare("INSERT INTO `news_catalog` (`id`, `title`, `desc`, `image`, `date`) VALUES (NULL, ?, ?, ?, ?)");
    $statement->execute([$title, $desc, 'archive/' . $nama_file, $date]);
    $pesan = "DATA BERHASIL di TAMBAHKAN";
    echo $pesan;
} catch (PDOException $e) {
    echo "DATABASE ERROR: " . $e->getMessage();
} catch (Exception $ex) {
    echo "GENERAL ERROR: " . $e->getMessage();
}
?>