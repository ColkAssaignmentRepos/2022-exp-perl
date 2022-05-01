package System::Utils::Validators;

use strict;
use warnings FATAL => 'all';

use lib "../../";

use System::Config;


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
        die $System::Config::NOT_NATURAL_NUMBER_ERR_MSG;
    }

    return;
}

1;
