chrome := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
code := "C:\Program Files\Microsoft VS Code\code.exe"
curl := "C:\Program Files\curl\amd64\curl.exe"


; ================ WIN


RWin Up::Send {AppsKey Up} ; right Windows key: context menu

#space::Run %chrome% ; new chrome window

#F1::Run %chrome% --app=http://devdocs.io/ ; devdocs

#`::Run sticky ; stickies

#=::Run calc.exe ; calculator

#c::Run %chrome% --app=https://mail.google.com/mail/?view=cm&fs=1&tf=1 --disable-extensions ; gmail compose

#f::Run wf ; workflowy

#g::Run log ; workflowy log

#s:: ; create shortcut to chrome window or to folder
	If WinActive("ahk_class CabinetWClass")	; folder
	{	
		Send ^l ; Select the address textbox
		WinClip.Copy()
		InputBox, UserInput, Shortcut Name,Please enter a name for this folder shortcut: `n%Clipboard%,,350,150 
		If (!ErrorLevel and UserInput <> "")
			FileCreateShortcut, %Clipboard%, \Win10\%UserInput%.lnk, 
	}
	Else If WinActive("ahk_class Chrome_WidgetWin_1") ; chrome
	{
		sURL := GetActiveBrowserURL()
		InputBox, UserInput, Shortcut Name,Please enter a name for this Chrome app shortcut: `n%sURL%,,350,150 
		If (!ErrorLevel and UserInput <> "")
			FileCreateShortcut, %chrome%, G:\My Drive\Shortcuts\Win10\%UserInput%.lnk, , --app=%sURL%
	}
	Else Return
Return

#t:: ; add task to Asana
	; NOTE: AsanaToken and AsanaWorkspace need to be defined in Secrets.ahk
	; AsanaToken := 0/1234567890asdf1234567890asfd ; (Account Settings/Apps/API Key)
	; AsanaWorkspace := 9999999999999 
	InputBox, UserInput, Task,Enter a task to add to Asana:,,350,125 
	If (!ErrorLevel and UserInput <> "")
	{
		UserInput := UriEncode(UserInput)
		Run %curl% -H "Authorization: Bearer %AsanaToken%" https://app.asana.com/api/1.0/tasks -d "name=%UserInput%" -d "workspace=%AsanaWorkspace%" -d "assignee=me" --insecure
	}
Return

#u:: ; copy active browser URL
	sURL := GetActiveBrowserURL()
	If (sURL != "")
		clipboard = %sURL%
Return

#v:: ; connect to VPN
	run rasphone "devresults-azure" -d
	sleep, 1000 
	send {ENTER}
	sleep, 1000 
	send {ENTER}
	sleep, 10000 
	send {ESC}
Return

#w::Run wa ; whatsapp


; ================ CTRL-WIN

^#2:: ; search email
	WinClip.Copy()
	Run https://inbox.google.com/search/%Clipboard%
Return

^#a:: ; look up on Amazon
	WinClip.Copy()
  Run https://www.amazon.es/s/field-keywords=%Clipboard%
Return

^#e::Run %code% "G:\My Drive\Settings\AutoHotKey\AHK.ahk"

^#g:: ; look up in Google
	WinClip.Copy()
  Run http://www.google.com/search?q=%Clipboard%
Return

^#r::Reload  ; reload AutoHotKey script

^#w:: ; look up in Wikipedia
	WinClip.Copy()
  Run http://en.wikipedia.org/wiki/Special:Search?search=%Clipboard% 
Return


^#+w:: ; look up in devresults wiki
	WinClip.Copy()
  Run https://github.com/DevResults/DevResults/search?q=%Clipboard%&type=Wikis
Return


; ================ OTHER

; disable insert keys
$Insert::return
!Insert::Send, {Insert} ; Use Alt+Insert to toggle the 'Insert mode'

; allow paste to command window
#IfWinActive ahk_class ConsoleWindowClass
^V::
SendInput {Raw}%clipboard%
return
#IfWinActive


; WIN KEY REFERENCE

; KEEP:
; #A action center
; #. or #; emoji
; #D desktop
; #!D date/time
; #^D add virtual desktop
; #E explorer
; #I settings
; #K quick connect
; #L lock
; #P projector
; #R run
; #X quick link
; #^F4 close virtual desktop
; #tab task view

; AVAILABLE:
; #, desktop peek
; #B focus in notification area
; #C cortana
; #+C charms
; #F feedback hub
; #^F network search
; #G game bar
; #H dictation
; #J focus tip
; #M minimize all
; #+M restore minimized
; #O lock device orientation
; #S search
; #T cycle through taskbar
; #U ease of use center
; #V cycle through notifications
; #+V cycle through notifications backwards
; #Y windows mixed reality
; #Z show commands in full-screen mode
; #^enter narrator
; #space input language/keyboard layout
