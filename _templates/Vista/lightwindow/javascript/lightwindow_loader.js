// LightWindowLoader: a LightWindow helper library
//
// Use this library to add LightWindow to your web site. In addition to the standard
// LightWindow library this one has special code to detect if the current page has 
// been loaded into an iframe / frame. If such a situation is detected, the 
// LightWindow library is loaded into the most outer window object and initialized
// with the links from the current content frame.
// The effect will be, that the LightWindow overlay is spanned not only within the 
// frame but over the whole window as one would expect it.
// The script loads itself only if not already loaded by someone else. It does also 
// load the necessary CSS and other JS libraries (Prototype and Effect) if they are
// already loded
//
// Requires prototype.js, effect.js and lightwindow.js in the following directories:
//
// javascript/prototype.js
// javascript/effect.js
// javascript/lightwindow.js
// javascript/lightwindow_loader.js
// css/lightwindow.css
// images/*
//
// Make sure that the directories are exactly like this, this library loads everything
// relative to it's own path.
//
// Lightwindow:
// ============
// LightWindow is a wonderfull library written by Kevin P Miller from 
// http://www.stickmanlabs.com. 
// This LightWindowLoader uses the standard distribution with only one little modification:
// the image paths that are hard-coded in LightWindow are set using a variable that is
// triggered by this script. When you update to a newer LightWindow version, make sure
// you add "lw_base_path" to the library.
//
// Usage:
// ======
// Embedd this script in the header of your page: note the DOM ID's on the elements, they
// they are relevant:
// <!-- JavaScript -->
// <script type="text/javascript" src="javascript/prototype.js" id="lwloader_prototype_js"></script>
// <script type="text/javascript" src="javascript/effects.js" id="lwloader_effects_js"></script>
// <script type="text/javascript" src="javascript/embedd_lightwindow.js" id="lwloader"></script>
//
// Credits:
// ========
// 30. Juni 2008
// Florian Gnägi, 
// http://www.frentix.com

if(typeof Prototype == 'undefined')
  throw("lightwindowloader.js requires including of prototype.js library!");

var LightWindowLoader = Class.create();	
LightWindowLoader.prototype = {
	// The detected browser window
	win : null,
	// Helper method to load a js or a css file
	_loadjscssfile : function(filename){
		var filetype = filename.substring(filename.lastIndexOf('.') + 1);
		var elemId = 'lwloader_' + filename.substring(filename.lastIndexOf('/') + 1, filename.lastIndexOf('.')) + '_' + filetype;
		if (this.win.$(elemId) != null) {
			//console.log('this._loadjscssfile(' + filename + ', ' + filetype + ', ' + this.win + ') ::' + elemId + ' already loaded');		
			return;
		}
		//console.log('this._loadjscssfile(' + filename + ', ' + filetype + ', ' + this.win + ') ::' + elemId + ' loading now');	
		 if (filetype=='js'){
		 	// can't use beautiful prototype style here, maybe not yet loaded!
			var fileref=this.win.document.createElement('script');
			fileref.setAttribute('type','text/javascript');
  			fileref.setAttribute('src', filename);
  			fileref.setAttribute('id', elemId);  
  			this.win.document.getElementsByTagName("head")[0].appendChild(fileref)			
		} else if (filetype=='css'){
			var link=this.win.document.createElement('link');
			link.setAttribute('type','text/css');
  			link.setAttribute('href', filename);
  			link.setAttribute('id', elemId);  
  			link.setAttribute('rel', 'stylesheet');
  			this.win.document.getElementsByTagName("head")[0].appendChild(link)			
		}
	},
	
	// Method to initialize LightWindow in the main window after all onload method have been executed
	_initLightWindowInMainWindow : function() {
		// Only initialize when loaded in iframe
		if (window != this.win) {
			// Set timeout=0 to execute after current stack (after onload of the ifame has finished)
			// This is necessary to have the correct document height on the main window
			setTimeout(this._initLightWindowInMainWindowDeferred.bind(this), 0);
		}				
		// else : initialized by LightWindow itself
	},
	
	// Method to initialize LightWindow and add all LightWindow links to the light window 
	// object in the main window. 
	_initLightWindowInMainWindowDeferred : function() {
		//console.log('_initLightWindowInMainWindowDeferred()' + this.win.name);
		try {
			// Remove old LightWindow elements from DOM first...
			if (this.win.$('lightwindow_overlay')) this.win.$('lightwindow_overlay').remove();
			if (this.win.$('lightwindow')) this.win.$('lightwindow').remove();
			// ... and then initialize LightWindow object
			this.win.lightwindowInit();
			// Reset galleries that was initialized in lightwindowInit() but with the main window links...
			this.win.myLightWindow.galleries = new Array();
			// Get all LightWindow links from the current document and add it to lightWindow object in the main window
			var links = $$('.lightwindow');
			links.each(function(link) {
				// Add handler to all links and load galleries in main window
				//console.log('initLinks link:' + link.href + ' win.myLightWindow='+ win.myLightWindow	);
				this._processLink(link);
			}.bind(this.win.myLightWindow));			
		} catch(e) {
			console.log(this.win.name + " " + e.message);
		}
	},
	
	// Load the light window code and it's necessary libraries to this window 
	// or the parent window
	initialize : function() {
		// Find the outer most window element in this browser window 
		this.win = window;
		while(this.win != this.win.parent) {
			this.win = this.win.parent;
			// don't follow parents that are in another browser window
			if (opener != null) break;
		}	
		// Calculate base path for lightWindow scripts
		var scriptPath = $('lwloader').src;		
		scriptPath = scriptPath.substring(0,scriptPath.lastIndexOf('javascript/lightwindow_loader.js'));
		var lwBaseUri = scriptPath;
		// FF does return a fully qualified URL while IE baby does return a relative URL
		// We can't use the relative URL since the loading process of the libraries does 
		// happen in the parent window which has another base URL. Loading must thus happen
		// absolute. Get the absolute URL from the window location in case the URL is relative
		if (!scriptPath.startsWith('http') && !scriptPath.startsWith('file://')) {
			var docPath = window.location + '';
			docPath = docPath.substring(0, docPath.lastIndexOf('/')+1);
			lwBaseUri = docPath + scriptPath;
		}
		//console.log('initialize() ' + lwBaseUri + ' this.win.name=' + this.win.name);
		// load necessary libraries
		if (typeof this.win.Prototype == 'undefined') {
			this._loadjscssfile(lwBaseUri + 'javascript/prototype.js');
		}
		if (typeof this.win.Effect == 'undefined') {
			this._loadjscssfile(lwBaseUri + 'javascript/effects.js');
		}
		// add light window image path variables in the main window
		this.win.lw_base_path = lwBaseUri;
		if (typeof this.win.lightwindow == 'undefined') {
			this._loadjscssfile(lwBaseUri + 'css/lightwindow.css');
			this._loadjscssfile(lwBaseUri + 'javascript/lightwindow.js');
		}
		// Initialize the light window links in the main window. 
		// If the window is our current window, LightWindow will initialize the 
		// the links itself and this step is not necessary
		if (window != this.win) {
			// bind as event listener to make this keyword work...
			Event.observe(window, 'load', this._initLightWindowInMainWindow.bind(this), false);

		}		
	}	
}

// Initialize everything
var	lwLoader = new LightWindowLoader();