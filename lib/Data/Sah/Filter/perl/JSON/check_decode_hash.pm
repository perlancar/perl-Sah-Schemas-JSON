package Data::Sah::Filter::perl::JSON::check_decode_hash;

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
        summary => 'Check that value can be decoded as JSON and it is a hash',
        might_fail => 1,
        examples => [
            {value=>'', valid=>0, summary=>'Empty string is not valid JSON'},
            {value=>'null', valid=>0, summary=>'Valid JSON but not a hash'},
            {value=>'[1,2,3]', valid=>0, summary=>'Valid JSON but not a hash'},
            {value=>'{"a":1}'},
            {value=>'"foo"', valid=>0, summary=>'Valid JSON but not a hash'},
            {value=>'"foo', valid=>0, summary=>'Invalid JSON, missing closing quote'},
            {value=>{}, valid=>0, summary=>'Will become something like "HASH(0x560142d4e5e8)" and fail because it is not valid JSON'},
            {value=>undef, valid=>0, summary=>'Will decode empty string and fail because empty string is not valid JSON'},
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
        "do { my \$tmp = $dt; my (\$decoded, \$ref); eval { \$decoded = JSON::MaybeXS->new->allow_nonref->decode(\$tmp); \$ref = ref \$decoded }; \$@ ? [\"String is not a valid JSON: \$@\", \$tmp] : \$ref && \$ref eq 'HASH' ? [undef, \$tmp] : [\"String is a valid JSON but not an encoded hash\", \$tmp] }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 DESCRIPTION

This is like the
L<JSON::check_decode|Data::Sah::Filter::perl::JSON::check_decode> filter with
the additional check that the decoded value is a hash.
