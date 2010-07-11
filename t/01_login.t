# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl MediaWiki::Bot.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use Test::More tests => 5;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
use MediaWiki::Bot;

my $username = defined($ENV{'PWPUsername'}) ? $ENV{'PWPUsername'} : 'Perlwikipedia testing';
my $password = defined($ENV{'PWPPassword'}) ? $ENV{'PWPPassword'} : 'test';

my $bot = MediaWiki::Bot->new({
    agent   => 'MediaWiki::Bot tests (01_login.t)',
});

is($bot->login($username, $password), 1, 'Log in');
ok($bot->_is_loggedin(), q{Double-check we're logged in});

my $cookiemonster = MediaWiki::Bot->new();

is ($cookiemonster->login($username), 1, 'Cookie log in');
ok($bot->_is_loggedin(), q{Double-check we're cookie logged in});

my $failbot = MediaWiki::Bot->new({
    agent   => 'MediaWiki::Bot tests (01_login.t)',
    login_data => { username => "Mike's test account", password => '' },
});
is($failbot, undef, 'Auto-login failed');
