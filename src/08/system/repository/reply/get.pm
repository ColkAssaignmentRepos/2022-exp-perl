package System::Repository::Reply::Get;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Config;
use System::Utils::Validators;
use System::Utils::File;
use System::Repository::Reply::Exist;


sub get_reply {
    my $arg_len = @_;
    if ($arg_len != 2) {
        die "Unexpected number of arguments: expected 2, but got $arg_len."
    }

    my %reply;

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $reply_id = $_[1];
    System::Utils::Validators::must_natural_number($reply_id);

    my $content = "";

    if (System::Repository::Reply::Exist::does_reply_exist($thread_id, $reply_id) != 1) {
        die $System::Config::NO_REPLY_FOUND . "Thread ID: $thread_id Reply ID: $reply_id"
    }

    my $meta_fh = System::Utils::File::get_file_handler("<", $System::Config::THREADS_ROOT_PATH . "$thread_id/$reply_id/$System::Config::REPLY_META_FILE_NAME");
    my $content_fh = System::Utils::File::get_file_handler("<", $System::Config::THREADS_ROOT_PATH . "$thread_id/$reply_id/$System::Config::REPLY_CONTENT_FILE_NAME");

    $content = do {
        local $/;
        <$content_fh>
    };

    $reply{$System::Config::THREAD_ID_FIELD_NAME} = $thread_id;
    $reply{$System::Config::REPLY_ID_FIELD_NAME} = $reply_id;

    $reply{$System::Config::REPLY_CONTENT_FIELD_NAME} = $content;

    my $i = 0;
    while (my $line = <$meta_fh>) {
        if ($i == 0) {
            $reply{$System::Config::AUTHOR_FIELD_NAME} = $line;
        }
        if ($i == 1) {
            System::Utils::Validators::must_natural_number($i);
            $reply{$System::Config::POSTED_EPOCH_TIME_FIELD_NAME} = $line;
        }
        if ($i >= 2) {
            last;
        }
        $i = $i + 1;
    }

    close $meta_fh;
    close $content_fh;

    return %reply
}

1;
