#!/usr/bin/perl
#	 Script to disable unsuported itens. No funny headers today.
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


use JSON ;
use JSON::RPC::Client ;
use Data::Dumper ;
use strict ;
use warnings ; 

#JSON Authentication and server variables - Adjust for your environment
my ($zabbix, $api_user, $api_passwd) = ("http://zabbix.homelinux/zabbix/api_jsonrpc.php", "apiuser", "apipass" ) ;

#Setting user agent
my $client = new JSON::RPC::Client ;	
$client->ua->credentials("$zabbix", 'Transmission RPC Server', $api_user ) ;

#Setting Authentication 
my	$auth  = {
	jsonrpc  => "2.0",
	method   => "user.authenticate",
	params   => {
		user	 => "$api_user",
		password => "$api_passwd",
  	},
	id => 1,
} ; 

#Execute authentication and retrieve auth string
my $authentication = $client->call($zabbix,$auth);
$auth = $authentication->result ;


my @itemids = item_search($zabbix,$auth,$client) ;
foreach my $itemid  (@itemids) {	
	disable($zabbix, $auth, $client, $itemid) ; 
	print "The item $itemid is now disabled \n"
	}

##Functions 
sub item_search {
	my ($zabbix, $auth, $client) = @_ ;
	my $query	= {	
		jsonrpc => "2.0",
		method  => "item.get",
		params  => {
	   		output => "short",
			filter => {
				status => 3,
			},
		},
		auth => $auth,
		id => 1,
	};
	my $unsup_items = parse($zabbix, $client, $query) ;
    my $total = scalar @{$unsup_items} ;
	print "Found $total items unsupported. \n";  	   
	my @itemids ;
	foreach ( my $count=0 ; $count < $total ; $count++ ) {
        push(@itemids,  @{$unsup_items}[$count]->{"itemid"} ) ;
	}
	return @itemids ;
}	

sub disable {
	my ($zabbix, $auth, $client, $itemid) = @_ ; 
	my $query = { 
		jsonrpc => "2.0",
		method	=> "item.update",
		params  => {
			itemid => $itemid,
			status => 1,
		}, 
	auth => $auth,
	id   => 1,
	};
	parse($zabbix, $client, $query);
}

sub parse {
	my ($zabbix, $client, $query ) = @_ ;
	my $json_query  = $client->call($zabbix,$query);
	my $json_result = $json_query->result ;
	return $json_result ;
}
