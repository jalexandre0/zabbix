SACI plugin for [zabbix] [1]
==============================

If you want Zabbix opening and closing tickets through [OTRS] [2] api, you want
install and test SACI plugin. 

**SACI** is resulted from need of integration between these great open source tools.

To make a multi scenario plugin, I'm using AppConfig perl module. 
If you can't or dont want install AppConfig perl module, , you can hack the SACI 
to make options hardcoded. 

Well, to make this magic works:

1. Install `SOAP::LITE`, `Data::Dumper` and `AppConfig` perl modules (distribution packages or by CPAN, your call here! )

2. Configure all saci variables and test using follow commands:

    *PROBLEM* and *OK* are your trigger subject given by zabbix {TRIGGER.STATUS) macro.

    The body of trigger must be *{HOSTNAME}:{TRIGGER.NAME}*.

    ```` bash
    $ perl saci saci.conf PROBLEM hostname trigger_name 
    $ perl saci saci.conf OK hostname trigger_name
    ````
 
3. Configure Zabbix Media to use saci script.

4. Configure your user to use saci media, and use the path for config path in 'send to' field.

5. Configure the actions and be happy. =)


[1]: http://zabbix.com "Zabbix"
[2]: http://otrs.org "OTRS"
