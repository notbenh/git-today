#!/usr/bin/env perl 
use strict;
use warnings;
use Getopt::Std;
require POSIX;

=head1 USEAGE

  git today [options] [paths]

    -h : help
    -s $since : INT number of days to look back, default is 1 (ie yesterday)

=cut
    # TODO I really don't wanna do the branchie solution that was done in the zsh solution as its not really compatable with user filtering
    #-u $user : restrict diff to a specific user 

our ($opt_h,$opt_u,$opt_s);
$opt_s='1'; # default
getopts('hu:s:');

exit system 'perldoc', __FILE__ if $opt_h;

my $date = POSIX::strftime('%x', localtime( ( time() - ( 24 * 60 * 60 ) * int($opt_s) ) ) );

my $since_sha = qx{git log --before='$date' --format='%H' -n1};
chomp $since_sha;

system qw{git diff}, $since_sha, @ARGV;

