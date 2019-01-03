#!/usr/bin/perl
# random password generator
# accepts a length as an argument, or empty assumes 10

use strict;

my $length = 10;
my $type = "medium";
my $times = 5;

my $i;
for ( $i = 0; $i <= $#ARGV; $i ++ ) {
  # loop through each argument

  # if a number, change the length
  if ( $ARGV[ $i ] =~ /^\d+$/ ) {
    if ( $ARGV[ $i ] > 6 ) {
      $length = $ARGV[ $i ];
    }
  }

  # if word, change the params
  if ( $ARGV[ $i ] =~ /^s/ ) {
    $type = "strong";
  } elsif ( $ARGV[ $i ] =~ /^m/ ) {
    $type = "medium";
  } elsif ( $ARGV[ $i ] =~ /^l/ ) {
    $type = "light";
  }
}

if ( $ARGV[0] eq "" ) {
  print "No arguments specified. Defaulting to strength \"$type\" and length $length\n";
  print "\n";
}

# make a password

for ( $i = 1; $i <= $times; $i ++ ) {

  if ( $type eq "strong" ) {
    print `strings /dev/urandom | grep -o '[[:print:]]' | head -n $length | tr -d '\n '; echo `;
  } elsif ( $type eq "medium" ) {
    print `strings /dev/urandom | tr -dc '1234567890!@#$%abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' | head -c $length ; echo `;
  } elsif ( $type eq "light" ) {
    print `strings /dev/urandom | tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c $length ; echo `;
  }

}
