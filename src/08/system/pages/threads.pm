package System::Pages::Threads;

use strict;
use warnings FATAL => 'all';

use CGI;

use lib "../../";

use System::Config;
use System::Utils::Validators;
use System::Components::Common;
use System::Components::Threads;

my $cgi = CGI->new();

my $THREAD_ID_QUERY_PARAMETER_NAME = "id";


sub main {
    my $thread_id = $cgi->param($THREAD_ID_QUERY_PARAMETER_NAME);

    unless (defined $thread_id) {
        System::Pages::Error::show_error_page_and_exit($System::Config::MISSING_REQUIRED_QUERY_PARAM_ERROR_MSG);
    }

    System::Utils::Validators::must_natural_number($thread_id);

    my %thread = System::Repository::Thread::Get::get_thread($thread_id);

    my $thread_title = $thread{$System::Config::THREAD_TITLE_FIELD_NAME};

    my $page_name = "$System::Config::SERVICE_NAME - $thread_title ($thread_id)";

    print <<"EOT";
Content-Type: text/html

EOT

    my $html = "";
    $html = $html . <<"EOT";
<!DOCTYPE html>
<html lang="ja">

<body class="margin jumbotron">

EOT

    my $header = System::Components::Common::get_header_html($page_name);
    $html = $html . $header;

    my $title = System::Components::Threads::get_title_html($thread_title, $thread_id);
    $html = $html . $title;

    my $replies = System::Components::Threads::get_replies_ascending_html($thread_id);
    $html = $html . $replies;

    my $new_thread_form = System::Components::Threads::get_new_reply_form_html($thread_id);
    $html = $html . $new_thread_form;

    print($html);

    print <<"EOT";
</body>
</html>
EOT
}

1;
