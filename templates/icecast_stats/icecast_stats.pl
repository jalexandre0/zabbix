#!/usr/bin/perl 
# Script to parse and print Icecast stats xml file.
#
#    Copyright (C) <2011>  <Jefferson Alexandre dos Santos>, <jefferson.alexandre [at] gmail [dot] com> 
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

use XML::Simple;
use Data::Dumper;
use strict ;
use warnings ;

my $result = XMLin("/tmp/icecast_stats.xml",KeyAttr => {source => "+mount"});
my ($mount_point, $option ) = @ARGV ;

if ( $mount_point eq "global" ) {
	print $result->{$option} . "\n" ; }
elsif ( $mount_point and $option ) { 
	print $result->{source}->{$mount_point}->{$option} . "\n" ; }
elsif ($mount_point eq "debug" ) {
	print  Dumper($result). "\n" ; } 

unless ($mount_point)  { 
print "Usage instructions:" . "\n"; 
print "$0 global listeners              -> Obtain global listeners number" . "\n" ; 
print "$0 global listener_connections   -> Obtain global listeners_connections number" . "\n" ; 
print "$0 /mountpoint listeners         -> Obtain mountpoint listeners number" . "\n" ; 
print "$0 /mountpoint peak_listeners    -> Obtain mountpoint peak_listener number" . "\n" ; 
print "$0 debug                         -> Show the parsed XML file. Useful to see all values allowed ;)" . "\n" ; } 
