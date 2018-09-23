#!/usr/bin/perl

use strict;
use warnings;

my $stdin = "true";
my $fh;

sub getline;

if( @ARGV )
{
  $stdin = "false";

  open $fh, "<", $ARGV[0];
}

my $testVectorNum;
my $gatesNum;
my $faultNum;
my $detectedFaultNum;
my $undetectedFaultNum;
my $faultCoverage;

while( my $line = getline() )
{
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

print "$testVectorNum $gatesNum $faultNum $detectedFaultNum $undetectedFaultNum $faultCoverage\n";

sub getline
{
  return <STDIN> if $stdin eq "true";
  return <$fh>;
}
