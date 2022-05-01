package System::Pages::Error;
use strict;
use warnings FATAL => 'all';

use lib "../../";

use System::Config;

my $ERROR_PAGE_NAME = "$System::Config::SERVICE_NAME - $System::Config::ERROR_PAGE_NAME";


sub get_error_page_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $error_message = $_[0];

    my $content;

    $content = <<"EOT";
Content-Type: text/html

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <title>$ERROR_PAGE_NAME</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght\@100;300;400;500;700&display=swap"
          rel="stylesheet">
    <script src="https://kit.fontawesome.com/c75ab1556e.js"
            crossorigin="anonymous">
    </script>
</head>

<body class="margin jumbotron">

<section class="container margin mb-3">
    <h1 class="center display-5" style="">
        エラーが発生しました
    </h1>
</section>

<section class="container margin mb-3">
    $error_message
</section>

</body>

</html>
EOT

    return $content
}

sub show_error_page_and_exit {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $error_message = $_[0];

    my $content;

    $content = get_error_page_html($error_message);

    print $content;
    exit(-1);
}

1;
