install:
	cp main.sh /Applications/dsum.sh
	mkdir -p /Library/LaunchAgents/
	sed "s/SSID/$(SSID)/" com.abhiomkar.dsum.plist_tl > com.abhiomkar.dsum.plist
	cp com.abhiomkar.dsum.plist /Library/LaunchAgents/
	mkdir -p "/Library/Application Support/Abhiomkar/Dsum/"
	touch "/Library/Application Support/Abhiomkar/Dsum/dsum.db"
	chmod -R 775 "/Library/Application Support/Abhiomkar/Dsum/"
run:
	launchctl load /Library/LaunchAgents/com.abhiomkar.dsum.plist

stop:
	launchctl unload /Library/LaunchAgents/com.abhiomkar.dsum.plist

uninstall: stop
	rm -f /Applications/dsum.sh
	rm -f /Library/LaunchAgents/com.abhiomkar.dsum.plist
	rm -rf /Library/Application\ Support/Abhiomkar/Dsum/
