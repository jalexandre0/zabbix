The 'Another [Zabbix][1] Interface Administration'
==================================================

**Azia** is the acronym for 'Another Zabbix Interface Administration',
but you can use 'Armoured Zombies Initiating Assault' or 'Adventure
Zork is Amazing'. Zombies and Zork have your own role in a SysAdmins life, 
but Zabbix are fun (and very important) in your own way. ;)

The primary function of azia is provide access to Zabbix using unix environment.
You can add, list or remove things using the unix shell. Have a non interactive 
cli is important to create and improve routines of maintenance and monitoring.

You'll need provide an user and password for Zabbix API, support for executing
perl scripts and [`ZabbixAPI.pm`][2] and [`JSON`][3] and [`LWP::UserAgent`][4] modules.

`JSON` and `LWP::UserAgent` can be obtained by [`CPAN`] [5] or your unix package management.

The `ZabbixAPI.pm` can be fetched from [Mikeda's] [6] github repository in:

After install modules, adjust your configuration file. 

If you don't pass the configuration file parameter with -c flag, the script
will look at /etc/azia.conf file. 


Note: azia is brazilian portuguese for 'heartburn'.
Note2: I really wish thanks Mikeda for doing my work really easy. 
Note3: I really like the "Armoured Zombies Initiating Assault" acronhym.

[1]: http://zabbix.com "Zabbix"
[2]: https://github.com/mikeda/ZabbixAPI.git "ZabbixAPI.pm"
[3]: http://search.cpan.org/~makamaka/JSON-2.53/lib/JSON.pm "JSON"
[4]: http://search.cpan.org/~gaas/libwww-perl-6.02/lib/LWP/UserAgent.pm "LWP"
[5]: http://www.cpan.org/ "CPAN"
[5]: https://github.com/mikeda "Mikeda repository"


