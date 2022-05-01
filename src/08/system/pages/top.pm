package System::Pages::Top;

use strict;
use warnings FATAL => 'all';

use lib "../../";

use System::Config;
use System::Repository::Thread::Others;
use System::Components::Common;
use System::Components::Top;

my $PAGE_NAME = $System::Config::SERVICE_NAME . " - " . "TOP";


sub main {
    my $total_threads = System::Repository::Thread::Others::get_total_threads_num();

    print <<"EOT";
Content-Type: text/html

EOT

    my $html = "";
    $html = $html . <<"EOT";
<!DOCTYPE html>
<html lang="ja">

<body class="margin jumbotron">

EOT

    my $header = System::Components::Common::get_header_html($PAGE_NAME);
    $html = $html . $header;

    my $title = System::Components::Top::get_title_html($System::Config::SERVICE_NAME);
    $html = $html . $title;

    my $new_thread_form = System::Components::Common::get_new_thread_form_html();
    $html = $html . $new_thread_form;

    my $number_of_threads = System::Components::Top::get_thread_num_html($total_threads);
    $html = $html . $number_of_threads;

    my $threads = System::Components::Top::get_threads_descending_html();
    $html = $html . $threads;

    print($html);

    print <<"EOT";
</body>
</html>
EOT
}

1;
