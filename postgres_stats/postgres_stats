#!/usr/bin/perl 
#    A script to collect and print various metrics for PostgreSQL database. The 
#	 primary intent is use in conjunction with Zabbix NMS, but you're free to use what 
#	 you want.
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
#    This work is based on Zabbix Template Collection < http://trac.greenmice.info/ztc/ >
#    from Vladimir Rusinov, and on work of "bashman" user in zabbix forum < http://www.zabbix.com/forum/showthread.php?t=8009 >

use DBI;
use warnings;
use strict;

my  ( $fetch, $dbname ) = @_ ;
my  $dbuser = "postgres";

unless ($fetch ) {
			help_message();
			exit 1;				 
}

unless( $dbname ) {
	$dbname = "postgres"; 
}

#Connecting to the database. See man DBD::Pg for more help
my $dbh = DBI->connect("dbi:Pg:dbname=$dbname", "$dbuser", ); 

my %options = (
	'server_process'        => ( "SELECT SUM(numbackends) FROM pg_stat_database" ),
	'locks'                 => ( "SELECT COUNT(*) FROM pg_locks" ),
	'connections_total'     => ( "SELECT COUNT(*) FROM pg_stat_activity" ),
	'connections_idle'      => ( "SELECT COUNT(*) FROM pg_stat_activity WHERE current_query = '<IDLE>'" ),
	'connections_idle_tnx'  => ( "SELECT COUNT(*) FROM pg_stat_activity WHERE current_query = '<IDLE> in transaction'" ),	
	'connections_waiting'   => ( "SELECT COUNT(*) FROM pg_stat_activity WHERE waiting<>'f'" ),
	'buffers_clear'         => ( "SELECT COUNT(*) FROM pg_buffercache WHERE isdirty='f'" ),
	'buffers_dirty'         => ( "SELECT COUNT(*) FROM pg_buffercache WHERE isdirty='t'" ),
	'buffers_used'          => ( "SELECT COUNT(*) FROM pg_buffercache WHERE reldatabase IS NOT NULL " ),
	'buffers_total'         => ( "SELECT COUNT(*) FROM pg_buffercache" ),
	'blocks_hit'            => ( "SELECT SUM(blks_hit) FROM pg_stat_database" ),  
	'blocks_read'           => ( "SELECT SUM(blks_read) FROM pg_stat_database" ),
	'commits'               => ( "SELECT SUM(xact_commit) FROM pg_stat_database" ),
	'rollbacks'             => ( "SELECT SUM(xact_rollback) FROM pg_stat_database" ),
	'tuples_deleted'        => ( "SELECT SUM(tup_deleted) FROM pg_stat_database" ),
	'tuples_inserted'       => ( "SELECT SUM(tup_inserted) FROM pg_stat_database" ),
	'tuples_returned'       => ( "SELECT SUM(tup_returned) FROM pg_stat_database" ),
	'tuples_updated'        => ( "SELECT SUM(tup_updated) FROM pg_stat_database" ),
	'tuples_fetched'        => ( "SELECT SUM(tup_fetched) FROM pg_stat_database" ),
	'size'                  => ( "SELECT SUM(pg_database_size(datid)) as total_size FROM pg_stat_database" ), 
	'max_idle_tnx'          => ( "SELECT EXTRACT (EPOCH FROM MAX(age(NOW(), query_start))) as d FROM pg_stat_activity WHERE current_query='<IDLE> in transaction'" ),
	'max_running_tnx'       => ( "SELECT EXTRACT (EPOCH FROM MAX(age(NOW(), query_start))) \
				                 as d FROM pg_stat_activity WHERE current_query<>'<IDLE> in transaction' AND current_query<>'<IDLE>'" ),
	'wall_files'            => ( "SELECT COUNT(*) FROM pg_ls_dir('pg_xlog') WHERE pg_ls_dir ~ E'^[0-9A-F]{24}\$'" ),
	'hit_ratio'             => ( "SELECT CAST(blks_hit/(blks_read+blks_hit+0.000001)*100.0 as numeric(5,2)) as cache FROM pg_stat_database where datname = '$dbname'"),
	'db_blocks_hit'         => ( "SELECT SUM(blks_hit) FROM pg_stat_database where datname = '$dbname' " ), 
	'db_blocks_read'        => ( "SELECT SUM(blks_read) FROM pg_stat_database where datname = '$dbname'" ),
	'db_commits'            => ( "SELECT SUM(xact_commit) FROM pg_stat_database where datname = '$dbname'" ),
	'db_rollbacks'          => ( "SELECT SUM(xact_rollback) FROM pg_stat_database where datname = '$dbname'" ),
	'db_tuples_deleted'     => ( "SELECT SUM(tup_deleted) FROM pg_stat_database where datname = '$dbname'" ),
	'db_tuples_inserted'    => ( "SELECT SUM(tup_inserted) FROM pg_stat_database where datname = '$dbname'" ),
	'db_tuples_returned'    => ( "SELECT SUM(tup_returned) FROM pg_stat_database where datname = '$dbname'" ),
	'db_tuples_updated'     => ( "SELECT SUM(tup_updated) FROM pg_stat_database where datname = '$dbname'" ),
	'db_tuples_fetched'     => ( "SELECT SUM(tup_fetched) FROM pg_stat_database where datname = '$dbname'" ),
	'db_size'               => ( "SELECT (pg_database_size('$dbname'))" ),
);

