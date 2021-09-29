package Data::Sah::Filter::perl::JSON::decode;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => 'Decode from JSON',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{modules}{"JSON::MaybeXS"} = 0;
    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; my \$decoded; eval { \$decoded = JSON::MaybeXS->new->allow_nonref->decode(\$tmp) }; \$@ ? [\"String is not a valid JSON: \$@\", \$tmp] : [undef, \$decoded] }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$
