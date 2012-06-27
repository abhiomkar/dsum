Installation
------------
Install (`my-wifi-name` is your SSID - WIFI Name)
    
    sudo make install SSID=my-wifi-name

Run
    sudo make run

Stop
    sudo make stop

Usage
-----
Total Data Received (in MB)
    sqlite3 /Library/Application\ Support/Abhiomkar/Dsum/dsum.db "select SUM(data_received_delta)/(1024.0*1024.0) from dsum"

Total Data Sent (in MB)
    sqlite3 /Library/Application\ Support/Abhiomkar/Dsum/dsum.db "select SUM(data_sent_delta)/(1024.0*1024.0) from dsum"

Total Data Received Today (in MB)
    sqlite3 /Library/Application\ Support/Abhiomkar/Dsum/dsum.db "select SUM(data_received_delta)/(1024.0*1024.0) from dsum where strftime('%Y-%m-%d', DATETIME(date, 'localtime'))=strftime('%Y-%m-%d', 'now')"

Total Data Received in Last One Hour (in MB)
    sqlite3 /Library/Application\ Support/Abhiomkar/Dsum/dsum.db "select SUM(data_received_delta)/(1024.0*1024.0) from dsum where DATETIME(date, 'localtime') >= DATETIME('now', 'localtime', '-1 hours')"

Dependencies
------------
sqlite3

command to install sqlite3:
    brew install sqlite3

Uninstall
---------
    sudo make uninstall

