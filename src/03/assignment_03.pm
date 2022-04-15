package assignment_03;
use strict;
use warnings FATAL => 'all';

my $NOT_NUMERIC_ERR_MSG = "Unexpected input: expected numeric input, but it isn't";

sub main {
    my @input = (10, 80, 32, 58, 13, 3);
    my $average = calculate_average(@input);
    my @result = above_average(10, 80, 32, 58, 3);

    show_result($average, @result);
    print("\n");
}

sub is_numeric {
    foreach my $element (@_) {
        if ($element !~ /^([1-9]\d*|0)(\.[0-9]+)?$/) {
            return 0;
        }
    }

    return 1;
}

sub must_numeric {
    if (is_numeric(@_) == 0) {
        die $NOT_NUMERIC_ERR_MSG;
    }

    return;
}

sub calculate_sum {
    must_numeric(@_);

    my $sum = 0;

    foreach my $element (@_) {
        $sum += $element
    }

    return $sum;
}


sub calculate_average {
    must_numeric(@_);

    my $arg_len = @_;
    my $sum = calculate_sum(@_);

    my $average = $sum / $arg_len;

    return $average;
}

sub above_average {
    must_numeric(@_);

    my $bound = calculate_average(@_);

    my @result;

    foreach my $element (@_) {
        if ($element > $bound) {
            push(@result, $element);
        }
    }

    return @result;
}

sub show_result {
    must_numeric(@_);

    my $average = $_[0];
    my @result;

    my $is_average_scanned = 0;
    foreach my $element (@_) {
        if ($is_average_scanned == 0) {
            $average = $_[0];
            $is_average_scanned = 1;
            next;
        }
        push (@result, $element);
    }

    print("avg = $average\n");
    print("result: @result");
}

main();

1;