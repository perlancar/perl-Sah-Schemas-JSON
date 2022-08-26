package Sah::Schema::json_str::hash;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'A string that contains valid JSON and the JSON encodes a hash (JavaScript object)',
    'prefilters' => ['JSON::check_decode_hash'],
    description => <<'_',

This schema is like the `json_str` schema: it accepts a string that contains
valid JSON. The JSON string will not be decoded but you know that the string
contains a valid JSON. In addition to that, the JSON must encode a hash
(JavaScript object). Data will not be valid if it is not a valid JSON or if the
JSON is not a hash.

_
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>'true', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'"foo"', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>'[]', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>'{"a":1,"b":2}', valid=>1},
        {value=>'{"a":1', valid=>0, summary=>'Invalid JSON: missing closing curly bracket'},
        {value=>'{"a":1,}', valid=>0, summary=>'Invalid JSON: dangling comma'},
    ],

}];

1;
# ABSTRACT:
