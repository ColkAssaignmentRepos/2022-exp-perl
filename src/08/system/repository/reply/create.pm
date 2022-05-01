package System::Repository::Reply::Create;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Config;
use System::Utils::Validators;
use System::Utils::File;
use System::Repository::Reply::Others;
use System::Repository::Thread::Exist;


sub create_reply {
    my $arg_len = @_;
    if ($arg_len != 3) {
        die "Unexpected number of arguments: expected 3, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $author_name = $_[1];
    my $content = $_[2];

    if (System::Repository::Thread::Exist::does_thread_exist($thread_id) != 1) {
        die $System::Config::NO_THREAD_FOUND . $thread_id;
    }

    my $reply_num = System::Repository::Reply::Others::get_total_reply_num_of_thread_id($thread_id);
    my $creating_reply_id = $reply_num + 1;

    my $now_time = time();
    System::Utils::Validators::must_natural_number($now_time);

    my $directory_path = "$System::Config::THREADS_ROOT_PATH$thread_id/$creating_reply_id/";

    if (!-d $directory_path) {
        mkdir($directory_path) || die $System::Config::UNABLE_TO_CREATE_DIRECTORY . $directory_path;
    }
    else {
        die $System::Config::UNABLE_TO_CREATE_DIRECTORY . $directory_path
    }

    my $content_file_path = $directory_path . $System::Config::REPLY_CONTENT_FILE_NAME;
    my $meta_file_path = $directory_path . $System::Config::REPLY_META_FILE_NAME;

    my $content_fh = System::Utils::File::get_file_handler(">", $content_file_path);
    my $meta_fh = System::Utils::File::get_file_handler(">", $meta_file_path);

    print $content_fh $content;
    print $meta_fh "$author_name\n$now_time";

    close $content_fh;
    close $meta_fh;
}

1;
