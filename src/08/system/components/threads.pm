package System::Components::Threads;

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
    if ($arg_len != 2) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $content;

    my $THREAD_TITLE = $_[0];
    my $THREAD_ID = $_[1];
    System::Utils::Validators::must_natural_number($THREAD_ID);

    $content = <<"EOT";
<body class="margin jumbotron">
<section class="container margin mb-5">
    <h2 class="center display-5" style="">
        $THREAD_TITLE
        <span class="text-secondary text-right" style="display: inline-block;">
                    #$THREAD_ID
            </span>
    </h2>
</section>
EOT

    return $content
}

sub get_num_of_threads_limit_description_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $MAX_REPLY_NUM_PER_THREAD = $_[0];
    System::Utils::Validators::must_natural_number($MAX_REPLY_NUM_PER_THREAD);

    my $content;

    $content = <<"EOT";
<section class="container margin mb-3">
    1 つのスレッドには最大 $MAX_REPLY_NUM_PER_THREAD 件までのレスが格納されます
</section>
EOT

    return $content;
}

sub get_replies_card_html {
    my $arg_len = @_;
    if ($arg_len != 2) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);
    my $reply_id = $_[1];
    System::Utils::Validators::must_natural_number($reply_id);

    my $content;

    my %reply = System::Repository::Reply::Get::get_reply($thread_id, $reply_id);

    my ($sec, $min, $hour, $mday, $mon, $year) = gmtime($reply{$System::Config::POSTED_EPOCH_TIME_FIELD_NAME});
    $year += 1900;
    $mon += 1;

    $content = <<"HTML";
<div class="card mb-3">

    <div class="card-body">
        <h6 class="card-title text-info" style="display: inline-block;">
            $reply{$System::Config::AUTHOR_FIELD_NAME}
        </h6>
        <span class="text-secondary text-right" style="display: inline-block;">
            #$reply_id
        </span>
        <p class="card-text">
            $reply{$System::Config::REPLY_CONTENT_FIELD_NAME}
        </p>
        <p class="text-right">
            <i class="fa-solid fa-clock"></i>
            $year/$mon/$mday $hour:$min:$sec
        </p>
    </div>

</div>
HTML

    return $content;
}

sub get_replies_ascending_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $total_replies_num = System::Repository::Reply::Others::get_total_reply_num_of_thread_id($thread_id);

    my $reply_first_id;
    $reply_first_id = 1;

    my $reply_last_id;
    $reply_last_id = $total_replies_num;

    my $content;

    $content = <<"EOT";
<section class="container margin mb-5">
EOT

    for (my $i = $reply_first_id; $i <= $reply_last_id; $i++) {
        $content = $content . get_replies_card_html($thread_id, $i);
    }

    $content = $content . <<"EOT";
</section>
EOT

    return $content
}

sub get_new_reply_form_html {
    my $arg_len = @_;
    if ($arg_len != 1) {
        die "Unexpected number of arguments: expected 1, but got $arg_len."
    }

    my $thread_id = $_[0];
    System::Utils::Validators::must_natural_number($thread_id);

    my $content;

    $content = <<"HTML";
<section class="container margin mb-5">
    <div class="card mb-3">

        <div class="card-body">
            <form method="POST" action="/system/operations/create_reply.cgi">
                <div class="mb-3">
                    <h3>
                        新しくレスを投稿する
                    </h3>
                </div>
                <div class="mb-3">
                    <label class="form-label">
                        お名前
                    </label>
                    <input name=$System::Config::AUTHOR_FIELD_NAME class="form-control" value=$System::Config::DEFAULT_AUTHOR_NAME>
                </div>
                <div class="mb-3">
                    <label class="form-label">レスの本文</label>
                    <textarea name=$System::Config::REPLY_CONTENT_FIELD_NAME required class="form-control" rows="3"></textarea>
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">レスする</button>
                </div>
                <input type="hidden" name="thread_id" required value=$thread_id></input>
            </form>
        </div>

    </div>
</section>
HTML

}

1;
