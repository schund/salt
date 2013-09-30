iptables-persistent:
  pkg.purged

/etc/iptables.rules:
  file:
  - managed
  - backup: minion
  - user: root
  - group: root
  - mode: 600
  - source: salt://iptables/rules
  - template: jinja
  - context:
    iptables: {{ salt['pillar.get']('iptables') }}

/etc/network/if-pre-up.d/iptables.up.rules:
  file:
  - managed
  - backup: minion
  - user: root
  - group: root
  - mode: 755
  - source: salt://iptables/iptables.up.rules
  - require:
    - file: /etc/iptables.rules

iptables_signal:
    cmd.wait:
    - name: /etc/network/if-pre-up.d/iptables.up.rules
    - watch:
      - file: /etc/iptables.rules
    - require:
      - file: /etc/network/if-pre-up.d/iptables.up.rules
