JsOsaDAS1.001.00bplist00�Vscript_	�function run() {
	openLocation();
}

function openLocation() {

	currentApp = Application.currentApplication();
	currentApp.includeStandardAdditions = true;
	//currentApp.displayAlert("pokrenuto");

	ObjC.import("Cocoa");
	
	se = Application("System Events");
	se.includeStandardAdditions = true;

	var myUrl = se.theClipboard();
	myUrl = decodeURIComponent(myUrl);
	se.setTheClipboardTo(myUrl);
	//currentApp.displayAlert("myURL " + myUrl);
	//$.NSLog("*************** myUrl: %@", myUrl);

	Thunderbird = Application('Thunderbird');
	Thunderbird.activate();

	
	var currentWin = findWindow();	
	while(currentWin == null || !currentWin.visible()) {
		//$.NSLog("*************** currentWin: %@", currentWin);
		delay(0.5);
		currentWin = findWindow();
	} 

	// find process
	var ps = se.processes().filter(function(p) { 
		return p.bundleIdentifier() === 'org.mozilla.thunderbird'; 
	});
		
	ps[0].frontmost = true;
	//$.NSLog("*************** currentWin.index[%@]: %@", currentWin.name(), currentWin.index());
	if(currentWin.index() != 1) {
		//currentWin.index = 1;
		//currentWin.visible = false;
		//currentWin.visible = true;		
		ps[0].menuBars[0].menuBarItems.byName("Window").menus[0].menuItems.byName(currentWin.name()).click()
	}
	//$.NSLog("*************** currentWin.index: %@", currentWin.index());
	se.keystroke("o", {using: ["command down", "option down"]});
	
}

function findWindow() {
	var wins = Application("Thunderbird").windows.whose({_not: [{name: ""}]});
	
	var noWindows = true;
	for(i = 0; i < wins.length; i++) {
		//$.NSLog("*************** win[%@].name: %@", i, wins[i].name());
		var name = wins[i].name().toLowerCase();

		if(name == "")
			continue;
			
		if(name.indexOf("write:") == 0) {
			noWindows = false;
			continue;
		}

		//$.NSLog("*************** return wins[%@] name: %@", i, wins[i].name());
		return wins[i];

	}
	
	// find process
	var se = Application("System Events");
	var ps = se.processes().filter(function(p) { 
		return p.bundleIdentifier() === 'org.mozilla.thunderbird'; 
	});
		
	// start normal window
	if(ps.length > 0) {
		ps[0].frontmost = true;
		se.keystroke("1", {using: ["command down"]});
	}

	//$.NSLog("*************** return wins[] null");
	return null;
}

//openLocation("thunderlink://messageid=55F28A4C.6050609@fer.hr")
//openLocation("thunderlink://messageid%3DVI1PR0802MB22393A9F95BEAEE426181948F5890@VI1PR0802MB2239.eurprd08.prod.outlook.com")
// osascript -il JavaScript                              	�jscr  ��ޭ