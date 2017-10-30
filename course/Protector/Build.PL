use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'DBHandler',
    license             => '2017 Denis Dorozhkin',
    dist_author         => q{Denis Dorozhkin (DoubleDi) <DDenis1.ru>},
    dist_version_from   => 'lib/DBHandler.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => '0',
    },
    build_requires => {
        'Test::More' => '0',
    },
    requires => {
        #'ABC'              => '1.6',
        #'Foo::Bar::Module' => '5.0401',
    },
    add_to_cleanup     => [ 'Protector-*' ],
);

$builder->create_build_script();
