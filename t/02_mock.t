use lib qw(t/lib);
use Test::Double;
use Test::Exception;
use Test::More;
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

    subtest 'with' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->with(1)->returns(2);
        is $foo->bar(1), 2, "with 1";
        verify;

        $foo = t::Foo->new;
        mock($foo)->expects('baz')->with('foo')->returns(2);
        is $foo->baz('foo'), 2, "return 2";
        verify;

        $foo = t::Foo->new;
        my $bar = t::Bar->new;
        mock($foo)->expects('baz')->with($bar)->returns(2);
        is $foo->baz($bar), 2;
        verify;

        $foo = t::Foo->new;
        mock($foo)->expects('baz')->with('foo', 'bar', [1, 2, 3])->returns(2);
        is $foo->baz('foo', 'bar', [1, 2, 3]), 2;
        verify;
    };

    subtest 'at_most' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->at_most(2);
        $foo->bar;
        $foo->bar;
        verify;
    };

    subtest 'times' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->times(2);
        $foo->bar;
        $foo->bar;
        verify;
    };

    subtest 'at least' => sub {
        my $foo = t::Foo->new;
        mock($foo)->expects('bar')->at_least(2)->returns('foo');
        $foo->bar;
        $foo->bar;
        verify;
    };
};

done_testing;
