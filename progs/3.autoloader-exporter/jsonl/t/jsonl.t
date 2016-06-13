use strict;
use warnings;
use DDP;

use Test::More tests => 2;

use Local::JSONL qw(decode_jsonl encode_jsonl);

is_deeply(
    encode_jsonl([
        {a => [1, 2, 3]},
        {b => "X\n"},
    ]),
    qq<{"a":[1,2,3]}\n{"b":"X\\n"}>,
    'encode JSONL'
);

is_deeply(
    decode_jsonl(
        qq<{"a":[1,2,3]}\n{"b":"X\\n"}>,
    ),
    [
        {a => [1, 2, 3]},
        {b => "X\n"},
    ],
    'decode JSONL'
);
