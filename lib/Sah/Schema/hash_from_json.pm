package Sah::Schema::hash_from_json;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [hash => {
    summary => 'Hash, coerced from JSON string',
    'prefilters' => ['JSON::decode_str'],
    description => <<'_',

You can use this schema if you want to accept a hash, but if user supplies a
string e.g. in a command-line script as command-line argument or option, the
string will be coerced into hash if the string contains a JSON-encoded object
(hash). Data will not be valid if the string does not contain valid JSON.

_
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>'[]', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>{}, valid=>1, summary=>'Already a hash'},
        {value=>[], valid=>0, summary=>'Not a hash'},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'{}', valid=>1, validated_value=>{}},
        {value=>'{"a":1,"b":2}', valid=>1, validated_value=>{a=>1,b=>2}},
        {value=>'{"a":1,"b":2', valid=>0, summary=>"Missing closing curly bracket"},
    ],

}];

1;
# ABSTRACT:
