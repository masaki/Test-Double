package Test::Double::Stub;

use strict;
use warnings;
use Class::Monadic ();

our $AUTOLOAD;
sub AUTOLOAD {
    my $name = [ split /::/, $AUTOLOAD ]->[-1];
    return if $name eq 'DESTROY';

    my $self = shift;
    my $stub = shift || sub {};
    my $func = ref($stub) eq 'CODE' ? $stub : sub { $stub };
    Class::Monadic->initialize($$self)->add_methods($name => $func);

    return $self;
}

1;
__END__
