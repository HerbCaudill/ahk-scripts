#SingleInstance force
#MaxMem 256
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include ./lib/WinClipAPI.ahk
#Include ./lib/WinClip.ahk
#Include ./lib/GetActiveBrowserURL.ahk
#Include ./lib/UrlEncodeDecode.ahk

#Include ./Hotkeys.ahk
#Include ./Expansion.ahk



  