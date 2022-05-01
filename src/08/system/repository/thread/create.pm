package System::Repository::Thread::Create;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Config;
use System::Utils::File;
use System::Repository::Thread::Exist;
use System::Repository::Thread::Others;
use System::Repository::Reply::Create;


sub create_thread {
    my $arg_len = @_;
    if ($arg_len != 3) {
        die "Unexpected number of arguments: expected 3, but got $arg_len."
    }

    my $title = $_[0];
    my $author_name = $_[1];
    my $content_of_first_reply = $_[2];

    my $total_threads_num = System::Repository::Thread::Others::get_total_threads_num();
    my $creating_thread_id = $total_threads_num + 1;

    my $directory_path = $System::Config::THREADS_ROOT_PATH . $creating_thread_id . "/";

    if (!-d $directory_path) {
        mkdir($directory_path) || die $System::Config::UNABLE_TO_CREATE_DIRECTORY . $directory_path;
    }
    else {
        die $System::Config::UNABLE_TO_CREATE_DIRECTORY . $directory_path
    }

    my $now = time();
    System::Utils::Validators::must_natural_number($now);

    my $title_file_path = $directory_path . $System::Config::THREAD_TITLE_FILE_NAME;
    my $meta_file_path = $directory_path . $System::Config::THREAD_META_FILE_NAME;

    my $title_fh = System::Utils::File::get_file_handler(">", $title_file_path);
    my $meta_fh = System::Utils::File::get_file_handler(">", $meta_file_path);

    print $title_fh $title;
    print $meta_fh "$author_name\n$now";

    System::Repository::Reply::Create::create_reply($creating_thread_id, $author_name, $content_of_first_reply);

    close $title_fh;
    close $meta_fh;
}

1;
