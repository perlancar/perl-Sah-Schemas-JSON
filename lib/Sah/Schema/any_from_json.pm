package Sah::Schema::any_from_json;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [any => {
    summary => 'A data structure, coerced from JSON string',
    'prefilters' => ['JSON::decode_str'],
    description => <<'_',

You can use this schema if you want to accept any data (a data structure or
simple scalar), but if user supplies a defined string e.g. in a command-line
script as command-line argument or option, the string will be assumed to be a
JSON-encoded value and decoded. Data will not be valid if the string does not
contain valid JSON.

Thus, if you want to supply a string, you have to JSON-encode it.

_
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>1, summary=>"A number"},
        {value=>'null', valid=>1, validated_value=>undef},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal, you have to encode string in JSON'},
        {value=>'"foo"', valid=>0, summary=>'If you want to pass a string, it must be in JSON-encoded form'},
        {value=>'[1,2,3,{}]', valid=>1, validated_value=>[1,2,3,{}]},
        {value=>'[1,2', valid=>0, summary=>'Missing closing square bracket'},
        {value=>'[1,2,]', valid=>0, summary=>'Dangling comma'},
        {value=>[1,2], valid=>1, summary=>'Not coerced, already an array'},
        {value=>{}, valid=>1, summary=>'Not coerced, already a hash'},
        {value=>undef, valid=>1, summary=>'Not coerced, already an undef'},
    ],

}];

1;
# ABSTRACT:
