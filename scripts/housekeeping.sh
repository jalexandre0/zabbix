#!/bin/bash
#    Manual housekeeping for mediums and large installations
#    running with PostgreSQL, suffering with housekeeping curse. :D
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



#Setting atual date
echo $(date +%d/%m/%Y-%H:%M)

#One year and month ago in Unix Timestamp
ONE_YEAR_AGO=$(expr `date +%s`  - 31536000)
ONE_MONTH_AGO=$(expr `date +%s` -  2678400)

#Queries for one month ago
MONTH_TABLES="history history_uint history_str history_text history_log"
for $table in $MONTH_TABLES 
	do
		DELETES=$( /usr/bin/psql --dbname zabbix -c "delete from $i where  clock < $ONE_MONTH_AGO ;" )
		echo " $DELETES from table $table "
	done



#Queries for one year ago
YEAR_TABLES="alerts trends trends_uint"
for $table in $YEAR_TABLES 
	do
		DELETES=$(/usr/bin/psql --dbname zabbix -c "delete from $i where clock < $ONE_YEAR_AGO ;")
		echo " $DELETE from table $i "
	done

