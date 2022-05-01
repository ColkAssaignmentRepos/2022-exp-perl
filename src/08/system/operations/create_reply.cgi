#!/usr/bin/perl

package System::Operations::CreateThread;

use strict;
use warnings FATAL => 'all';

use CGI;

my $cgi = CGI->new();

use lib "../../";

use System::Config;
use System::Utils::Validators;
use System::Pages::Error;
use System::Pages::Redirect;
use System::Repository::Reply::Create;

my $THREAD_ID_QUERY_PARAMETER_NAME = "thread_id";


sub main {
    my $thread_id = $cgi->param($THREAD_ID_QUERY_PARAMETER_NAME);

    my $author = $cgi->param($System::Config::AUTHOR_FIELD_NAME);
    my $content = $cgi->param($System::Config::REPLY_CONTENT_FIELD_NAME);

    unless (defined $thread_id or defined $author or defined $content) {
        System::Pages::Error::show_error_page_and_exit($System::Config::BAD_REQUEST_ERROR_PAGE_MSG);
    }

    System::Utils::Validators::must_natural_number($thread_id);

    if ($author eq "") {
        $author = $System::Config::DEFAULT_AUTHOR_NAME
    }

    if ($content eq "") {
        System::Pages::Error::show_error_page_and_exit($System::Config::BAD_REQUEST_ERROR_PAGE_MSG);
    }

    System::Repository::Reply::Create::create_reply($thread_id, $author, $content);

    my $thread_url = "/threads.cgi?id=$thread_id";
    System::Pages::Redirect::show_redirect_page_to_url_html($thread_url);

    exit(0);
}

main();

1;
