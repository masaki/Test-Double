package Test::Double::Mock::Expectation;

use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    bless {
        behavior => sub {},
        %args,
        called   => 0,
    }, $class;
}

sub with {
    my ($self, @args) = @_;
    # TODO: implements
    $self;
}

sub returns {
    my ($self, $behavior) = @_;
    if (defined $behavior) {
        $self->{behavior} = ref($behavior) eq 'CODE' ? $behavior : sub { $behavior };
    }
    $self;
}

sub behavior {
    my $self = shift;
    return sub {
        # TODO: should record method call
        $self->{called}++;
        return $self->{behavior}->();
    };
}

sub verify {
    my $self = shift;
    # TODO: implements
    0;
}

1;
__END__

=encoding utf-8

=for stopwords

=head1 NAME

Test::Double::Mock::Expectation - Mock expectation object

=head1 METHODS

=over 4

=item with(@args)

Assigns expected callee arguments.

=item returns($expected_value_or_subref)

Assigns expected returning value or subroutine reference.

=item verify

Verify this expectation.

=back

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Test::Double>, L<Test::Double::Mock>

=cut
