
use strict;
use utf8;
use Test::More tests => 11;
use Test::Requires;

test_requires 'YAML::XS';
test_requires 'Config::Any';

use_ok "Data::Localize";

my $loc = Data::Localize->new();
$loc->add_localizer(
    class => "MultiLevel",
    paths => [ 't/08_multilevel/*.yml' ],
);

{
    $loc->set_languages('en');
    is( $loc->localize( 'hello_world' ), 'Hello, World!', "hello_world (en)" );
    is( $loc->localize( 'greetings.hello', { name => 'John Doe' } ), 'Hello, John Doe', "greetings.hello (en)" );
    is( $loc->localize( 'greetings.morning', { name => 'John Doe' } ), 'Good morning, John Doe', "greetings.morning (en)" );
    is( $loc->localize( 'greetings.afternoon', { name => 'John Doe' } ), 'Good afternoon, John Doe', "greetings.afternoon (en)" );
    is( $loc->localize( 'greetings.evening', { name => 'John Doe' } ), 'Good evening, John Doe', "greetings.evening (en)" );
}

{
    $loc->set_languages('ja', 'en');
    is( $loc->localize( 'hello_world' ), 'こんにちは、世界！', "hello_world (ja)" );
    is( $loc->localize( 'greetings.hello', { name => 'John Doe' } ), 'こんにちは、 John Doe', "greetings.hello (ja)" );
    is( $loc->localize( 'greetings.morning', { name => 'John Doe' } ), 'おはよう、 John Doe', "greetings.morning (ja)" );
    is( $loc->localize( 'greetings.afternoon', { name => 'John Doe' } ), 'こんにちは、 John Doe', "greetings.afternoon (ja)" );
    is( $loc->localize( 'greetings.evening', { name => 'John Doe' } ), 'こんばんは、 John Doe', "greetings.evening (ja)" );
}

