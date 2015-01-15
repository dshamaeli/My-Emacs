Sorry If I write this in English (which is not good enough), But it seems google groups text editor has some problem with bilingual (Persian and English) sentences and miss places some words. I also needed a README for my github,so why dont kill two birds with one stone?

preface:
  
If you want to use Emacs to edit your JavaScript files there are some packages which could make it more powerful. I will make a linux installation file for it no day, but since then you have to do the labor yourself. However even God didnt give Noah a ship for free!!.

Installation for Ubuntu 14.04:

note: you need to have git,node(0.10.35),npm( and of course Emacs24 ( I use 24.4.1) installed.

step 1: if there is a ~/.emacs file in your home directory you should remove it

step 2:	first clone My-Emacs repository to your computer:

	$ git clone https://github.com/dshamaeli/My-Emacs.git ~/.emacs.d

Step 3: now Install ternjs the dependencies:

	$ cd ~/.emacs.d/tern
	$ npm install

	for more information about tern goto http://ternjs.net/doc/manual.html#emacs
	If you want the latest tern version remove /tern and clone directly from tern website but you have to do an extra step:
	
Extra step:	do this step only if you have cloned tern from ternjs.net 
		to set tern auto complete key map to CTRL-TAB add this line to keymap section in ~/.emacs.d/tern/emacs/tern.el
	
		(define-key tern-mode-keymap [(control tab)] 'completion-at-point)
		  
		you have to do this manually until Mr Marijn Haverbeke answers my pull request in github
	

cautionary Step: Make sure that node is added to your path or tern package wont work 

Step 4: By default Yasnippet dosent work with JS3-mode but we can simply fix it by:

	$ cd ~/.emacs.d/elpa/yasnippet-     #use tab for auto compelete
	$ cd snippets/
	$ cp -r js2-mode/ js3-mode

Step 4: Now Start Emacs. It will load packages automatically. You could use "emacs --debug-init" if you get any error.
	remember that with our shity internet speed in Iran this could take few minutes
	$ emacs

step 5: to test it open a new .js file with your emacs:
	
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
 

