SetTitleMatchMode, RegEx ; match part of title



; ================ A-Z HOTKEYS

; #a RESERVED action center
^#a::LookupSelection("https://www.amazon.es/s/field-keywords=~s~") ; look up on Amazon.es
^#+a::LookupSelection("https://www.amazon.com/s/field-keywords=~s~") ; look up on Amazon.com

; #b available

#c::Run % "chrome.exe --app=https://mail.google.com/mail/?view=cm&fs=1&tf=1 --disable-extensions" ; gmail compose

; #d RESERVED desktop

; #e RESERVED explorer
^#e:: ; edit AutoHotKey script
  Run "C:\Users\herb\AppData\Local\Programs\Microsoft VS Code\Code.exe" C:\git\ahk-scripts\
Return

#f::Run dl ; dynalist
^#f::AddToDynalist() 

#g::Run daily ; dynalist log
^#g::LookupSelection("http://www.google.com/search?q=~s~") ; look up on Google

#h::Run devgit ; github

; #i RESERVED settings

#j:: run schtasks /run /TN "750"

; #k RESERVED quick connect

; #l RESERVED lock

; #m available
; #n available
; #o available

; #p RESERVED project screen
^#p::Run chrome.exe --profile-directory=Default --app-id=pmcngklofgngifnoceehmchjlildnhkj ; Google Contacts

#q::Run trans ; Google Translate

; #r RESERVED run
^#r::Reload  ; reload AutoHotKey script

#s::AddShortcut()

#t::AddAsanaTask() 

#u::CopyBrowserURL()
^#u::CopyMarkdownLink()

^!#u::WinGetActiveTitle, Clipboard ; Will copy the title of the Active Window to clipboard
; ^!#u::WinGetClass, Clipboard, A ; Will copy the ahk_class of the Active Window to clipboard

; ^+v RESERVED Ditto 
^+!v::PastePlainText()
^#v::Run vault ; LastPass Vault

#w::Run whatsapp 

^#w::LookupSelection("http://en.wikipedia.org/wiki/Special:Search?search=~s~") ; look up in Wikipedia
^#+w::LookupSelection("https://github.com/DevResults/DevResults/search?q=~s~&type=Wikis") ; look up in DevResults wiki

; #x RESERVED quick link

; #y available

#z:: Run "C:/Users/herb/AppData/Roaming/Zoom/bin/zoom.exe"
^#z::Run https://cloudsearch.google.com/cloudsearch?authuser=0


; ================ OTHER HOTKEYS

#space::
  Run chrome.exe --new-window ; new browser window
  WinActivate, "New Tab" 
Return

^#space:: ; cycle through input keyboard
  PostMessage WM_INPUTLANGCHANGEREQUEST:=0x50, INPUTLANGCHANGE_FORWARD:=0x2,,, % (hWndOwn := DllCall("GetWindow", Ptr, hWnd:=WinExist("A"), UInt, GW_OWNER := 4, Ptr)) ? "ahk_id" hWndOwn : "ahk_id" hWnd
Return

#F1::Run chrome.exe --app=https://devdocs.io/ ; devdocs

#=::Run calc.exe ; calculator

^#1::Run teams ; google team drives
#!1::Run gdl ; my drive (online)
^#!1::Run teamsl ; google team drives (online)

^#2::LookupSelection("https://mail.google.com/mail/ca/u/0/#search/~s~") ; search email



; disable insert keys
$Insert::return
!Insert::Send, {Insert} ; Use Alt+Insert to toggle the 'Insert mode'

; For Alt + key (with NumLock OFF)
NumpadIns::Ins
NumpadEnd::End
NumpadDown::Down
NumpadPgDn::PgDn
NumpadLeft::Left
NumpadClear::
NumpadRight::Right
NumpadHome::Home
NumpadUp::Up
NumpadPgUp::PgUp
NumpadDel::Del

; ================ APPLICATION SPECIFIC

; allow paste to command window
#IfWinActive ahk_class ConsoleWindowClass
  ^v::
  SendInput {Raw}%clipboard%
  return
#IfWinActive

; Easy ways to minimize WhatsApp
; (for use with WhatsAppTray, which keeps it running in the background)
; https://github.com/D4koon/WhatsappTray/releases
#IfWinActive, WhatsApp
  !F4::WinMinimize
  ^W::WinMinimize
  Esc::WinMinimize
#IfWinActive 

; auto-reload when editing ahk
#IfWinActive ahk-scripts
  ^s::
    sleep, 200
    Reload
  return
#IfWinActive 


; ================ FUNCTIONS

CopyBrowserURL() {
  ; copy active browser URL
  sURL := GetActiveBrowserURL()
  If (sURL != "")
    clipboard = %sURL%
  Else
    WinGetClass, Clipboard, A
}

CopyMarkdownLink() {
  sURL := GetActiveBrowserURL()
  If (sURL != "") 
  {
    WinGetActiveTitle, Title
    link := "[" . Title . "](" . sURL . ")"
    clipboard = %link%
  }
}

PastePlainText()  {
  clipboard = %clipboard% ;  convert clipboard contents to plain text only
  send ^v
  return
}

; create shortcut to chrome window or to folder
AddShortcut() {
  ; adapt these to your situation
  BrowserPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
  ShortcutDirectory := "G:\My Drive\Shortcuts\Win10"

  If WinActive("ahk_class CabinetWClass")	; folder
  {	
    Send ^l ; Select the address textbox
    WinClip.Copy()
    InputBox, UserInput, Shortcut Name,Please enter a name for this folder shortcut: `n%Clipboard%,,350,150 
    If (!ErrorLevel and UserInput <> "")
      FileCreateShortcut, %Clipboard%, %ShortcutDirectory%/%UserInput%.lnk, 
  }
  Else If WinActive("ahk_class Chrome_WidgetWin_1") ; chrome
  {
    sURL := GetActiveBrowserURL()
    InputBox, UserInput, Shortcut Name,Please enter a name for this Chrome app shortcut: `n%sURL%,,350,150 
    If (!ErrorLevel and UserInput <> "")
      FileCreateShortcut, %BrowserLocation%, %ShortcutDirectory%/%UserInput%.lnk, , --app=%sURL%
  }
  Else Return
}

AddAsanaTask() {
  IniRead AsanaToken, Secrets.ini, Asana, Token
  IniRead AsanaWorkspace, Secrets.ini, Asana, Workspace
  InputBox, UserInput, Task,Enter a task to add to Asana:,,350,125 
  If (!ErrorLevel and UserInput <> "")
  {
    UserInput := UriEncode(UserInput)
    Run curl -H "Authorization: Bearer %AsanaToken%" https://app.asana.com/api/1.0/tasks -d "name=%UserInput%" -d "workspace=%AsanaWorkspace%" -d "assignee=me" --insecure
  }
}
 

AddToDynalist() {
  IniRead DynalistToken, Secrets.ini, Dynalist, Token
  InputBox, UserInput, Task,Add to Dynalist inbox:,,350,125 
  If (!ErrorLevel and UserInput <> "")
  {
    ; UserInput := UriEncode(UserInput)
    URL := "https://dynalist.io/api/v1/inbox/add"
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("POST", URL, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    Body := "{ ""token"": """ . DynalistToken . """, ""content"": """ . UserInput . """, ""checked"": false }"
    HttpObj.Send(Body)
    Result := HttpObj.ResponseText
    Status := HttpObj.Status
  }
}
 
LookupSelection(url) {
  WinClip.Copy()
  url := StrReplace(url, "~s~", Clipboard)
  Run % url
}
