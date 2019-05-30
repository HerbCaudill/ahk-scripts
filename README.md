# AutoHotkey scripts

These are the [AutoHotkey](https://www.autohotkey.com/) scripts that I always
have running.

## What to do with this repo if you're not me

If you already have an AutoHotKey setup that you're happy with, feel free to
look through this and copy and paste stuff that you like. Note that some scripts
that depend on libraries in the `lib` folder.

Alternatively, you can pull down this whole repo and modify it to suit your
needs. To enable these scripts when your computer starts up, paste a shortcut to
`Main.ahk` in your Windows startup folder (for me that's
`%AppData%\Microsoft\Windows\Start Menu\Programs\Startup`).

I use Windows 10; I don't know how much work it would be to make any of these
useful on a Mac, probably a lot.

### 🕵‍ Secrets

I have a couple of API keys stored in a file called `Secrets.ahk`, which is not
committed to source control.

If you use either the Dynalist or the Asana scripts, you'll want to rename
`Secrets-Example.ahk` to `Secrets.ahk` and put your real API key(s) there.

## What's good

There are two main categories:

- [Text expansions](expansion.ahk) are snippets of text that expand into larger
  chunks of text.
- [Hotkeys](hotkeys.ahk) are keyboard shortcuts (mostly using the Windows logo
  key).

### Signature

I only really use email signatures when I'm first establishing communication
with someone, so I don't have them on by default in Gmail. Instead I type `ssig`
and I get this:

<img width=50% src=https://user-images.githubusercontent.com/2136620/58626193-7ccd0780-82d4-11e9-8f05-701f30dee961.png />

Note the use of `WinClip.SetHTML` to put HTML into the clipboard.

```ahk
::ssig::
  WinClip.Clear()
  WinClip.SetHTML("<div style='font:10px/15px'>etc etc</div>")
  Send ^v ; paste
return
```

### Lorem ipsum

Sometimes a person just needs a big whack of fake text. When I have that craving
I just type `loremipsum` and I get this:

<!-- cSpell:disable -->
```
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Phasellus hendrerit.
Pellentesque aliquet nibh nec urna. In nisi neque, aliquet vel, dapibus id,
mattis vel, nisi. Sed pretium, ligula sollicitudin laoreet viverra, tortor
libero sodales leo, eget blandit nunc tortor eu nibh. Nullam mollis. Ut justo.
Suspendisse potenti. Sed egestas, ante et vulputate volutpat, eros pede semper
est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus
adipiscing, commodo quis, gravida id, est. Sed lectus. Praesent elementum
hendrerit tortor. Sed semper lorem at felis. Vestibulum volutpat, lacus a
ultrices sagittis, mi neque euismod dui, eu pulvinar nunc sapien ornare nisl.
Phasellus pede arcu, dapibus eu, fermentum et, dapibus sed, urna. Morbi interdum
mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet,
lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus.
Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus.
Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante,
mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a,
lacinia eu, vulputate vel, nisl.
```
<!-- cSpell:enable -->

Since this is so long, if you implement it as straight-up text expansion it will
take a while to get all typed out. Instead I put it in the clipboard and then
just paste it:

```ahk
::loremipsum::
  clipboard = Lorem ipsum etc etc
  Send ^v ; paste
return
```

### Today's date

I'll often preface filenames with the current date in a sortable format like
`20190530`.

In order to preserve precious brain cycles, I've made this expansion so that I
can get that by typing `ttt`:

```ahk
::ttt:: ; Date stamp for file names
  FormatTime, DateStamp, %A_Now%, yyyyMMdd
  Send, %DateStamp%
Return
```

If you prefer a different format, just change the format string `yyyyMMdd` to
something else; for example, `ddd, MMM d` gives you `Thu, May 30`.

### Web lookups

I have a handful of shortcuts that let me highlight some text and look it up
somewhere, like Amazon or Google or Wikipedia.

The `LookupSelection` function is simple:

```ahk
LookupSelection(url) {
  WinClip.Copy()
  url := StrReplace(url, "~s~", Clipboard)
  Run % url
}
```

As long as whatever it is uses a predictable search URL, you can use this. For
example, if you search your Gmail for `autohotkey` you'll notice that the URL
looks like this: `https://mail.google.com/mail/u/0/#search/autohotkey`. So the
hotkey for searching Gmail for the selected text looks like this:

```ahk
^#2::LookupSelection("https://mail.google.com/mail/ca/u/0/#search/~s~")
```

This is a beautiful thing because it allows me to search my email _without
seeing my inbox_, which would otherwise derail me from whatever I was working
on.

### Compose message

Speaking of avoiding that deadly glimpse of my inbox, this hotkey lets me write
an email without seeing what people have emailed me! I know, it seems like it
should probably be illegal.

```ahk
#c::Run % "chrome.exe --app=https://mail.google.com/mail/?view=cm&fs=1&tf=1 --disable-extensions"
```

Note the `--app` flag, which I use a lot: It gives me a window with no browser
cruft.

### AutoHotKeys for AutoHotKey

I have a couple of definitions that help me work with AutoHotKey itself. 

This makes it easy for me to open this repo in VS Code:

```ahk
^#e:: ; edit AutoHotKey script
  Run "C:\Users\herb\AppData\Local\Programs\Microsoft VS Code\Code.exe" C:\git\ahk-scripts\
Return
```

This forces AutoHotKey to reload every time I save a script. (This assumes that the editor title contains the full path, and that the path includes `ahk-scripts`.)

```ahk
#IfWinActive ahk-scripts
  ^s::
    sleep, 200
    Reload
  return
#IfWinActive 
```

Sometimes that doesn't work - for example if I'm debugging that particular hotkey (third-level inception) - so as a backup, I can always force the script to reload with this hotkey: 

```ahk
^#r::Reload  
```

### Paste plain text

When I need to strip formatting from text I've copied, this is quicker than round-tripping it through notepad:

```ahk
^+!v::PastePlainText()

PastePlainText()  {
  clipboard = %clipboard% ;  convert clipboard contents to plain text only
  send ^v
  return
}
```