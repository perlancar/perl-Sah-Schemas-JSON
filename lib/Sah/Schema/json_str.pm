package Sah::Schema::json_str;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'A string that contains valid JSON',
    'prefilters' => ['JSON::check_decode'],
    description => <<'_',

This schema can be used if you want to accept a string that contains valid JSON.
The JSON string will not be decoded (e.g. a JSON-encoded array will not beome an
array) but you know that the string contains a valid JSON. Data will not be
valid if the string does not contain valid JSON.

_
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>1},
        {value=>'true', valid=>1},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'"foo"', valid=>1, summary=>'A JSON-encoded string'},
        {value=>'[1,2,3,{}]', valid=>1},
        {value=>'[1,2', valid=>0, summary=>'Missing closing square bracket'},
        {value=>'[1,2,]', valid=>0, summary=>'Dangling comma'},
    ],

}];

1;
# ABSTRACT:
