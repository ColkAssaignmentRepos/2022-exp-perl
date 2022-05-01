package System::Repository::Thread::Exist;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Config;
use System::Utils::Validators;


sub does_thread_exist {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $path_to_thread_dir = $System::Config::THREADS_ROOT_PATH . $thread_id;

    if (-d $path_to_thread_dir) {
        return 1;
    }
    else {
        return 0;
    }
}

1;
