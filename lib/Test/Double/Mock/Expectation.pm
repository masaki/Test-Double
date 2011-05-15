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
