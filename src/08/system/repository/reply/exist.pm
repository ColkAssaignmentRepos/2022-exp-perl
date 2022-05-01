package System::Repository::Reply::Exist;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Utils::Validators;


sub does_reply_exist {
    my $arg_len = @_;
    if ($arg_len != 2) {
        die "Unexpected number of arguments: expected 2, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $reply_id = $_[1];
    System::Utils::Validators::must_natural_number($thread_id);

    my $path_to_reply_dir = $System::Config::THREADS_ROOT_PATH . $thread_id . "/" . $reply_id;

    if (-d $path_to_reply_dir) {
        return 1;
    }
    else {
        return 0;
    }
}

1;
