SetTitleMatchMode, RegEx ; match part of title



; ================ A-Z HOTKEYS



; #a RESERVED action center
^#a::LookupSelection("https://www.amazon.es/s/field-keywords=~s~") ; look up on Amazon.es
^#+a::LookupSelection("https://www.amazon.com/s/field-keywords=~s~") ; look up on Amazon.com

; #b available

#c::OpenAsApp("https://mail.google.com/mail/?view=cm&fs=1&tf=1") ; gmail compose

; #d RESERVED desktop

; #e RESERVED explorer
^#e:: ; edit AutoHotKey script
  Run Code.exe C:\git\ahk-scripts\
Return

#f::OpenAsApp("https://dynalist.io/d/wJjFYPPE2QlKg-1VCcbx1Y4A#z=root") ; dynalist inbox
^#f::AddToDynalist() 

#g::OpenAsApp("https://dynalist.io/d/XIvRzfLVBvr_UNNdpLn0fmgh#z=root") ; dynalist daily
^#g::LookupSelection("http://www.google.com/search?q=~s~") ; look up on Google

#h::OpenAsApp("https://github.com/HerbCaudill?tab=repositories") ; github

; #i RESERVED settings

#j:: run schtasks /run /TN "750" ; journal  

; #k RESERVED quick connect

; #l RESERVED lock

; #m available
; #n available
; #o available

; #p RESERVED project to screen
^#p::Run chrome.exe --profile-directory=Default --app-id=pmcngklofgngifnoceehmchjlildnhkj ; Google Contacts

#q::OpenAsApp("http://translate.google.com/translate_t") ; Google Translate
^#q::LookupSelection("https://translate.google.com/#view=home&op=translate&sl=en&tl=es&text=~s~") ; look up translation

; #r RESERVED run
^#r::Reload  ; reload AutoHotKey script

#s::AddShortcut()

#t::AddAsanaTask() 

#u::CopyBrowserURL()
^#u::CopyMarkdownLink()

; ^!#u::WinGetActiveTitle, Clipboard ; Will copy the title of the Active Window to clipboard
^!#u::WinGetClass, Clipboard, A ; Will copy the ahk_class of the Active Window to clipboard

; ^+v RESERVED Ditto 
^+!v::PastePlainText()
#v::Run vault ; LastPass Vault

#w::Run "C:\Users\herb\AppData\Local\WhatsApp\WhatsApp.exe" 

^#w::LookupSelection("http://en.wikipedia.org/wiki/Special:Search?search=~s~") ; look up in Wikipedia
^#+w::LookupSelection("https://github.com/DevResults/DevResults/search?q=~s~&type=Wikis") ; look up in DevResults wiki

; #x RESERVED quick link

#y::Run "C:\Users\herb\AppData\Local\hyper\Hyper.exe"

#z:: Run zoommtg://zoom.us/join?action=join&confno=6595567171&zc=0
^#z::OpenAsApp("https://cloudsearch.google.com/cloudsearch?authuser=0") 



; ================ OTHER HOTKEYS

#space::
  Run chrome.exe --new-window ; new browser window
  WinActivate, "New Tab" 
Return

^#space:: ; cycle through input keyboard
  PostMessage WM_INPUTLANGCHANGEREQUEST:=0x50, INPUTLANGCHANGE_FORWARD:=0x2,,, % (hWndOwn := DllCall("GetWindow", Ptr, hWnd:=WinExist("A"), UInt, GW_OWNER := 4, Ptr)) ? "ahk_id" hWndOwn : "ahk_id" hWnd
Return


#F1::OpenAsApp("https://devdocs.io/") ; devdocs

#=::Run calc.exe ; calculator

^#1::Run "G:/Team Drives" ; google team drives (local)
#!1::OpenAsApp("https://drive.google.com/drive/my-drive") ; my drive (online)
^#!1::OpenAsApp("https://drive.google.com/drive/team-drives") ; google team drives (online)

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
#IfWinActive 

; auto-reload when editing ahk
#IfWinActive ahk-scripts
  ^s::
    sleep, 200
    Reload
  return
#IfWinActive 

#IfWinActive ahk_class Chrome_WidgetWin_1
  ^+k::CloneFromGitHub()
#IfWinActive


; ================ FUNCTIONS

; if the active window is a GitHub repository, clone it, install dependencies, and open in Code
CloneFromGitHub() {
  url := GetActiveBrowserURL()
  If RegExMatch(url, "Oi)https?://github.com/(\w+)/(\w+)", matches) {
    org := matches.Value(1)
    repo := matches.Value(2)
    Run powershell c:\git\ahk-scripts\clone.ps1 -Org %org% -Repo %repo%
  }
}

OpenAsApp(url) {
  run chrome.exe --app=%url%
}

CopyBrowserURL() {
  ; copy active browser URL
  url := GetActiveBrowserURL()
  If (url != "")
    clipboard = %url%
  Else
    WinGetClass, Clipboard, A
}

CopyMarkdownLink() {
  url := GetActiveBrowserURL()
  If (url != "") 
  {
    WinGetActiveTitle, Title
    link := "[" . Title . "](" . url . ")"
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
    url := GetActiveBrowserURL()
    InputBox, UserInput, Shortcut Name,Please enter a name for this Chrome app shortcut: `n%url%,,350,150 
    If (!ErrorLevel and UserInput <> "")
      FileCreateShortcut, %BrowserLocation%, %ShortcutDirectory%/%UserInput%.lnk, , --app=%url%
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
