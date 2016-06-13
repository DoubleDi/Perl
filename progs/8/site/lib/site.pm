package site;
use Dancer2;
use DDP;
use Dancer2::Plugin::Database;
use Dancer2::Template::TemplateToolkit qw(process);
use Dancer2::Plugin::DBIC qw(schema resultset);
use feature "say";
our $VERSION = '0.1';

get '/' => sub {
    template 'index';

};


get '/me' => sub {
    if (!session('user')) {
        forward '/login';
    } else {
        template me => {
            user => session('user')
        };
    }
};

get '/register' => sub {
    template 'register';
};

get '/login' => sub {
    template 'login';
};

post '/change' => sub {
    p session('user');
    my $id =  session('user')->{id};
    if (params->{nickname}) {
        database->quick_update('user', { id => $id }, { nickname => params->{nickname}});
    }
    if (params->{avatar}) {
        database->quick_update('user', { id => $id }, { avatar => params->{avatar}});
    }
    if (params->{password}) {
        database->quick_update('user', { id => $id }, { password => params->{password}});
    }
    my $user = database->quick_select('user', { id => $id } );
    session user => $user;
    forward '/me', {}, { method => 'GET' };
};

get '/delete' => sub {
    session('user');
    my $id =  session('user')->{id};
    app->destroy_session;
    my $user = database->quick_delete('user', { id => $id } );
    forward '/last_five';
};

get '/last_five' => sub {
    my @users = database->quick_select('user', {});
    p @users;
    @users = @users[-5..-1];
    template 'last_five.tt', { users => \@users };
};

get '/logout' => sub {
    app->destroy_session;
    forward '/last_five';
};

get '/auth' => sub {
    my $user = database->quick_select('user', { nickname => params->{nickname}, password => params->{password}});
    if (defined $user) {
        set session => 'YAML';
        session user => $user;
        forward '/me';
    } else {
        forward '/last_five';
    }
};

post '/reg' => sub {
    if (params->{password} ne params->{confirm_password})
    {
        forward '/register', {}, { method => 'GET' };
    }
    database->quick_insert('user',
    {
        nickname => params->{nickname},
        password => params->{password},
        avatar => params->{avatar},
    });
    my $user = database->quick_select('user',
    {
        nickname => params->{nickname},
        password => params->{password},
        avatar => params->{avatar},
    });
    p $user;
    if (defined $user) {
        app->destroy_session;
        set session => 'YAML';
        session user => $user;
        forward '/me', {}, { method => 'GET' };
    } else {
        say "ERROR";
    }
};


get '/main/:page' => sub {
    return "Hello ".params->{page};
};
get '/test' => sub {
    # database->quick_insert('user', { nickname => 'user', avatar => 'http://stroite-sami.ru/images/flizelinovie-oboi.jpg', password => 1111 });
    # database->quick_insert('user', { nickname => 'Denis', avatar => 'http://newimages.ru/wallpapers/12_5953_oboi_oboi_so_snezhinkami_1024x768.jpg', password => 'Denis' });
    my @a = [1..10];
    p @a;
    my $tt = Template->new({
               INCLUDE_PATH => './../views',
               EVAL_PERL    => 1,
           });
    Dancer2::Template::TemplateToolkit::process('../views/test.tt', { arr => @a });
};

# hook before => sub {
#     if (!session('user') && request->dispatch_path !~ m {^/login}) {
#         forward '/login', {path => request->path};
#     }
# };

true;
