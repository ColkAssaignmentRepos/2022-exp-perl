package System::Repository::Reply::Others;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Config;
use System::Utils::Validators;
use System::Utils::File;
use System::Repository::Reply::Exist;


sub get_total_reply_num_of_thread_id {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $dh = System::Utils::File::get_dir_handler($System::Config::THREADS_ROOT_PATH . $thread_id);

    my $files_num = 0;
    # すべてのファイルを読み込む
    while (my $file = readdir $dh) {
        if ($file =~ /^\.{1,2}$/) {
            next;
        }

        # Darwin System の場合 .DS_Store が生成されることがあるので、無視する必要がある
        if ($file =~ /^.DS_Store$/) {
            next;
        }

        if ($file eq $System::Config::THREAD_META_FILE_NAME || $file eq $System::Config::THREAD_TITLE_FILE_NAME) {
            next;
        }

        $files_num += 1;
    }

    return $files_num;
}

1;
