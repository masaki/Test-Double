use lib qw(t/lib);
use Test::Simple::Catch;
use Test::More;
use Test::Double;
use t::Utils;

my($out, $err) = Test::Simple::Catch::caught();
Test::Builder->new->no_header(1);
Test::Builder->new->no_ending(1);
my $TB = Test::Builder->create;
$TB->plan(tests => 14);

subtest 'verify faile' => sub {
    subtest 'with' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->with(1)->returns(2);
        $foo->bar(2);
        verify;
        $TB->like($out->read,
                  qr/not ok 1 - Expected method must be called with 1/);
        $TB->like($err->read,
                  qr/Failed test 'Expected method must be called with 1'/);

        reset;

        $foo = t::Foo->new;
        mock($foo)->expects('baz')->with('foo')->returns(2);
        $foo->baz;
        verify;
        $TB->like($out->read,
                  qr/not ok 2 - Expected method must be called with foo/);
        $TB->like($err->read,
                  qr/Failed test 'Expected method must be called with foo'/);

        $foo->baz(3);
        verify;
        $TB->like($out->read,
                  qr/not ok 3 - Expected method must be called with foo/);
        $TB->like($err->read,
                  qr/Failed test 'Expected method must be called with foo'/);

        $foo->baz('foo', 3);
        verify;
        $TB->like($out->read,
                  qr/not ok 5 - Expected method must be called with foo/);
        $TB->like($err->read,
                  qr/Failed test 'Expected method must be called with foo'/);
        reset;
    };

    subtest 'at_most' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('baz')->at_most(2)->returns('foo');
        $foo->baz;
        $foo->baz;
        $foo->baz;
        verify;
        $TB->like($out->read,
                  qr/not ok 1 - Expected method must be called at most 2/);
        $TB->like($err->read,
                  qr/Failed test 'Expected method must be called at most 2'/);
        reset;
    };

    subtest 'times' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('baz')->times(2)->returns('foo');
        $foo->baz;
        verify;
        $TB->like($out->read,
                  qr/not ok 1 - Expected method must be called 2 times/);
        $TB->like($err->read,
                  qr/Failed test 'Expected method must be called 2 times'/);
        reset;
    };

    subtest 'at least' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('baz')->at_least(2)->returns('foo');
        $foo->baz;
        verify;
        $TB->like($out->read,
                  qr/not ok 1 - Expected method must be called at least 2/);
        $TB->like($err->read,
                  qr/Failed test 'Expected method must be called at least 2'/);
        reset;
    };
};

done_testing;
