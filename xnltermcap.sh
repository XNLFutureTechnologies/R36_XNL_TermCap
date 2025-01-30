#!/bin/bash
# =================================================================================
# XNL Future Technologies R36 TermCap
#
# Purpose: This script/program is designed to take screenshots from terminal based
# (tty1) applications which for example use Dialog etc. With this program it is A LOT
# easier and faster to take screenshots of terminal based applications so that developers
# can for example use them to put in their manuals, tutorials, wiki, video's etc.
# 
# XNL TermCap is intended to be 'called' from for example SSH or the serial terminal
# while the actual 'graphical terminal application' is running on the device itself.
# It is NOT possible to use XNL TermCap from the console itself (by starting it from
# EmulationStation for example).
#
# NOTE: XNL TermCap is not intended (or able to) take screenshots of SDL/SDL2 etc applications
#       like for example EmulationStation, Emulators etc etc. It's purely intended to take
#		screenshots of the TTY1 terminal in 'text/semi-graphical mode' so to speak.
#
# INSTALLATION TIP:
# If you would want to use this program 'system wide' from the terminals/ssh, then I would
# recommend to for example copy it to: /usr/local/bin
# I would also strongly recommend to remove the .sh extension from the filename when copying
# XNL TermCap into the /usr/local/bin folder (so it would become /usr/local/bin/xnltermcap
# instead of /usr/local/bin/xnltermcap.sh)
#
# You can then simply type xnltermcap anywhere on the command line and it will automatically run
#
#------------------------
# Project: XNL Future Technologies R36 XNL TermCap
# Website: https://www.teamxnl.com/R36-XNL-TermCap
# YouTube: https://www.youtube.com/@XNLFutureTechnologies
# GitHub:  https://github.com/XNLFutureTechnologies/R36_XNL_TermCap
# License: XNL CUSTOM (Included as LICENSE file otherwise found at: https://www.teamxnl.com/product/r36-xnl-termcap)
#          You are free to use, modify, and distribute this software under the terms of the license mentioned above
#          However, if you distribute a modified version or create a derivative work:
#          1. You must provide appropriate credit to the original author(s).
#          2. You must clearly mention on which project/program your version is based on (XNL TermCap).
#          3. You must link back to the original source (https://www.teamxnl.com/R36-XNL-TermCap).
#          4. You must license your derivative work it's license must comply with the original license
#             and can't impose additional restrictions to your users
# 
# TIP: Just copying this 'info block' and then for example changing Project: to BasedOn: would be sufficient :)
#------------------------
#
# =================================================================================
Application="XNL Future Technologies TermCap - DevTools"
Version="1.0"	# NOT used for online update etc, that is handled externally, this just shows the version in --version
VYear="2025"	# This just indicates the year of the current release

CurScriptName=$(basename "$0")
Arg1="$1"
Arg2="$2"


if [[ ! -n "$SSH_TTY" && "$(tty 2>/dev/null)" != "/dev/ttyFIQ0" ]]; then
	RunningFromConsole="y"
else
	RunningFromConsole="n"
fi


if [[ $RunningFromConsole == "y" ]]; then
	# Take control of tty1 (the terminal), clearing the terminal and printing the "Application" start text in color
	sudo chmod 666 /dev/tty1
	printf "\033c" > /dev/tty1
	printf "\e[34mStarting XNL TermCap\n\e[32mPlease wait...\e[0m" > /dev/tty1
	reset
	
	# hide cursor
	printf "\e[?25l" > /dev/tty1
	dialog --clear
	
	# Preset dialog height and width
	height="15"
	sheight="10"
	width="55"
	swidth="45"
	
	# If it's running on a device containing RG503 in it's name then adjust the
	# dialog size. NOT needed for my R36S/R36H tools, but I have left them in for
	# SOME compatibility if users do run my scripts on other devices which run ArkOS
	if test ! -z "$(cat /home/ark/.config/.DEVICE | grep RG503 | tr -d '\0')"
	then
	height="20"
	sheight="15"
	width="60"
	swidth="50"
	fi
	
	export TERM=linux
	export XDG_RUNTIME_DIR=/run/user/$UID/
	
	pgrep -f gptokeyb | sudo xargs kill -9
	pgrep -f osk.py | sudo xargs kill -9
	
	# Compatibility for additional systems (originally from the ArkOs wifi.sh)
	# Do note though that most of my scripts are only developed for and tested on
	# R36S and R36H devices! Most of them should run fine on other systems, but this
	# is just a guess and NOT supported by me in any way.
	if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
	if test ! -z "$(cat /home/ark/.config/.DEVICE | grep RG503 | tr -d '\0')"
	then
		sudo setfont /usr/share/consolefonts/Lat7-TerminusBold20x10.psf.gz
	else
		sudo setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz
	fi
	else
	sudo setfont /usr/share/consolefonts/Lat7-Terminus16.psf.gz
	fi
	printf "\033c" > /dev/tty1
