#!/usr/bin/perl

use strict;
use warnings;

my $stdin = "true"; # default read from stdin
my $fh;

sub getline;

# if there are arguments, read from file
if( @ARGV )
{
  $stdin = "false";

  open $fh, "<", $ARGV[0];
}

# variables to store the statistics
my $circuitName;
my $testVectorNum;
my $gatesNum;
my $faultNum;
my $detectedFaultNum;
my $undetectedFaultNum;
my $faultCoverage;
# end variables to store the statistics

# main procedure
while( my $line = getline() )
{
  if( $line =~ /reading in circuit (?:[^\/]+\/)*([^\/:]+)\.[^\/]+/ )
  {
    $circuitName = $1;
  }
  if( $line =~ /test vectors =\s*(\d+)/ )
  {
    $testVectorNum = $1;
  }
  if( $line =~ /number of gates =\s*(\d+)/ )
  {
    $gatesNum = $1;
  }
  if( $line =~ /total number of gate faults =\s*(\d+)/ )
  {
    $faultNum = $1;
  }
  if( $line =~ /total number of detected faults =\s*(\d+)/ )
  {
    $detectedFaultNum = $1;
  }
  if( $line =~ /total gate fault coverage =\s*(\d+\.\d+%)/ )
  {
    $faultCoverage = $1;
  }
}
close $fh if( @ARGV );

$undetectedFaultNum = $faultNum - $detectedFaultNum;

print "$circuitName\t$testVectorNum\t$gatesNum\t$faultNum\t$detectedFaultNum\t$undetectedFaultNum\t$faultCoverage\n";
# end main procedure

# interface of reading
sub getline
{
  return <STDIN> if $stdin eq "true";
  return <$fh>;
}
