Description
-----------
Broadband Meter (Codename Dsum). Records Data Received / Data Sent (in Bytes)
periodically to a persistent database.

Initial requirement from my roomies `:-)` on who is downloading how much `;-)`

Code for Fun!

Installation
------------

[Download](https://github.com/abhiomkar/dsum/zipball/master) the code.

Unzip the file and change the directory to unzipped folder

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
Currently this script works only on Mac OS X (10.4 or Later)

sqlite3

command to install sqlite3:

    brew install sqlite3

Uninstall
---------

    sudo make uninstall