fi

#==============================================================================================================================
# The 'Graphical' Mode of XNL TermCap
# This is a simple but user friendly (with dialog) way to show users that XNL TermCap can't be used from the
# console (or EmulationStation for that matter) itself. The program will do nothing else here but just show some basic
# info and then shutdown again.
#==============================================================================================================================
GraphicalProgram(){
	local TermCapInfo="XNL TermCap isn't intended to be started directly from the console itself.\n\n
This is just a small overview, for more information please visit: www.teamxnl.com/R36-XNL-TermCap\n
\n
XNL TermCap is for example intended for developers who need to take screenshots of their terminal/tty1 based applications like this dialog you are seeing here, to make tutorials, manuals etc.\n\n
XNL TermCap should be used from SSH or via the serial terminal.\n\n
Use Example:\n
xnltermcap [Optional FileName]\n\n
If you don't enter a filename, then XNL TermCap will generate a filename with the current date and time.\n\n
WARNING: If you do use a custom filename, it will automatically overwrite any existing screenshots with the same name if it already exists!\n\n
The folder in which XNL TermCap stores it's screenshots is:\n
/roms/screenshots\n\n
NOTES:\n
XNL TermCap is NOT intended or able to take screen shots of SDL/SDL2 etc applications (EmulationStation, games etc etc)!\n
\nYou might have noticed that I'm not showing .sh at the end of the command in the example above, this is because I actually recommend removing the extension to make using the program from the commandline much more convenient.\n\n "


	dialog --backtitle "$Application" --title "XNL TermCap" --msgbox "$TermCapInfo" 15 55
	exit 1
}

