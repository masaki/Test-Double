package Test::Double;

use strict;
use warnings;
use Exporter qw(import);
use Test::Double::Stub;
use Test::Double::Mock;

our $VERSION = '0.04';
$VERSION = eval $VERSION;

our @EXPORT = qw(stub mock verify reset);

sub stub {
    bless \$_[0], 'Test::Double::Stub';
}

sub mock {
    Test::Double::Mock->wrap($_[0]);
}

sub verify {
    Test::Double::Mock->verify_all;
}

sub reset {
    Test::Double::Mock->reset_all;
}

1;
__END__

=encoding utf-8

=for stopwords

=head1 NAME

Test::Double - Perl extension for Test Double.

=head1 SYNOPSIS

  package Foo;
  sub new { bless {}, shift }
  sub bar { 'bar' }
  
  # in your tests
  use Test::More;
  use Test::Double;
  
  my $foo = Foo->new;
  is $foo->bar, 'bar', 'bar() returns "bar"';
  
  # stub out
  stub($foo)->bar('BAR');
  is $foo->bar, 'BAR', 'stubbed bar() returns "BAR"';
  
  # mock out
  mock($foo)->expects('bar')->returns('BAR');
  is $foo->bar, 'BAR', 'mocked bar() returns "BAR"';

  verify;
  reset;
  
  done_testing;
  
=head1 DESCRIPTION

Test::Double is a Perl extension for Test Double.

=head1 METHODS

=over 4

=item stub($object)

Returns stub object. This object accepts any methods for stubbing
using AUTOLOAD mechanism.

  stub($object)->some_method($expected_value);
  # after, $object->some_method() returns $expected_value

See L<http://xunitpatterns.com/Test%20Stub.html>

=item mock($object)

Returns mock object. This object can be defined expectation
by calling expects() method.

  mock($object)->expects('some_method');
  # after, $object->some_method() returns $expected_value

See L<Test::Double::Mock>

=item verify

Verify how many times method calling, and method calling with what args .

=item reset

Reset mocking objects.

=back

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<http://xunitpatterns.com/Test%20Double.html>

L<Test::Stub>, L<Class::Monadic>

=cut
