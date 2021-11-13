if [[ $(hostname) = "Loguetown" || $(hostname) = "Alabasta" || $(hostname) = "TottoLand" ]]; then
#Loguetown/Alabasta dan client lainnya
export http_proxy="http://jualbelikapal.TI14.com:5000/"

elif [[ $(hostname) = "Foosha" ]]; then
#Foosha

echo '# What servers should the DHCP relay forward requests to?
SERVERS="192.218.2.4"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth3 eth2"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay

service isc-dhcp-relay restart

elif [[ $(hostname) = "Jipangu" ]]; then
#Jipangu

echo 'INTERFACES="eth0"' > /etc/default/isc-dhcp-server

echo 'subnet 192.218.1.0 netmask 255.255.255.0 {
    range 192.218.1.20 192.218.1.99;
    range 192.218.1.150 192.218.1.169;
    option routers 192.218.1.1;
    option broadcast-address 192.218.1.255;
    option domain-name-servers 192.218.2.2;
    default-lease-time 360;
    max-lease-time 7200;
}

subnet 192.218.3.0 netmask 255.255.255.0 {
    range 192.218.3.30 192.218.3.50;
    option routers 192.218.3.1;
    option broadcast-address 192.218.3.255;
    option domain-name-servers 192.218.2.2;
    default-lease-time 720;
    max-lease-time 7200;
}

subnet 192.218.2.0 netmask 255.255.255.0 {
}

host Jipangu {
	hardware ethernet 6a:29:cd:ad:5a:db;
	fixed-address 192.218.3.69;
}
'> /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart

elif [[ $(hostname) = "Water7" ]]; then
#Water7

echo '#include /etc/squid/acl.conf

http_port 5000
#http_access allow AVAILABLE_WORKING
visible_hostname Water7

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
http_access allow USERS

acl lan src 192.218.3.0/24 192.218.1.0/24
acl badsites dstdomain google.com
deny_info http://super.franky.TI14.com/ lan
http_reply_access deny badsites lan
dns_nameservers 192.218.2.2
http_access deny all' > /etc/squid/squid.conf

echo 'acl AVAILABLE_WORKING time MTWH 07:00-11:00
acl AVAILABLE_WORKING time TWHF 17:00-23:59
acl AVAILABLE_WORKING time WHFA 00:00-03:00
'> /etc/squid/acl.conf

htpasswd -cbm /etc/squid/passwd luffybelikapalTI14 luffy_TI14
htpasswd -bm /etc/squid/passwd zorobelikapalTI14 zoro_TI14

service squid restart

elif [[ $(hostname) = "EniesLobby" ]]; then
#EniesLobby

echo 'zone "super.franky.TI14.com" {
    type master;
    file "/etc/bind/kaizoku/super.franky.TI14.com";
};

zone "jualbelikapal.TI14.com" {
    type master;
    file "/etc/bind/kaizoku/jualbelikapal.TI14.com";
};' > /etc/bind/named.conf.local

echo 'options {
    directory "/var/cache/bind";
    // forwarders {
    //      0.0.0.0;
    // };
	    
    //dnssec-validation auto;
    allow-query{any;};

    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

mkdir /etc/bind/kaizoku

echo '$TTL    604800
@       IN      SOA     super.franky.TI14.com. root.super.franky.TI14.com. (
                        2021110901      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      super.franky.TI14.com.
@       IN      A       192.218.3.69
www     IN      CNAME   super.franky.TI14.com.
' > /etc/bind/kaizoku/super.franky.TI14.com

echo '$TTL    604800
@       IN      SOA     jualbelikapal.TI14.com. root.jualbelikapal.TI14.com. (
                        2021110901      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      jualbelikapal.TI14.com.
@       IN      A       192.218.2.3
www     IN      CNAME   jualbelikapal.TI14.com.
' > /etc/bind/kaizoku/jualbelikapal.TI14.com

service bind9 restart

elif [[ $(hostname) = "Skypie" ]]; then
#Skypie
mkdir /var/www/super.franky.TI14.com
cd /var/www/super.franky.TI14.com
wget https://github.com/FeinardSlim/Praktikum-Modul-2-Jarkom/raw/main/super.franky.zip -P /var/www/super.franky.TI14.com
unzip /var/www/super.franky.TI14.com/super.franky.zip
mv /var/www/super.franky.TI14.com/super.franky/* /var/www/super.franky.TI14.com
rmdir /var/www/super.franky.TI14.com/super.franky
rm /var/www/super.franky.TI14.com/super.franky.zip

cd /

echo '<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName super.franky.TI14.com
    ServerAlias www.super.franky.TI14.com
    DocumentRoot /var/www/super.franky.TI14.com
    Alias "/js" "/var/www/super.franky.TI14.com/public/js"

    <Directory /var/www/super.franky.TI14.com/public>
    	Options +Indexes
    </Directory>

    <Directory /var/www/super.franky.TI14.com/public/css>
    	Options -Indexes
    </Directory>

    <Directory /var/www/super.franky.TI14.com/public/images>
    	Options -Indexes
    </Directory>

    <Directory /var/www/super.franky.TI14.com/public/js>
    	Options +Indexes
    </Directory>

    ErrorDocument 404 /error/404.html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/super.franky.TI14.com.conf

a2ensite super.franky.TI14.com
a2dissite 000-default
service apache2 restart

fi