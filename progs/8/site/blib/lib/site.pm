package site;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';

};
get '/hello' => sub {
    template 'me.html', {'path' => 'aaaaa'};
};

true;
