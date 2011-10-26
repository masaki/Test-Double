use strict;
use warnings;
use Test::More;
use Test::Memory::Cycle;
use Test::Double;
use t::Utils;

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
        my $another = t::Foo->new;

        is $foo->bar => 'BAR';
        is $other->bar => 'bar';
        is $another->bar => 'bar';
    };

    subtest 'should not have memory leaks' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->returns(1);

        memory_cycle_ok $foo;
    };
};

done_testing;