#==============================================================================================================================
# The Terminal Mode of XNL TermCap
# This is the actual 'program' itself, which will run as intended
#==============================================================================================================================
TerminalProgram(){
	# In this variable we'll store the custom filename if the user has entered one as parameter
	CustomFileName=""

	# First we'll detect if the (terminal/ssh) user has tried to pass a 'command/parameter argument'
	if [[ "$Arg1" == -* ]]; then
		# If this is the case we'll see if it's one of the supported help commands
		if [[ "$Arg1" == "-help" || "$Arg1" == "-h" || "$Arg1" == "--help" || "$Arg1" == "--h" ]]; then
			printf "============================================================================================\n"
			printf "XNL TermCap\n" 
			printf "  By XNL Future Technologies v$Version ($VYear)\n"
			printf "============================================================================================\n"
			printf "\n" 
			printf " XNL TermCap is intended for developers who need to take screenshot of their\n" 
			printf " terminal (tty1) based 'graphical' applications which for example use Dialog so that\n" 
			printf " they can use them in manuals, tutorials, videos etc.\n" 
			printf "\n" 
			printf " It can be quite annoying to take a screenshot of a headless Linux installation,\n" 
			printf " especially if you need one from a 'graphical terminal interface'.\n" 
			printf " And that is exactly why I decided to make this 'program' to solve that problem and\n" 
			printf " to make it a smooth process for your workflow (and mine ;) )\n" 
			printf "\n" 
			printf " Usage:\n" 
			printf "   xnlTermCap \"optional filename\"\n"
			printf "\n" 
			printf " XNL TermCap will automatically generate a filename with date and time if you\n"
			printf " don't use a custom filename.\n" 
			printf "\n" 
			printf "   Screenshots are automatically saved in: /roms/screenshots\n" 
			printf "\n" 
			printf "   WARNING: If you do use a custom file name, then XNL TermCap will overwrite any\n" 
			printf "            existing file with the entered filename if it already exists without confirmation!\n"
			printf "\n" 
			printf " NOTE: XNL TermCap is ONLY intended to create screenshot of TTY1 screens, dialogs etc\n" 
			printf "       this tool does not work for SDL applications like EmulationStation, emulators etc.\n" 
			printf "\n" 
			printf "  Command                       Description\n"
			printf "  ==========================================================\n"
			printf "  -help, -h                     Shows this help\n" 
			printf "  -info, -about, -version, -v   Shows Version and about Info\n" 
			printf "  ==========================================================\n"
			printf "\n" 
			printf " www: http://www.teamxnl.com/R36-XNL-TermCap    YouTube: @XNLFutureTechnologies\n"
			printf "============================================================================================\n"
			printf "\n" 
			exit 0
		# Or if it's one of the info/version/about commands
		elif [[ "$Arg1" == "-info" || "$Arg1" == "-about" || "$Arg1" == "-version" || "$Arg1" == "-v" || "$Arg1" == "--info" || "$Arg1" == "--about" || "$Arg1" == "--version" || "$Arg1" == "--v" ]]; then
			printf "\nXNL TermCap\n" 
			printf "  By XNL Future Technologies\n"
			printf "  https://wwww.teamxnl.com/R36-XNL-TermCap\n"
			printf "  https://wwww.youtube.com/@XNLFutureTechnologies\n"
			printf "  https://github.com/XNLFutureTechnologies/R36_XNL_TermCap\n"
			printf "\n"
			printf "Version: $Version ($VYear)\n"
			printf "\n"
			exit 0
		# If it's none of the supported commands we'll give an error that the command is not known
		else
			printf "\nXNL TermCap\n\n" 
			printf "Unknown Command: $Arg1\n"
			printf "  use: xnltermcap --help for more information\n\n"
			exit 1
		fi
	# Then we'll detect if the user tried to enter a custom filename for the screenshot
	else
		if [[ -n "$Arg1" ]]; then
			if [[ -n "$Arg2" ]]; then
				printf "\nXNL TermCap\n\n" 
				printf "ERROR: If you want to use a custom filename with spaces in it\n"
				printf "       then you will have to 'quote' the filename like this:\n"
				printf "\n"
				printf "  xnltermcap \"Custom Screenshot Name\""
				printf "\n"
				exit 1
			else
				# Here we do some BASIC checks to see if it would be a valid filename which the user has entered
				CustomFileName="$Arg1"
				check_filename "$CustomFileName"

				# If the user didn't added .jpg to the end of the file then we'll do that automatically
				# YES! I know, I didn't (won't!) check for things like .jpeg and I'm relying on bash (Version)
				# to handle case sensitive checking etc... no big deal here ;)
				if [[ ! "$CustomFileName" =~ \.jpg$ ]]; then
					CustomFileName="$CustomFileName.jpg"
				fi
			fi
		fi
	fi


	# If needed create the required directories
	mkdir -p /tmp
	mkdir -p /roms/screenshots
	
	# IF there is a previous screenshot dump in the temp tmp directory we'll remove it
	rm -f /tmp/xnlftscrshot.dump
		
	if [[ -z "$CustomFileName" ]]; then
		# Here we generate a file name leading with XNL SCR - followed by the current date and time
		OutputFilename="XNL SCR - $(date '+%d-%m-%Y %H-%M-%S').jpg"
		DestPath="/roms/screenshots/$OutputFilename"

		# Just to be safe we'll check if that particular filename already exists
		# and if so we'll add a -1 to the filename and check again if it's availible
		# all the way up to 20. I've used 20 as limit because A: It's already quite
		# unlikely that there are that many files with the exact same time and date,
		# it's not impossible though because these devices don't have an RTC.
		# And B: Because if for some insane reason there would be an "infinite"
		# amount of screenshots with the same filename, then I don't want the script
		# to lock up on this and thus abort at the 20th attempt.
		COUNTER=1
		while [[ -f "$DestPath" && $COUNTER -le 20 ]]; do
			OutputFilename="XNL SCR - $(date '+%d-%m-%Y %H-%M-%S')-$COUNTER.jpg"
			DestPath="/roms/screenshots/$OutputFilename"
			COUNTER=$((COUNTER + 1))
		done
		
		# If we indeed reached the 20th attempt to create a filename for the screenshot
		if [[ $COUNTER -gt 20 ]]; then
			echo "===================================================================="
			echo "XNL TermCap: Can't create screenshot, filenames taken"
			echo "===================================================================="
			exit 1
		fi
	else
		OutputFilename="$CustomFileName"
	fi

	DestPath="/roms/screenshots/$OutputFilename"
	
	# Here we do a dump directly from the fb0 buffer to a raw "pixel format" file
	cat /dev/fb0 > /tmp/xnlftscrshot.dump
	
	# Because that dump is basically put 'raw pixel format data', we'll need to convert
	# it to something useful for us humans ;) And thus we'll convert it to a jpg and used
	# the previously generated filename as output file in the folder /roms/screenshots
	ffmpeg -f rawvideo -pix_fmt rgb32 -s 640x480 -i /tmp/xnlftscrshot.dump -f image2 -vcodec mjpeg -q:v 2 -y -loglevel quiet "$DestPath"
	
	# removing the raw dump we made earlier
	rm -f /tmp/xnlftscrshot.dump
	
	# output to the user that the screenshot has been taken and what the filename is
	printf "====================================================================\n"
	printf "XNL TermCap: Screenshot created: $OutputFilename\n"
	printf "====================================================================\n"
}


