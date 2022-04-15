package assignment_04;
# use strict;
use warnings FATAL => 'all';

sub main {
    show();
}

sub show {
    foreach my $key (sort keys %ENV) {
        print("$key = $ENV{$key}\n")
    }
}

main();

1;
