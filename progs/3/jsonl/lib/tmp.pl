use strict;
use warnings;
use DDP;
use 5.018;
use Local::JSONL qw(decode_jsonl encode_jsonl);
p decode_jsonl(qq<{"a":[1,2,3]}\n{"b":"X\\n"}\n5>);
say encode_jsonl([
         {a => [1, 2, 3]},
         {b => "X\n"},
         4,
     ]);