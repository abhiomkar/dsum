#!/bin/bash
# Author: Abhinay Omkar <abhiomkar@gmail.com>
# http://abhiomkar.in
# Broadband Meter called dsum

echo "Dsum: starting..."
TARGET_SSID=$1
if [ -z $TARGET_SSID ];
then
    echo "Dsum: please specify target SSID (wifi name) while making";
    echo "Dsum: Exits.";
    exit;
fi
DURATION=60
DB_NAME="dsum.db"
DB_PATH="/Library/Application Support/Abhiomkar/Dsum/$DB_NAME"
USER_HOST="$(whoami)_$(hostname)"
function get_ssid () {
    SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -e " SSID:" | awk '{print $2}'`
}

function get_data_iobytes () {
    data_iobytes=`netstat -bi | grep -v Ibytes | grep -v "-" | grep "^en" | awk '{ ibytes += $7 } { obytes += $10 } END { print ibytes,obytes }'`;
    data_received=`echo $data_iobytes | cut -d ' ' -f 1`;
    data_sent=`echo $data_iobytes | cut -d ' ' -f 2`;
}

data_received_delta=0;
data_received_prev=0;

data_sent_delta=0;
data_sent_prev=0;

first_loop=true;

# CREAT TABLE 'DSUM' IF NOT EXISTS
sqlite3 "$DB_PATH" "CREATE TABLE IF NOT EXISTS dsum (id INTEGER PRIMARY KEY AUTOINCREMENT, data_received_delta INTEGER DEFAULT 0, data_sent_delta INTEGER DEFAULT 0, user_host TEXT, ssid TEXT, date TIMESTAMP DEFAULT CURRENT_TIMESTAMP)"

get_data_iobytes;

data_received_prev=$data_received;
data_sent_prev=$data_sent;

sleep $DURATION;

get_data_iobytes;

let data_received_delta=$data_received-$data_received_prev;
let data_sent_delta=$data_sent-$data_sent_prev;

while true; do
    get_ssid;
    if [ $SSID == $TARGET_SSID ];
    then
        sqlite3 "$DB_PATH" "INSERT INTO dsum (data_received_delta, data_sent_delta, ssid, user_host) values ($data_received_delta, $data_sent_delta, \"$SSID\", \"$USER_HOST\")";
        # echo "$USER_HOST $data_received_delta $data_sent_delta";

        get_data_iobytes;
        data_received_prev=$data_received;
        data_sent_prev=$data_sent;

        sleep $DURATION

        get_data_iobytes;
        let data_received_delta=$data_received-$data_received_prev;
        let data_sent_delta=$data_sent-$data_sent_prev;

    else
        sleep $DURATION
    fi
done
