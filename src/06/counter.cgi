#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

my $APACHE_ROOT = $ENV{"APACHE_ROOT_PATH_FOR_PERL_CGI"};
my $COUNTING_FILE_PATH = $APACHE_ROOT . "meta/counter.txt";
my $NOT_NATURAL_NUMBER_ERR_MSG = "Unexpected input: expected natural number input, but it isn't";
my $NOT_FILE_OPERATOR_ERR_MSG = "Unexpected input: expected file operator string input, but it isn't";
my $UNEXPECTED_CODE_REACHED_ERR_MSG = "Unexpected error: executing unreachable code";
my $UNABLE_TO_OPEN_FILE_ER_MSG = "Can't open file: " . $COUNTING_FILE_PATH;

my $title = "Counter";


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

    die $NOT_FILE_OPERATOR_ERR_MSG;
}

sub get_file_handler {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $mode = $_[0];
    must_file_operator($mode);

    open my $fh, $mode, $COUNTING_FILE_PATH or die qq/$UNABLE_TO_OPEN_FILE_ER_MSG : $!/;

    return $fh;
}

sub get_current_count {
    my $fh = get_file_handler("<");

    while (my $line = <$fh>) {
        chomp($line);
        must_natural_number($line);

        close $fh;
        return $line
    }

    close $fh;
    die $UNEXPECTED_CODE_REACHED_ERR_MSG
}

sub write_to_counter_file {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $content = $_[0];
    must_natural_number($content);

    my $fh = get_file_handler(">");

    print $fh $content;

    close $fh;
    return;
}

sub increment_counter {
    my $current_count = get_current_count();
    write_to_counter_file($current_count + 1);
}

sub main {
    my $body = "";

    increment_counter();

    $body = $body . "\nAccessCount: " . get_current_count();
    my $current_count = get_current_count();

    print <<"EOT";
Content-Type: text/html

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <title>$title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght\@100;300;400;500;700&display=swap"
          rel="stylesheet">
</head>

<body class="margin jumbotron">
<div>
    <div class="container margin">
        <h1 class="display-4 center">$current_count</h1>
        <h2 class="center">View Counts</h2>
    </div>
</div>

</body>

</html>
EOT
}

main();

1;
