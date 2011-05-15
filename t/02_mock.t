use strict;
use warnings;
use Test::More;
use Test::Double;

{
    package t::Foo;
    sub new { bless {}, shift }
    sub bar { return 'bar' }
    sub baz { return 'baz' }
}

subtest 'mock()' => sub {
    subtest 'should mock out method with coderef' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->returns(sub { 'BAR' });
        is $foo->bar => 'BAR';
    };

    subtest 'should mock out method without coderef' => sub {
        for ('BAR', 1, [], {}) {
            my $foo = t::Foo->new;
            mock($foo)->expects('bar')->returns($_);
            is $foo->bar => $_;
        }
    };

    subtest 'should not mock out non-target method' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->returns(sub { 'BAR' });
        is $foo->baz => 'baz';
    };

    subtest 'should not effect other instance' => sub {
        my $foo = t::Foo->new;
        my $other = t::Foo->new;
        mock($foo)->expects('bar')->returns(sub { 'BAR' });
        is $other->bar => 'bar';
        my $another = t::Foo->new;
        is $another->bar => 'bar';
    };
};

done_testing;
