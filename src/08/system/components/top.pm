package System::Components::Top;

use strict;
use warnings FATAL => 'all';

use lib "../../";

use System::Config;
use System::Utils::Validators;
use System::Repository::Reply::Others;
use System::Repository::Thread::Get;
use System::Repository::Reply::Get;


sub get_title_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $content;

    my $SERVICE_NAME = $_[0];

    $content = <<"EOT";
<section class="container margin mb-5">
    <h1 class="center display-4">
        $SERVICE_NAME へようこそ
    </h1>
    <span>
        $SERVICE_NAME は Perl 製の簡易掲示板です
        <br>
        新しいスレッドから順に表示されています
    </span>
</section>
EOT

    return $content
}

sub get_thread_num_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $showing_threads_num = $_[0];

    my $content;

    $content = <<"EOT";
<section class="container margin mb-3">
    $showing_threads_num 件のスレッドが表示されています
</section>
EOT

}

sub get_threads_list {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $content;

    my $SERVICE_NAME = $_[0];

    $content = <<"EOT";
<section class="container margin mb-5">
    <h1 class="center display-4">
        $SERVICE_NAME へようこそ
    </h1>
    <span>
        $SERVICE_NAME は Perl 製の簡易掲示板です
        <br>
        新しいスレッドから順に表示されています
    </span>
</section>
EOT

    return $content
}

sub get_thread_card_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $content;

    my %thread = System::Repository::Thread::Get::get_thread($thread_id);
    my %first_reply = System::Repository::Reply::Get::get_reply($thread_id, 1);

    my ($sec, $min, $hour, $mday, $mon, $year) = gmtime($thread{$System::Config::POSTED_EPOCH_TIME_FIELD_NAME});
    $year += 1900;
    $mon += 1;

    my $num_of_reply = System::Repository::Reply::Others::get_total_reply_num_of_thread_id($thread_id);

    $content = <<"EOT";
<div class="card mb-3">
        <div class="card-body mb-3">
            <a href="$System::Config::THREADS_PAGE_URL?id=$thread_id" style="display: inline-block;">
                <h5 class="card-title" href="">
                    $thread{$System::Config::THREAD_TITLE_FIELD_NAME}
                </h5>
            </a>
            <p class="text-secondary text-right" style="display: inline-block;">
                #$thread{$System::Config::THREAD_ID_FIELD_NAME}
            </p>
            <p class="card-text">
                $first_reply{$System::Config::REPLY_CONTENT_FIELD_NAME}
            </p>
            <p class="text-right">
                <i class="fa-solid fa-clipboard"></i>
                作成 $year/$mon/$mday $hour:$min
                /
                <i class="fa-solid fa-clock"></i>
                更新 $year/$mon/$mday $hour:$min

                <br>
                <i class="fa-solid fa-comment"></i>
                $num_of_reply
            </p>
        </div>
    </div>
EOT

}

sub get_threads_descending_html {
    my $total_threads_num = System::Repository::Thread::Others::get_total_threads_num();

    my $thread_first_id;
    $thread_first_id = 1;

    my $thread_last_id;
    $thread_last_id = $total_threads_num;

    my $content;

    $content = <<"EOT";
<section class="container margin mb-5">
EOT

    for (my $i = $thread_last_id; $i >= $thread_first_id; $i--) {
        $content = $content . get_thread_card_html($i);
    }

    $content = $content . <<"EOT";
</section>
EOT

    return $content
}

1;
