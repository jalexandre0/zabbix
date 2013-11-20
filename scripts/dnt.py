#!/usr/bin/python
from getpass import getpass
from pyzabbix import ZabbixAPI
ZABBIX_SERVER = 'http://192.168.1.102/zabbix'
zapi = ZabbixAPI(ZABBIX_SERVER)
zapi.login('apiuser', 'apipass')

#Get a hostlist
hostlist = zapi.host.get(output='extend')


for host in hostlist:
    print "Clean not templated items from", host['name']
    itemlist = zapi.item.get(output='extend', filter={"hostid": host['hostid']} )

#Templateid is "0" for non-templated, something else for templated item
    for i in itemlist:
        if i['templateid']  == "0":
            zapi.item.delete(i['itemid'])
            print i['name'], " - deleted"
        else:
            print i['name'], " - preserved"
