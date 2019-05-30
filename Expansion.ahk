::l.l::l·l ; Ela geminada 

::<--::🡐
::-->::🡒


::ttt:: ; Date stamp for file names
FormatTime, DateStamp, %A_Now%, yyyyMMdd
Send, %DateStamp% 
Return 

::tttt:: ; Date stamp for daily log
FormatTime, DateStamp, %A_Now%, ddd, MMM d 
Send, %DateStamp% 
Return 

::shrugg::¯\_(ツ)_/¯

::meetmez::zoommtg://zoom.us/join?action=join&confno=6595567171&zc=0
::meetme::https://www.devresults.com/meet/herb

::poaddr::
(
4401A Connecticut Ave, NW #239
Washington, DC 20008
)

::wwaddr::
(
641 S Street NW, 4th Floor
Washington, DC 20001
)

::payaddr::
(
PO Box 16520846
Sioux Falls, SD 57186
)

::pdh::
(
Please don't hesitate to give me a call at 202.294.7901 if you have any questions.

Warm regards,
Herb
)

::afaik::as far as I know
::lmkwyt::Let me know what you think.
::plmk::Please let me know if there's any additional information I can provide. 

::notint::
(
Thanks for your note. I'm not interested - could you please take me off your list? 

Thanks
Herb
)

::loremipsum::
	clipboard = 
	(
	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Phasellus hendrerit. Pellentesque aliquet nibh nec urna. In nisi neque, aliquet vel, dapibus id, mattis vel, nisi. Sed pretium, ligula sollicitudin laoreet viverra, tortor libero sodales leo, eget blandit nunc tortor eu nibh. Nullam mollis. Ut justo. Suspendisse potenti.

	Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus. Praesent elementum hendrerit tortor. Sed semper lorem at felis. Vestibulum volutpat, lacus a ultrices sagittis, mi neque euismod dui, eu pulvinar nunc sapien ornare nisl. Phasellus pede arcu, dapibus eu, fermentum et, dapibus sed, urna.

	Morbi interdum mollis sapien. Sed ac risus. Phasellus lacinia, magna a ullamcorper laoreet, lectus arcu pulvinar risus, vitae facilisis libero dolor a purus. Sed vel lacus. Mauris nibh felis, adipiscing varius, adipiscing in, lacinia vel, tellus. Suspendisse ac urna. Etiam pellentesque mauris ut lectus. Nunc tellus ante, mattis eget, gravida vitae, ultricies ac, leo. Integer leo pede, ornare a, lacinia eu, vulputate vel, nisl.
	)
	WinClip.Paste()
return

; -------------- zoom messages
::szoom::
	WinClip.Clear()
	Msg = Let's meet via Zoom at http://www.devresults.com/meet/herb . Use your computer's microphone and speakers (a headset works best), or call +1 669 900 6833 (meeting ID 659 556 7171).
	HtmlMsg = <p>&nbsp;</p><div style='border:1px solid #aaa;background:#eee;padding:10px;font:12px/16px arial,helvetica,sans-serif;color:#555'>%Msg%</div><p>&nbsp;</p>
	WinClip.SetText(Msg)
	WinClip.SetHTML(HtmlMsg)
	Send ^v ; paste
return	

; -------------- signature
::ssig::
	WinClip.Clear()
	WinClip.SetHTML("<div style='font:10px/15px arial,helvetica,sans-serif;color:#aaa'><p ><b style='color:black'>Herb Caudill</b><br>Founder | Chief Executive Officer<br><b>Washington DC</b> +1 202.294.7901 | <b>Barcelona</b> +34 609 984 889 | <b>Skype</b> herbcaudill</p><p ><b style='color:black'>DevResults</b> Software for global development. | <b>www.devresults.com</b></p></div>")
	Send ^v ; paste
return
