netatalk:
  pkg.installed

/etc/avahi/services/afpd.service:
  file:
    - managed
    - backup: minion
    - source: salt://netatalk/afpd.service
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: netatalk

/etc/netatalk/AppleVolumes.default:
  file:
    - managed
    - backup: minion
    - source: salt://netatalk/AppleVolumes.default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: netatalk

/etc/netatalk/afpd.conf:
  file:
    - managed
    - backup: minion
    - source: salt://netatalk/afpd.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: netatalk

/etc/init.d/netatalk:
  file:
    - managed
    - backup: minion
    - source: salt://netatalk/netatalk.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: netatalk

netatalk_signal:
  cmd.wait:
    - name: '/etc/init.d/netatalk restart'
    - watch:
      - pkg: netatalk
      - file: /etc/netatalk/AppleVolumes.default
      - file: /etc/netatalk/afpd.conf

avahi_signal:
  cmd.wait:
    - name: '/etc/init.d/avahi-daemon restart'
    - watch:
      - pkg: netatalk
      - file: /etc/avahi/services/afpd.service
