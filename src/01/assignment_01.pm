package assignment_01;
use strict;
use warnings FATAL => 'all';

my $NOT_NATURAL_NUMBER_ERR_MSG = "Unexpected input: expected natural number input, but it isn't";

sub main {
    my @input = input_prompt();
    my $result = calculate_sum($input[0], $input[1]);
    show_result($result);
    print("\n");
}

sub is_natural_number {
    foreach my $element (@_) {
        if ($element !~ /^[0-9]+$/) {
            return 0;
        }
    }

    return 1;
}

sub must_natural_number {
    if (is_natural_number(@_) == 0) {
        die $NOT_NATURAL_NUMBER_ERR_MSG;
    }

    return;
}

sub calculate_sum {
    my $arg_len = @_;
    if ($arg_len != 2) {
        die "Unexpected number of arguments: expected 2, but got $arg_len."
    }

    my $start = $_[0];
    my $end = $_[1];

    must_natural_number($start, $end);

    my $sum = 0;

    my $i = $start;
    while ($i <= $end) {
        $sum += $i;
        $i += 1;
    }

    return $sum;
}

# オーダー数 1 で計算する ( ガウスの等差級数の和の公式 )
sub calculate_sum_o_1 {
    my $arg_len = @_;
    if ($arg_len != 2) {
        die "Unexpected number of arguments: expected 2, but got $arg_len."
    }

    my $start = $_[0];
    my $end = $_[1];

    must_natural_number($start, $end);

    my $sum = (($start + $end) * ($end - $start + 1)) / 2;

    return $sum;
}

sub input_prompt() {
    print("start> ");
    my $input_start = <STDIN>;
    chomp($input_start);

    must_natural_number($input_start);

    print("end> ");
    my $input_end = <STDIN>;
    chomp($input_end);

    must_natural_number($input_end);

    my @retval = ($input_start, $input_end);

    return @retval
}

sub show_result {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len.";
    }

    print("result: $_[0]")
}

main();

1;
