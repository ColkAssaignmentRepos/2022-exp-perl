package assignment_02;
use strict;
use warnings FATAL => 'all';

my $NOT_NATURAL_NUMBER_ERR_MSG = "Unexpected input: expected natural number input, but it isn't";
my @WEEK = ("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");

sub main {
    my @input = input_prompt();
    my @sorted = sort(@input);
    show(@sorted);
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

sub input_prompt {
    my @inputs;

    print("index>\n");

    @inputs = <STDIN>;
    chomp(@inputs);

    must_natural_number(@inputs);

    return @inputs;
}

sub show {
    must_natural_number(@_);

    foreach my $element (@_) {
        print("week[$element]: $WEEK[$element]\n");
    }
}

main();

1;