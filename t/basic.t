use strict;
use warnings;

use Math::Float32 qw(:all);

use Test::More;

cmp_ok($Math::Float32::VERSION, '==', '0.02', "We have Math-Float32-0.02");


done_testing();
