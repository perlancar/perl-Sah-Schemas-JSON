package Sah::Schema::json_str::array;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'A string that contains valid JSON and the JSON encodes an array',
    'prefilters' => ['JSON::check_decode_array'],
    description => <<'_',

This schema is like the `json_str` schema: it accepts a string that contains
valid JSON. The JSON string will not be decoded but you know that the string
contains a valid JSON. In addition to that, the JSON must encode an array. Data
will not be valid if it is not a valid JSON or if the JSON is not an array.

_
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>'true', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'"foo"', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>'{}', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>'[1,2,3,{}]', valid=>1},
        {value=>'[1,2', valid=>0, summary=>'Invalid JSON: missing closing square bracket'},
        {value=>'[1,2,]', valid=>0, summary=>'Invalid JSON: dangling comma'},
    ],

}];

1;
# ABSTRACT:
