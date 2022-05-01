package System::Pages::Redirect;
use strict;
use warnings FATAL => 'all';

use lib "../../";

use System::Config;

my $PAGE_TITLE = "$System::Config::SERVICE_NAME - Redirecting";


sub show_redirect_page_to_url_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $destination = $_[0];

    print << "EOT";
Content-Type: text/html

<html lang="ja">

<head>
    <meta charset="UTF-8">
    <title>$PAGE_TITLE</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght\@100;300;400;500;700&display=swap"
          rel="stylesheet">
    <link>
    <meta http-equiv="refresh" content="0;URL=$destination">
</head>

<body class="margin jumbotron">

<section class="container margin mb-3">
    <h1 class="center display-5">
        リダイレクトしています
    </h1>
</section>

<section class="container margin mb-3">
    リダイレクトされない場合はこちらをクリックしてください:
    <br/>
    <a href="$destination">
        $destination
    </a>
</section>

</body>

</html>
EOT

}
