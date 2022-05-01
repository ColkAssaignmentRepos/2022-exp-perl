package System::Repository::Thread::Others;
use strict;
use warnings FATAL => 'all';

use lib "../../../";

use System::Config;
use System::Utils::File;


sub get_total_threads_num {
    my $dh = System::Utils::File::get_dir_handler($System::Config::THREADS_ROOT_PATH);

    my $files_num = 0;
    while (my $file = readdir $dh) {
        if ($file =~ /^\.{1,2}$/) {
            next;
        }

        # Darwin System の場合 .DS_Store が生成されることがあるので、無視する必要がある
        if ($file =~ /^.DS_Store$/) {
            next;
        }

        $files_num += 1;
    }

    return $files_num;
}

1;
