package Sah::Schema::array_from_json;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [array => {
    summary => 'Array, coerced from JSON string',
    'prefilters' => ['JSON::decode'],
    examples => [
        {value=>'', valid=>0, summary=>'Empty string is not a valid JSON'},
        {value=>'1', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>'{}', valid=>0, summary=>'Valid JSON but not an array'},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'[1,2,3,{}]', valid=>1, validated_value=>[1,2,3,{}]},
        {value=>'[1,2', valid=>0, summary=>'Missing closing square bracket'},
        {value=>'[1,2,]', valid=>0, summary=>'Dangling comma'},
    ],

}];

1;
# ABSTRACT:
