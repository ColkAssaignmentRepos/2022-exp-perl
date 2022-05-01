package System::Components::Common;

use strict;
use warnings FATAL => 'all';

use lib "../../";

use System::Config;
use System::Utils::Validators;
use System::Repository::Reply::Others;
use System::Repository::Thread::Get;
use System::Repository::Reply::Get;


sub get_header_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $PAGE_NAME = $_[0];

    my $content;

    $content = <<"EOT";
<head>
    <meta charset="UTF-8">
    <title>$PAGE_NAME</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght\@100;300;400;500;700&display=swap"
          rel="stylesheet">
    <script src="https://kit.fontawesome.com/c75ab1556e.js"
            crossorigin="anonymous">
    </script>
</head>
EOT

    return $content;
}

sub get_new_thread_form_html {
    my $content;

    $content = <<"EOT";
<section class="container margin mb-5">
    <div class="card mb-3">

        <div class="card-body">
            <form method="POST" action=system/operations/create_thread.cgi>
                <div class="mb-3">
                    <h3>新しくスレッドを建てる</h3>
                </div>
                <div class="mb-3">
                    <label class="form-label">スレッド名</label>
                    <input name=$System::Config::THREAD_TITLE_FIELD_NAME class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">お名前</label>
                    <input name=$System::Config::AUTHOR_FIELD_NAME class="form-control"
                           value=$System::Config::DEFAULT_AUTHOR_NAME>
                </div>
                <div class="mb-3">
                    <label class="form-label">1レス目の本文</label>
                    <textarea name=$System::Config::REPLY_CONTENT_FIELD_NAME class="form-control" rows="3"
                              required></textarea>
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">スレッドを建てる</button>
                </div>
            </form>
        </div>

    </div>
</section>
EOT

    return $content
}

1;
