package Sah::Schema::json_or_str;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [any => {
    summary => 'A JSON-encoded data or string',
    'prefilters' => ['Str::try_decode_json'],
    description => <<'_',

You can use this schema if you want to accept any data (a data structure or
simple scalar), and if user supplies a defined string e.g. in a command-line
script as command-line argument or option, it will be tried to be JSON-decoded
first. If the string does not contain valid JSON, it will be left as-is as
string.

This schema is convenient on the command-line where you want to accept data
structure via command-line argument or option. But you have to be careful when
you want to pass a string like `null`, `true`, `false`; you have to quote it to
`"null"`, `"true"`, `"false"` to prevent it being decoded into undef or
boolean values.

See also related schema: `json_str`, `str::encoded_json`, `str::escaped_json`.

_
    examples => [
        {value=>'', valid=>1, summary=>'Empty string, left as-is as string'},
        {value=>'1', valid=>1},
        {value=>'null', valid=>1, validated_value=>undef, summary=>"JSON-decoded and becomes undef"},
        {value=>'"null"', valid=>1, validated_value=>"null", summary=>"JSON-decoded into string"},
        {value=>'[1,2,3,{}]', valid=>1, validated_value=>[1,2,3,{}], summary=>"JSON-decoded into array"},
        {value=>'[1,2', valid=>1, summary=>'Left as-is as string since it is invalid JSON (missing closing square bracket)'},
        {value=>'[1,2,]', valid=>1, summary=>'Left as-is as string since it is invalid JSON (dangling comma)'},
        {value=>[1,2], valid=>1, summary=>'Not coerced, already an array'},
        {value=>{}, valid=>1, summary=>'Not coerced, already a hash'},
        {value=>undef, valid=>1, summary=>'Not coerced, already an undef'},
    ],

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::json_str>

L<Sah::Schema::str::encoded_json>

L<Sah::Schema::str::escaped_json>
