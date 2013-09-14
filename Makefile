# Hating TAB, WTB spaces

clean: cleanFirefox cleanChrome

cleanFirefox:
	@rm -rf build/firefox

cleanChrome:
	@rm -rf build/chrome

firefox: cleanFirefox
	@mkdir build/firefox
	@mkdir build/firefox/data
	@mkdir build/firefox/lib
	
	coffee -bcj build/firefox/lib/main.js src/firefox/lib/browser.coffee src/shared/main.coffee
	coffee -bc -o build/firefox/data src/shared/popup.coffee
	coffee -bc -o build/firefox/data src/shared/contentscript.coffee
	@cp src/firefox/package.json build/firefox/

	@cp README.md build/firefox
	@cp src/shared/popup.html build/firefox/data
	@cp src/shared/icon*.png build/firefox/data

	@cd build/firefox;cfx run --binary-args ../../src/shared/test.html

chrome:	cleanChrome
	@mkdir build/chrome

	@cp -r src/chrome/_locales build/chrome/_locales
	@cp src/chrome/manifest.json build/chrome

	@cp src/shared/popup.html build/chrome
	@cp src/shared/icon*.png build/chrome

	coffee -bc -o build/chrome src/shared/contentscript.coffee
	coffee -bc -o build/chrome src/shared/popup.coffee 
	coffee -bcj build/chrome/main.js src/chrome/browser.coffee src/shared/main.coffee

test:
	@coffee src/shared/test.coffee
