package Sah::Schema::hash_from_json;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [hash => {
    summary => 'Hash, coerced from JSON string',
    'prefilters' => ['JSON::decode'],
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>'[]', valid=>0, summary=>'Valid JSON but not a hash'},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'{}', valid=>1, validated_value=>{}},
        {value=>'{"a":1,"b":2}', valid=>1, validated_value=>{a=>1,b=>2}},
        {value=>'{"a":1,"b":2', valid=>0, summary=>"Missing closing curly bracket"},
    ],

}];

1;
# ABSTRACT:
