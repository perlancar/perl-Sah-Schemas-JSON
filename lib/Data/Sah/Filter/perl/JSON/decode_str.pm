package Data::Sah::Filter::perl::JSON::decode_str;

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
        summary => 'Decode from JSON if string, otherwise leave as-is',
        might_fail => 1,
        examples => [
            {value=>'', valid=>0, summary=>'Empty string is not valid JSON'},
            {value=>'null', filtered_value=>undef},
            {value=>'[1,2,3]', filtered_value=>[1,2,3]},
            {value=>'"foo"', filtered_value=>'foo'},
            {value=>'"foo', valid=>0, summary=>'Invalid JSON, missing closing quote'},
            {value=>{}, summary=>'Not a string, so passed as-is'},
            {value=>undef, summary=>'Not a string, so passed as-is'},
        ],
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{modules}{"JSON::MaybeXS"} = 0;
    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; my \$decoded = !defined(\$tmp) || ref(\$tmp) ? \$tmp : eval { my \$res = JSON::MaybeXS->new->allow_nonref->decode(\$tmp); \$res }; \$@ ? [\"String is not a valid JSON: \$@\", \$tmp] : [undef, \$decoded] }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$
