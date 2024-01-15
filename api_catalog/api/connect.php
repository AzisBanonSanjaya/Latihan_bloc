<?php
$database_hostname = "127.0.0.1";
$database_user = "root";
$database_password = "";
$database_name = "catalog";

try{
    $database_connection = new PDO("mysql:host=$database_hostname;dbname=$database_name", $database_user, $database_password);
}catch(PDOException $koneksi){
    die($koneksi->getMessage());
}
?>