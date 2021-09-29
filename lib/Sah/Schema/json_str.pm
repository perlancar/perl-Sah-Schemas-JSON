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
    examples => [
        {value=>'', valid=>0, summary=>'Empty string'},
        {value=>'1', valid=>1},
        {value=>'true', valid=>1},
        {value=>'foo', valid=>0, summary=>'Not a valid JSON literal'},
        {value=>'[1,2,3,{}]', valid=>1},
        {value=>'[1,2', valid=>0, summary=>'Missing closing square bracket'},
        {value=>'[1,2,]', valid=>0, summary=>'Dangling comma'},
    ],

}];

1;
# ABSTRACT:
