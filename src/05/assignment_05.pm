package assignment_05;
use strict;
use warnings FATAL => 'all';

my $NOT_ZERO_OR_ONE_ERR_MSG = "Unexpected input: expected zero or one as a argument, but it isn't";

sub main {
    my $input = interpreter();
    my $result = is_string_match($input);
    show_result($result);
    print("\n");
}

sub is_zero_or_one {
    foreach my $element (@_) {
        if ($element !~ /^[0|1]$/) {
            return 0;
        }
    }

    return 1;
}

sub must_zero_or_one {
    if (is_zero_or_one(@_) == 0) {
        die $NOT_ZERO_OR_ONE_ERR_MSG;
    }

    return;
}

sub is_string_match {
    foreach my $element (@_) {
        if ($element !~ /^(0|1)+5$/) {
            return 0;
        }
    }

    return 1;
}

sub interpreter {
    print("input> ");
    my $input = <STDIN>;
    chomp($input);

    return $input;
}

sub show_result {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $is_accepted = $_[0];
    must_zero_or_one($is_accepted);

    if ($is_accepted == 1) {
        print("accepted");
    }
    if ($is_accepted == 0) {
        print("not accepted")
    }
}

main();

1;