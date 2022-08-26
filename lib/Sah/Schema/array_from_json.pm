package Sah::Schema::array_from_json;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [array => {
    summary => 'Array, coercible from JSON string',
    'prefilters' => ['JSON::decode_str'],
    description => <<'_',

You can use this schema if you want to accept an array, but if user supplies a
string e.g. in a command-line script as command-line argument or option, the
string will be coerced into array if the string contains a JSON-encoded array.
Data will not be valid if the string does not contain valid JSON.

Note that array data is accepted, unlike the `json_str::array` schema which only
accepts JSON-encoded array in string form.

_
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>'{}', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>[], valid=>1, summary=>'Already an array'},
        {value=>{}, valid=>0, summary=>'Not an array'},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'[1,2,3,{}]', valid=>1, validated_value=>[1,2,3,{}]},
        {value=>'[1,2', valid=>0, summary=>'Missing closing square bracket'},
        {value=>'[1,2,]', valid=>0, summary=>'Dangling comma'},
    ],

}];

1;
# ABSTRACT:
