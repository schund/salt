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

Pillars
=======

In the "pillar"-Directory you will find some example of States using "pillar"-Data. (It's empty at the moment, though.)
