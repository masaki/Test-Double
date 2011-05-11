package Test::Double;

use strict;
use warnings;

our $VERSION = '0.01';
$VERSION = eval $VERSION;

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

  stub($foo)->bar('BAR');
  is $foo->bar, 'BAR', 'stubbed bar() returns "BAR"';
  
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

=back

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<http://xunitpatterns.com/Test%20Double.html>

=cut

