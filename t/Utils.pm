package t::Utils;
# only declaration
1;

package t::Foo;
sub new { bless {}, shift }
sub bar { return 'bar' }
sub baz { return 'baz' }

1;
