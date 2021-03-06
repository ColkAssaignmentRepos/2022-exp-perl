#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use CGI;
$CGI::LIST_CONTEXT_WARN = 0;

my $cgi = CGI->new();

my $TITLE = "Form - Result";

my $message = "";

$message = $cgi->param("message");

print <<"HTML";
Content-Type: text/html

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <title>$TITLE</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght\@100;300;400;500;700&display=swap"
          rel="stylesheet">
</head>

<body class="margin jumbotron">
<div>
    <div class="container margin">
        <h2 class="center mb-3">"$message"</h2>
        <h3 class="center">が入力されました</h3>
    </div>
</div>

</body>

</html>
HTML
