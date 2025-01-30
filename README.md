# R36 XNL TermCap
XNL TermCap stands for XNL TerminalCapture. It's bascially a simple (sh) program which enables you to take screenshots of (TTY1) terminal applications running on our R36S/R36H console, this also includes applications which use Dialog for example. This tool can be extremely handy if you have written a script or program and you want to post some screenshots of it or of you for example need (real) screenshots of your new application to make documentation, tutorials etc.  
  
I noticed that there where quite A LOT of posts on the internet of people asking on different Linux forums how they could capture and actual screenshot of the terminal (and not just a 'text dump'), but could not really found a decent answer to this question myself. And considering that these consoles use a framebuffer (fb0) instead of a 'regular x server', lots of additional tools would also fail to do so. Or it would require the user to install additional dependencies.  
  
So to make sure that I could still make screenshots of the tools I'm working on (for the R36S/R35H), I made this small (sh) program inbetween. It basically put just does (simply put) a "raw pixel data dump" using cat on fb0 to file and then with a (way to overcomplicated😂) ffmpeg command I convert this dump into a .jpg with as minimal compression as possible to ensure a good quality for publications etc.  
  
This program also automatically saves to a screenshots folder and generates filenames with date and time in them. You can however also specify your own custom filename per screenshot if you would like to.  
  
I would however strongly recommend to check out the official website for this program/project for more detailed information, usage, commands and screenshots of it (taken with this program itself, so basically 'selfies'?😂). You can find the official project/program website here: https://www.teamxnl.com/r36-xnl-termcap/  
  
## Supported Devices Note
Because this program doesn't do much which is very device speciffic it should work on lots of other retro consoles which run on ArkOS. However! it is hardcoded to use the resolution 640x480, it uses hardcoded paths which 'belong' to the R36S/R36H consoles (for which I use the same ArkOS image as the RG351MP). So it COULD work just perfectly fine for your device(s), but officially this program is only intended to be used on/with the R36S and R36H.  
  
Website: https://www.teamxnl.com/R36-XNL-TermCap  
YouTube: https://www.youtube.com/@XNLFutureTechnologies  
  
