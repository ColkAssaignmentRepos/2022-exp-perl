package System::Repository::Thread::Get;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Config;
use System::Utils::Validators;
use System::Utils::File;
use System::Repository::Thread::Exist;


sub get_thread {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    if (System::Repository::Thread::Exist::does_thread_exist($thread_id) == 0) {
        die $System::Config::NO_THREAD_FOUND . "Thread ID $thread_id"
    }

    my %thread;

    $thread{$System::Config::THREAD_ID_FIELD_NAME} = $thread_id;

    my $meta_fh = System::Utils::File::get_file_handler("<", $System::Config::THREADS_ROOT_PATH . "$thread_id/$System::Config::THREAD_META_FILE_NAME");
    my $title_fh = System::Utils::File::get_file_handler("<", $System::Config::THREADS_ROOT_PATH . "$thread_id/$System::Config::THREAD_TITLE_FILE_NAME");

    my $title = do {
        local $/;
        <$title_fh>
    };

    $thread{$System::Config::THREAD_TITLE_FIELD_NAME} = $title;

    my $i = 0;
    while (my $line = <$meta_fh>) {
        if ($i == 0) {
            $thread{$System::Config::AUTHOR_FIELD_NAME} = $line;
        }
        if ($i == 1) {
            System::Utils::Validators::must_natural_number($i);
            $thread{$System::Config::POSTED_EPOCH_TIME_FIELD_NAME} = $line;
        }
        if ($i >= 2) {
            last;
        }
        $i = $i + 1;
    }

    close $meta_fh;
    close $title_fh;

    return %thread;
}

1;