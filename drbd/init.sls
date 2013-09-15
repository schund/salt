drbd8-utils:
  pkg.installed

/etc/drbd.conf:
  file:
    - managed
    - source: salt://drbd/drbd.conf
    - backup: minion
    - user: root
    - group: root
    - mode: 664
    - require:
        - pkg: drbd8-utils

drbd_signal:
  cmd.wait:
    - name: '/etc/init.d/drbd reload'
    - watch:
      - file: /etc/drbd.conf

