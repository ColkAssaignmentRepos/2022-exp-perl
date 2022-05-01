#!/usr/bin/perl

package System::Operations::CreateThread;

use strict;
use warnings FATAL => 'all';

use CGI;

my $cgi = CGI->new();

use lib "../../";

use System::Config;
use System::Pages::Error;
use System::Pages::Redirect;
use System::Repository::Thread::Create;


sub main {
    my $thread_title = $cgi->param($System::Config::THREAD_TITLE_FIELD_NAME);
    my $author = $cgi->param($System::Config::AUTHOR_FIELD_NAME);
    my $first_reply_content = $cgi->param($System::Config::REPLY_CONTENT_FIELD_NAME);

    unless (defined $thread_title or defined $author or defined $first_reply_content) {
        System::Pages::Error::show_error_page_and_exit($System::Config::BAD_REQUEST_ERROR_PAGE_MSG);
    }

    if ($author eq "") {
        $author = $System::Config::DEFAULT_AUTHOR_NAME
    }

    if ($first_reply_content eq "") {
        System::Pages::Error::show_error_page_and_exit($System::Config::BAD_REQUEST_ERROR_PAGE_MSG);
    }

    System::Repository::Thread::Create::create_thread($thread_title, $author, $first_reply_content);

    my $latest_thread_id = System::Repository::Thread::Others::get_total_threads_num();

    my $latest_thread_url = "/$System::Config::THREADS_PAGE_URL?id=$latest_thread_id";
    System::Pages::Redirect::show_redirect_page_to_url_html($latest_thread_url);

    exit(0);
}

main();

1;
