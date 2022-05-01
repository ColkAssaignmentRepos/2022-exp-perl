package System::Utils::File;

use strict;
use warnings FATAL => 'all';

use lib "../../";

use System::Config;


sub is_file_operator {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $input = $_[0];

    if ($input eq "<") {
        return 1;
    }
    if ($input eq ">") {
        return 1;
    }
    if ($input eq ">>") {
        return 1;
    }

    return 0;
}

sub must_file_operator {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    if (is_file_operator($_[0]) == 1) {
        return;
    }

    die $System::Config::NOT_FILE_OPERATOR_ERR_MSG;
}

sub get_file_handler {
    my $arg_len = @_;
    if ($arg_len != 2) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $mode = $_[0];
    must_file_operator($mode);

    my $path = $_[1];

    open my $fh, $mode, $path or die qq/$System::Config::UNABLE_TO_OPEN_FILE_ERR_MSG . $path : $!/;

    return $fh;
}

sub get_dir_handler {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $path = $_[0];

    opendir my $dh, $path
        or die $System::Config::UNABLE_TO_OPEN_FILE_ERR_MSG . $path;

    return $dh;
}

1;