return_row($dbh->prepare($options{$fetch}));

sub return_row {
	my ($result) = @_ ;
	$result->execute();
	my @row = ($result->fetchrow_array);
	print "@row \n" ;
}

sub help_message {
	print " You should pass one valid parameter: \n";  
	print " $0 server_process       - Total conections in server processes \n";
	print " $0 locks                - Total number of used locks  \n";
	print " $0 connections_total    - Total number of listeners \n";
	print " $0 connections_idle     - Number of connections in idle stat \n";
	print " $0 connections_idle_tnx - Number of connections idle in trasaction \n";
	print " $0 connections_waiting  - Number of connections waiting \n";
	print " $0 buffers_clear        - Number of buffers clear \n";
	print " $0 buffers_dirty        - Number of buffers dirty \n";
	print " $0 buffers_used         - Number of buffers used \n";
	print " $0 buffers_total        - Total number of buffers \n";
	print " $0 blocks_hit           - Total Number of blocks hit \n";
	print " $0 blocks_read          - Total Number of blocks read in disk  \n";
	print " $0 commits              - Total number of commits \n";
	print " $0 rollbacks            - Total number of rollbacks\n";
	print " $0 tuples_deleted       - Total number of tuples deleted \n";
	print " $0 tuples_inserted      - Total number of tuples inserted \n";
	print " $0 tuples_returned      - Total number of tuples returned \n";
	print " $0 tuples_updated       - Total number of tuples updated \n";
	print " $0 tuples_fetched       - Total number of tuples fetched \n";
	print " $0 size                 - Sum of size of all databases \n"; 
	print " $0 max_idle_tnx         - Max time for transaction in idle state, in seconds \n ";
	print " $0 max_running_tnx      - Max time of running transaction, in seconds \n";
	print " $0 wall_files           - Total number of wall files \n";
	print " $0 hit_ratio [dbname]   - Hit ratio for postgres database, if anyone specified \n";
	print " $0 db_blocks_hit dbname       - Number of blocks hit for specified database  \n";
	print " $0 db_blocks_read dbname      - Number of blocks read in disk for specified database\n";
	print " $0 db_commits dbname          - Number of commits for specified database \n ";
	print " $0 db_rollbacks  dbname       - Number of Rollbacks for specified database \n";
	print " $0 db_tuples_deleted dbname   - Number of tuples deleted  for specified database \n";
	print " $0 db_tuples_inserted  dbname - Number of tuples inserted for specified database \n";
	print " $0 db_tuples_returned dbname  - Number of tuples returned for specified database \n";
	print " $0 db_tuples_updated dbname   - Number of tuples returned for specified database \n";
	print " $0 db_tuples_fetched db_name  - Number of tuples fetched  for specified database \n";
	print " $0 db_size                    - Size of specified database \n";
	print " If you want more, take a look at \"http://www.postgresql.org/docs/9.0/interactive/monitoring-stats.html\" \n";
}

