# This state add the Minon to the Munin-Monitoring on the monitor-Machine.
#
# IMPORTANT: Inactive Minions will be removed from monitoring. They will be
# added again if they are up on the next state execution.
#
# To make this State work, you need to enable the Salt-Mine-Feature by
# putting to following into you Minion-Configuration (/etc/salt/minion):
#
# mine_functions:
#   test.ping []
#   grains.items []
#
# This will allow a Minion to read Grains from other Minions. This is needed
# so that monitor.example.com can read the FQDN/IP from the monitored Minions
# (see munin.conf for Details)

{% if salt['grains.get']('fqdn') == 'monitor.example.com' %}
munin:
  pkg:
    - installed

/etc/munin/munin.conf:
  file:
  - managed
  - source: salt://munin/munin.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: munin

munin_signal:
  cmd.wait:
  - name: /etc/init.d/munin restart
  - watch:
    - pkg: munin
    - file: /etc/munin/munin.conf
{% else %}
munin-node:
  pkg:
  - installed

/etc/munin/munin-node.conf:
  file:
  - managed
  - source: salt://munin/munin-node.conf
  - template: jinja
  - context:
    hostname: {{ salt['grains.get']('fqdn') }}
  - backup: minion
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: munin-node

munin_signal:
  cmd.wait:
  - name: /etc/init.d/munin-node restart
  - watch:
    - pkg: munin-node
    - file: /etc/munin/munin-node.conf
{% endif %}
