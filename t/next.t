use strict;
use warnings;
use Math::Float32 qw(:all);

use Test::More;


my $nan = Math::Float32->new();
cmp_ok( (is_flt_nan($nan)), '==', 1, "new obj is NaN");

flt_nextabove($nan);
cmp_ok( (is_flt_nan($nan)), '==', 1, "next above NaN is NaN");

flt_nextbelow($nan);
cmp_ok( (is_flt_nan($nan)), '==', 1, "next below NaN is NaN");

my $pinf = Math::Float32->new();

flt_set_inf($pinf, 1);
cmp_ok( (is_flt_inf($pinf)), '==', 1, "+inf is inf");

flt_nextbelow($pinf);
cmp_ok( (is_flt_inf($pinf)), '==', 0, "next below +inf is not inf");
cmp_ok( $pinf, '==', $Math::Float32::flt_NORM_MAX , "next below +inf is 3.402823466e+38");

flt_nextabove($pinf);
cmp_ok( (is_flt_inf($pinf)), '==', 1, "next above 3.402823466e+38 is inf");

my $pmin = $Math::Float32::flt_DENORM_MIN;
cmp_ok($pmin, '==', '1.401298464e-45', "+min is 1.401298464e-45");

flt_nextbelow($pmin);
cmp_ok($pmin, '==', 0, "next below +min is zero");
cmp_ok( (is_flt_zero($pmin)), '==', 1, "next below +min is unsigned zero");

flt_nextabove($pmin);
cmp_ok($pmin, '==', $Math::Float32::flt_DENORM_MIN, "next above zero is DENORM_MIN");

my $ninf = -$pinf;
cmp_ok( (is_flt_inf($ninf)), '==', -1, "inf is -inf");

flt_nextabove($ninf);
cmp_ok( (is_flt_inf($ninf)), '==', 0, "next above -inf is not inf");
cmp_ok( $ninf, '==', -$Math::Float32::flt_NORM_MAX , "next above -inf is -NORM_MAX");

flt_nextbelow($ninf);
cmp_ok( (is_flt_inf($ninf)), '==', -1, "next below -3.39e38 is -inf");

my $nmin = -$pmin;

flt_nextabove($nmin);
cmp_ok($nmin, '==', 0, "next above -min is zero");
#cmp_ok( (is_flt_zero($nmin)), '==', -1, "next above -min is -0"); # may fail

flt_nextbelow($nmin);
cmp_ok($nmin, '==', -$Math::Float32::flt_DENORM_MIN, "next below zero is -DENORM_MIN");

my $zero =Math::Float32->new(0);

#for(127 .. 133) { $max_subnormal += 2 ** -$_ }
my $max_subnormal = $Math::Float32::flt_DENORM_MAX;
cmp_ok($max_subnormal, '==', '1.175494211e-38', "DENORM_MAX is 1.175494211e-38");

flt_nextabove($max_subnormal);
cmp_ok($max_subnormal, '==', $Math::Float32::flt_NORM_MIN, "next above max subnormal is NORM_MIN");

flt_nextbelow($max_subnormal);
cmp_ok($max_subnormal, '==', $Math::Float32::flt_DENORM_MAX, "next below NORM_MIN is DENORM_MAX");

my $neg_normal_min = -$Math::Float32::flt_NORM_MIN;
flt_nextabove($neg_normal_min);
cmp_ok($neg_normal_min, '==', -$Math::Float32::flt_DENORM_MAX, "next above -NORM_MIN is -DENORM_MAX");

my $min        = Math::Float32->new("$Math::Float32::flt_DENORM_MIN");
my $cumulative = Math::Float32->new("$Math::Float32::flt_DENORM_MIN");

#my @p = ($cumulative);
#my $n = 2 ** (flt_MANTBITS - 1);
#$n--;
#for(1..$n) {
#   $cumulative += $min;
#   push (@p, $cumulative);
#}
#
#my $check = Math::Float32->new(0);
#
#for(0..$n) {
#  flt_nextabove($check);
#  cmp_ok($check, '==', $p[$_], "$_: as expected ($p[$_])");
#}
#
#flt_nextbelow($check);
#cmp_ok($check, '==', $Math::Float32::flt_DENORM_MAX, "DENORM_MAX as expected");
#
#flt_nextbelow($check);
#cmp_ok($check, '==', $Math::Float32::flt_DENORM_MAX - $Math::Float32::flt_DENORM_MIN, "DENORM_MAX - DENORM_MIN as expected");
#
#flt_set_zero($check, 1);
#
#for(0..$n) {
#  flt_nextbelow($check);
#  cmp_ok($check, '==', -$p[$_], "$_: as expected (-$p[$_])");
#}
#
#flt_nextabove($check);
#cmp_ok($check, '==', -$Math::Float32::flt_DENORM_MAX, "-DENORM_MAX as expected");
#
#flt_nextabove($check);
#cmp_ok($check, '==', -$Math::Float32::flt_DENORM_MAX + $Math::Float32::flt_DENORM_MIN, "-DENORM_MAX + DENORM_MIN as expected");

done_testing();
