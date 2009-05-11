<!DOCTYPE html PUBLIC
      "-//W3C//DTD XHTML 1.0 Transitional//EN"
		  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>Filling Database Fields</title>
  <base href="http://localhost/" />

    <!-- For dynamically generated pages -->
  <meta http-equiv="pragma" content="no-cache" />
  <meta http-equiv="cache-control" content="no-cache" />
  <meta http-equiv="expires" content="0" />

  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <meta http-equiv="Content-Language" content="en-EN" />

  <meta name="Author" content="Philippe Lhoste" />
  <meta name="Copyright" content="Copyright (c) 2006 Philippe Lhoste" />
  <meta name="Generator" content="My typing hands with SciTE" />
  <meta http-equiv="Keywords" content="test,php,language" />
  <meta http-equiv="Description" content="A test page for PHP experiments" />

<style type="text/css">
body { background-color: #F0F8F0; }
h1
{
  background-color: #BFC;
  color: #008;
  text-align: center;
  padding: 20px;
}
h2
{
  background-color: #DFE;
  color: #088;
  padding: 10px;
}
pre
{
  background-color: #FAFAFF;
  color: #228;
}
</style>
</head>

<body>

<h1>Filling Database Fields</h1>

<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="POST">
    <fieldset><legend>Message Input</legend>
        <label for="author">Author:</label><input type="text" name="author" id="author"/><br/>
        <label for="message">Message:</label><input type="text" name="message" id="message" size="160"/><br/>
        <input type="submit"/>
    </fieldset>
</form>

</body>
</html>

<?php
if (!isset($_POST['message']))
    return; // Just display the page
$author = htmlspecialchars(@$_POST['author']);
$message = htmlspecialchars(@$_POST['message']);
AddData($author, $message);
?>

<?php
function AddData($author, $message)
{
    $cnx = mysql_connect('localhost', 'PhiLho', 'Foo#Bar') or die('Could not connect: ' . mysql_error());
    mysql_select_db('tests', $cnx) or die('Could not select DB "tests": ' . mysql_error());

    mysql_query("INSERT INTO p5_messages (creator, message, date_added)
    VALUES ('$author', '$message', now())");

    mysql_close($cnx);
}
?>