#==============================================================================================================================
# A very simple function to check for BASIC filename issues, it definitly doesn't cover everything,
# but I'm assuming that most people using this would know what they are doing ;) this function is basically just
# to cover basic issues and/or typo's
#==============================================================================================================================
check_filename() {
    local filename="$1"
    # Check if the filename only whitespace
    if [[ "$filename" =~ ^[[:space:]]*$ ]]; then
        printf "\nXNL TermCap"
        printf "  Error: Filename is empty or contains only spaces!\n"
        printf "\n"
        exit 1
    fi

    # Check if filename contains any invalid characters (e.g., / \ : * ? " < > |)
     if [[ "$filename" =~ [\/\:\*\?\"\<\>\|] ]]; then
        printf "\nXNL TermCap"
        printf "  Error: Filename contains invalid characters!\n"
        printf "\n"
        exit 1
    fi

    # Check if the filename length is reasonable (e.g., no longer than 255 characters)
    if [[ ${#filename} -gt 150 ]]; then
        printf "\nXNL TermCap"
        printf "  Error: Filename too long (max 150 char)!\n"
        printf "\n"
        exit 1
    fi

    return 0
}

#==============================================================================================================================
# Cleanup function to 'cleanup after our script' 
#==============================================================================================================================
CleanUpOnExit() {
	# For this application we'll only need to clean-up if it has been started directly
	# from the console (which it is not intended for!)
	if [[ $RunningFromConsole == "y" ]]; then
		printf "\033c" > /dev/tty1				# Clear the terminal
		if [[ ! -z $(pgrep -f gptokeyb) ]]; then  # Kill all running gptokeyb instances
			pgrep -f gptokeyb | sudo xargs kill -9 
		fi
		# Used to check for a specific platform this script is running on (a different device
		# than the R36S/H but I re-used this part for POSSIBLE future compatibility with other
		# handhelds like mine (code re-used from wifi.sh)
		if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
			sudo setfont /usr/share/consolefonts/Lat7-Terminus20x10.psf.gz
		fi
	fi
	exit 0
}

# Again: Only needed to run, initialize etc if this program is started directly from the console
if [[ $RunningFromConsole == "y" ]]; then
	#==============================================================================================================================
	# Gamepad control, 'trapping' the script exit and starting the menu
	#==============================================================================================================================
	# Set the permissions to interact with uinput (the 'device')
	sudo chmod 666 /dev/uinput
	
	# Loading a database (Simple DirectMedia Layer) which holds the info for lots of 'pre-configured' controllers so that the
	# gamepad(s) (which also include the internal gamepad of the R36S/H) buttons are propperly assigned with gptokeyb
	#(Gamepad to Keyboard/Mouse).
	export SDL_GAMECONTROLLERCONFIG_FILE="/opt/inttools/gamecontrollerdb.txt"
	
	# Find all (already) running processes of gptokeyb and kill (terminate) them. We do this to ensure that you for example
	# wont get double key emulations or other issues which might arrise from multiple instances running.
	if [[ ! -z $(pgrep -f gptokeyb) ]]; then
	pgrep -f gptokeyb | sudo xargs kill -9
	fi
	
	# Here we link gptokeyb to our script so that gptokeyb knows which script to instantly kill when we press
	# Select + Start on the R36S or R36H. and option -C (followed by the file .gptk file location) tell gptokyb
	# which buttons have to be emulated when we press the game controller buttons (and thus convert them to
	# keyboard presses). The last section of this line basically ensures that gptokeyb runs in the background
	# and that all it's output will be 'tossed into dev/null' (aka disappear in oblivion)/be discarded,
	# esentially making it run silently.
	/opt/inttools/gptokeyb -1 "$CurScriptName" -c "/opt/inttools/keys.gptk" > /dev/null 2>&1 &
	
	# Reset/clear the terminal
	printf "\033c" > /dev/tty1
	
	# This ensures that the function CleanUpOnExit will be called when the script exits.
	# we can/will use this to perform additional clean-ups and/or other routines we (might) need to
	# do at the end our script/program
fi

# always 'trap the exit' no matter if they start it from the console itself or from a terminal
trap CleanUpOnExit EXIT

# Determine into which mode the application needs to 'boot'
if [[ $RunningFromConsole == "n" ]]; then
	TerminalProgram
else
	GraphicalProgram
fi
