corosync:
  pkg.installed

pacemaker:
  pkg.installed

/etc/default/corosync:
  file:
    - managed
    - source: salt://cluster/default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: corosync

/etc/corosync/corosync.conf:
  file:
    - managed
    - source: salt://cluster/corosync.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      bind: {{ salt['grains.get']('ip_interfaces:eth0') }}
    - require:
      - pkg: corosync

corosync_signal:
  service:
    - name: corosync
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: corosync
      - file: /etc/default/corosync
      - file: /etc/corosync/corosync.conf
