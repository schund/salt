nginx:
  pkg.installed

php5-fpm:
  pkg.installed

php5-mysql:
  pkg.installed

/etc/nginx/sites-available/default:
  file:
    - managed
    - backup: minion
    - source: salt://nginx/default
    - user: www-data
    - group: www-data
    - mode: 664
    - require:
      - pkg: nginx

/etc/php5/fpm/php-fpm.conf:
  file:
    - managed
    - backup: minion
    - source: salt://nginx/php-fpm.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
      - pkg: php5-fpm

/etc/php5/fpm/pool.d/www.conf:
  file:
    - managed
    - backup: minion
    - source: salt://nginx/www.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
      - pkg: php5-fpm

/etc/php5/fpm/php.ini:
  file:
    - managed
    - backup: minion
    - source: salt://nginx/php.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
      - pkg: php5-fpm

nginx_configtest:
  module.wait:
    - name: nginx.configtest
    - watch:
      - file: /etc/nginx/sites-available/default
      - pkg: nginx

nginx_signal:
  cmd.wait:
    - name: '/etc/init.d/nginx reload'
    - watch:
      - pkg: nginx
      - file: /etc/nginx/sites-available/default
      - module.run: nginx_configtest

php5-fpm_signal:
  cmd.wait:
    - name: '/etc/init.d/php5-fpm restart'
    - watch:
      - pkg: php5-fpm
      - file: /etc/php5/fpm/php-fpm.conf
      - file: /etc/php5/fpm/pool.d/www.conf
      - file: /etc/php5/fpm/php.ini
