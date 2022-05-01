package System::Config;

use strict;
use warnings FATAL => 'all';

our $SERVICE_NAME = "PerlBoard";
our $ERROR_PAGE_NAME = "Error";

our $THREADS_PAGE_URL = "threads";

our $BAD_REQUEST_ERROR_PAGE_MSG = "不正なリクエストです";
our $MISSING_REQUIRED_QUERY_PARAM_ERROR_MSG = "必要なクエリパラメータが不足しています";

our $NOT_NATURAL_NUMBER_ERR_MSG = "Unexpected input: expected natural number input, but it isn't";
our $NOT_FILE_OPERATOR_ERR_MSG = "Unexpected input: expected file operator string input, but it isn't";
our $UNEXPECTED_CODE_REACHED_ERR_MSG = "Unexpected error: executing unreachable code";

our $NO_REPLY_FOUND = "No such reply: ";
our $NO_THREAD_FOUND = "No such thread: ";
our $UNABLE_TO_OPEN_FILE_ERR_MSG = "Can't open file: ";
our $UNABLE_TO_CREATE_DIRECTORY = "Can't create directory: ";

our $THREAD_ID_FIELD_NAME = "thread_id";
our $THREAD_TITLE_FIELD_NAME = "thread_title";
our $REPLY_ID_FIELD_NAME = "reply_id";
our $AUTHOR_FIELD_NAME = "author";
our $POSTED_EPOCH_TIME_FIELD_NAME = "posted";
our $REPLY_CONTENT_FIELD_NAME = "reply_content";

our $APACHE_ROOT = $ENV{"APACHE_ROOT_PATH_FOR_PERL_CGI"};
our $STORAGE_ROOT_PATH = $APACHE_ROOT . "meta/perlboard/";
our $THREADS_ROOT_PATH = $STORAGE_ROOT_PATH . "threads/";
our $THREAD_META_FILE_NAME = "meta.txt";
our $THREAD_TITLE_FILE_NAME = "title.txt";
our $REPLY_META_FILE_NAME = "meta.txt";
our $REPLY_CONTENT_FILE_NAME = "content.txt";

our $DEFAULT_AUTHOR_NAME = "風吹けば名無し";

1;
