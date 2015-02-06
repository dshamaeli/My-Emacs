If you want to use Emacs to edit your JavaScript files there are some packages which could make it more powerful. I will make a linux installation file for it one day, but since then you have to do the labor yourself. However even God didnt give Noah a ship for free!!.

Installation for Ubuntu 14.04:

Requirements: you should have git,node(0.10.35),tern (should have been installed at "/usr/bin/tern" or you have to configure it manually. more info at http://ternjs.net/doc/manual.html#emacs) and of course Emacs24 ( I use version 24.4.1) installed.

step 1: if there is a ~/.emacs file in your home directory you should remove it so emacs use ~/.emacs.d/init.el for initiation.

step 2:	first clone this repository to your computer:

	$ git clone https://github.com/dshamaeli/My-Emacs.git ~/.emacs.d

Step 3: now Install ternjs the dependencies:

	$ cd ~/.emacs.d/tern
	$ npm install

for more information about tern goto http://ternjs.net/doc/manual.html#emacs
If you want the latest tern version remove /tern and clone directly from tern website but you have to do an extra step:
	
Extra step:	do this step only if you have cloned tern from ternjs.net 
to set tern auto complete key map to CTRL-TAB add this line to keymap section in ~/.emacs.d/tern/emacs/tern.el
	
		(define-key tern-mode-keymap [(control tab)] 'completion-at-point)
		  
you have to do this manually until Mr Marijn Haverbeke (Geat man and Author of Eloquent JavaScript and tern) answers my pull request in github
	

cautionary Step: Make sure that node is added to your path or tern package wont work 



Step 4: In you project directory Create .tern-project file with format like this:

	{
	  "libs": [
	    "browser",
	    "jquery"
	  ],
	  "plugins": {
	    "node": {},
	    "angular": {}
	  }
	}

not:see http://ternjs.net/doc/manual.html#configuration for more info.

Step 5: Now Start Emacs. It will load packages automatically. You could use "emacs --debug-init" if you get any error.

	$ emacs

Step 6: By default Yasnippet dosent work with JS3-mode but we can simply fix it by:

	$ cd ~/.emacs.d/elpa/yasnippet-     #use tab for auto compelete
	$ cd snippets/
	$ cp -r js2-mode/ js3-mode

step 7: to test it open a new .js file with your emacs:
	
	type > log
	press (shit+TAB) and what yasnippet could Do. Great!!!! isnt it?
	type > docu
	press (Ctrl+TAB) and see what tern could do.
	type > document.
	now you see that (.) invokes tern auto complete. Who needs Webstorm any more??????
	I think combine with yo,grunt,bower and other tools emacs could become a very good tool for javascript developers

Further reading:

I have learned a lot about Emacs configuration from http://www.aaronbedra.com/emacs.d/
Also Read more abut tern at http://ternjs.net

Thank you for your time
May the force be with you	
 

