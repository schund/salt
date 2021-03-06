Salt Stack Examples
===================

This Repository contains some Examples on how to use Salt Stack.

Learn more about Salt Stack on their Website: http://saltstack.org

All States will install certain Software and configures it on as many "Minions" (Clients) you like.

States
======

In the "states"-Directory you will find the following examples:

* netatalk

Shows how to install Software depending on each other and configure multiple Files at once. Shows also how to Restart needed services if configuration has been changed.


* drbd

Shows the Installation and Configuration of Software if every config file has the same content on all targeted Minions.

* corosync

Shows how to use "grains" to get the IP-Address from "eth0" on the respective Minion. And how to use this Information in an "Jinja"-Template.


* nginx

Installs and configures "nginx" and "PHP" with "php5-mysql". Shows the usage of Modules.

* munin

Installs and configure "munin-node" on all Minions and "munin" on a Monitor-Machine. The State will use the "SaltMine-Feature" which enables a Minion to get informations about other Minions. The State also shows some "advanced" Jinja-Functions.

* iptables

Configures iptables using Pillar informations. Use a pillar to define which Services or Interfaces you want to configure. Example:

```
iptables:
  input:
    - xenbr1
  forward:
    - xenbr1
  ports:
    - 443
  ssh:
    - 1.2.3.4
    - 2.3.4.5
```

This will enable all INPUT and FORWARDING-Traffic on the Interface "xenbr1", it also enables Traffic on all interfaces on Port 443 (HTTPS). SSH will be allowed from the listed IPs.
