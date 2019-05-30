:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off
if defined __ goto :conf
set __=.
call %0 %* | darkbox
set __=
goto :eof

:conf
	mode 100,30
	title Flexa
	cmdfocus.exe /center
	color 07
	echo -h 0
	setlocal EnableDelayedExpansion
	set "theme1=0xf0" & set "theme2=0x0b" & set "theme3=0x03" & set "theme4=0x08"
	
	set "show_programs=1"
	
	goto :main
	
:draw_ui
	echo -s
	(
		echo -cgd %theme1% 1 1 "                                                                                                  "
		echo -gd 1 28 "                                                                                                  "
		echo -gd 1 1 "Flexa v1.0"
	)
	
	exit /b
	
:main
	call :draw_ui
	
	echo -cgad %theme2% 1 3 175 " Choose option:"
	echo -cgd %theme3% 3 4 "{1} Login"
	echo -cgd %theme3% 3 5 "{2} Register"
	echo -cgd %theme3% 3 6 "{3} Back to Windows"
	
	:loop_1
		darkbox_i -k
		if "!errorlevel!" equ "49" goto :login
		if "!errorlevel!" equ "50" goto :register
		if "!errorlevel!" equ "51" exit
		goto :loop_1
		
	:login
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Login"
		echo -cgd %theme3% 3 4 "Username : "
		echo -cgd %theme3% 3 5 "Password : "
		
		echo -h 1
		echo -cg %theme4% 14 4
		set /p "login_username="
		echo -cg %theme4% 14 5
		set /p "login_password="
		echo -h 0
		
		echo -cgad %theme2% 1 7 175 " Logging in..."
		echo -w 1000
		
		if not "%login_username%" equ "" (
			if exist "users/%login_username%/_%login_password%.pwd" (
				echo -cgd %theme3% 3 8 "Login successful^!"
				echo -w 1000
				
				set "last_operation='Logged in'"
				goto :desktop
			) else (
				set "login_bad=1"
			)
		) else (
			set "login_bad=1"
		)
		if "%login_bad%" equ "1" (
			echo -cgd %theme3% 3 8 "Bad username or password."
			
			echo -cgad %theme2% 1 10 175 " Choose option:"
			echo -cgd %theme3% 3 11 "{1} Back to menu"
			echo -cgd %theme3% 3 12 "{2} Try again"
			
			:loop_2
				darkbox_i -k
				if "!errorlevel!" equ "49" goto :main
				if "!errorlevel!" equ "50" goto :login
				goto :loop_2
		)
	
	:register
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Register"
		echo -cgd %theme3% 3 4 "Username : "
		echo -cgd %theme3% 3 5 "Password : "
		
		echo -h 1
		echo -cg %theme4% 14 4
		set /p "register_username="
		echo -cg %theme4% 14 5
		set /p "register_password="
		echo -h 0
		
		echo -cgad %theme2% 1 7 175 " Creating account..."
		echo -w 1000
		
		md "users/%register_username%"
		echo -d "%register_password%" > "users/%register_username%/_%register_password%.pwd"
		
		echo -cgad %theme2% 1 9 175 " Account Created^!"
		echo -w 2000
		
		goto :main
		
	:desktop
		call :draw_ui
		
		echo -cgad %theme4% 1 25 175 " Logged as : %login_username%"
		echo -cgad %theme4% 1 26 175 " Last operation : %last_operation%"
		
		echo -cgad %theme2% 1 3 175 " Menu:"
		if "%show_programs%" equ "1" echo -cgd %theme3% 3 4 "{SPACE} Show games"
		if "%show_games%" equ "1" echo -cgd %theme3% 3 4 "{SPACE} Show programs"
		
		echo -cgad %theme2% 1 6 175 " Settings:"
		echo -cgd %theme3% 3 7 "{1} Change theme"
		echo -cgd %theme3% 3 8 "{2} Back to menu"
		echo -cgd %theme3% 3 9 "{3} Back to Windows"
		
		if "%show_programs%" equ "1" (
			echo -cgad %theme2% 27 3 175 " Programs:"
			echo -cgd %theme3% 29 4 "{a} Calculator"
			echo -cgd %theme3% 29 5 "{b} Single Note"
			echo -cgd %theme3% 29 6 "{c} Terminal"
			echo -cgd %theme3% 29 7 "{d} Music Player"
			echo -cgd %theme3% 29 8 "{e} Ping"
			rem echo -cgd %theme3% 29 9 "{f} AI Chatbot"
			
			:loop_3
			darkbox_i -k
			if "!errorlevel!" equ "32" set "show_games=1" && set "show_programs=0" && set "last_operation='Switched to show games'" && goto :desktop
			if "!errorlevel!" equ "49" set "last_operation='Changed color scheme'" & goto :change_theme
			if "!errorlevel!" equ "50" goto :main
			if "!errorlevel!" equ "51" exit
			
			if "!errorlevel!" equ "97" set "last_operation='Launched Calculator'" & goto :program_calculator
			if "!errorlevel!" equ "98" set "last_operation='Launched Single Note'" & goto :program_single_note
			if "!errorlevel!" equ "99" set "last_operation='Launched Terminal'" & goto :program_terminal
			if "!errorlevel!" equ "100" set "last_operation='Launched Music Player'" & goto :program_music_player
			if "!errorlevel!" equ "101" set "last_operation='Launched Ping'" & goto :program_ping
			rem if "!errorlevel!" equ "102" set "last_operation='LAunched AI Chatbot'" & goto :program_ai_chatbot
			goto :loop_3
		)
		
		if "%show_games%" equ "1" (
			echo -cgad %theme2% 27 3 175 " Games:"
			echo -cgd %theme3% 29 4 "{a} Space shooter"
			echo -cgd %theme3% 29 5 "{b} Random number guesser"
			echo -cgd %theme3% 29 6 "{c} Solitaire"
			
			:loop_4
				darkbox_i -k
				if "!errorlevel!" equ "32" set "show_programs=1" && set "show_games=0" && set "last_operation='Switched to show programs'" && goto :desktop
				if "!errorlevel!" equ "49" set "last_operation='Changed color scheme'" & goto :change_color_scheme
				if "!errorlevel!" equ "50" goto :main
				if "!errorlevel!" equ "51" exit
				goto :loop_4
		)
		
	:change_theme
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Change color scheme:"
		echo -cgd %theme3% 3 4 "{1} " -ca 0x0f 178 -ca 0x0b 178 -ca 0x03 178 -ca 0x08 178 -cd %theme3% " Blue"
		echo -cgd %theme3% 3 5 "{2} " -ca 0x0f 178 -ca 0x0c 178 -ca 0x04 178 -ca 0x08 178 -cd %theme3% " Red"
		echo -cgd %theme3% 3 6 "{3} " -ca 0x0f 178 -ca 0x0a 178 -ca 0x02 178 -ca 0x08 178 -cd %theme3% " Green"
		echo -cgd %theme3% 3 7 "{4} " -ca 0x0f 178 -ca 0x0e 178 -ca 0x06 178 -ca 0x08 178 -cd %theme3% " Yellow"
		echo -cgd %theme3% 3 8 "{5} Back to desktop "
		
		:loop_5
			darkbox_i -k
			if "!errorlevel!" equ "49" set "theme1=0xf0" & set "theme2=0x0b" & set "theme3=0x03" & set "theme4=0x08" & goto :desktop
			if "!errorlevel!" equ "50" set "theme1=0xf0" & set "theme2=0x0c" & set "theme3=0x04" & set "theme4=0x08" & goto :desktop
			if "!errorlevel!" equ "51" set "theme1=0xf0" & set "theme2=0x0a" & set "theme3=0x02" & set "theme4=0x08" & goto :desktop
			if "!errorlevel!" equ "52" set "theme1=0xf0" & set "theme2=0x0e" & set "theme3=0x06" & set "theme4=0x08" & goto :desktop
			if "!errorlevel!" equ "53" goto :desktop
			goto :loop_5
			
	:program_calculator
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Calculator:"
		echo -cgd %theme3% 3 4 "Calculation : "
		echo -cgad %theme2% 1 6 175 " Result : " -cd %theme4% "-"
		
		echo -h 1
		echo -cg %theme4% 17 4
		set /p "program_calculator_calculation="
		echo -h 0
		
		set /a "program_calculator_result=%program_calculator_calculation%" > nul 2>&1 || set "program_calculator_result=Error."
		echo -cgd %theme4% 12 6 "%program_calculator_result%"
		
		echo -cgad %theme2% 1 8 175 " Choose option:"
		echo -cgd %theme3% 3 9 "{1} Again"
		echo -cgd %theme3% 3 10 "{2} Back to desktop"
		
		:loop_6
			darkbox_i -k
			if "!errorlevel!" equ "49" goto :program_calculator
			if "!errorlevel!" equ "50" goto :desktop
			goto :loop_6
		
	:program_single_note
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Single Note"
		
		echo -cgad %theme2% 1 5 175 " Choose option:"
		echo -cgd %theme3% 3 6 "{1} View notes"
		echo -cgd %theme3% 3 7 "{2} Add note"
		echo -cgd %theme3% 3 8 "{3} Delete all notes"
		echo -cgd %theme3% 3 9 "{4} Back to desktop"
		
		:loop_7
			darkbox_i -k
			if "!errorlevel!" equ "49" goto :program_single_note_view_notes
			if "!errorlevel!" equ "50" goto :program_single_note_add_note
			if "!errorlevel!" equ "51" goto :program_single_note_delete_all_notes
			if "!errorlevel!" equ "52" goto :desktop
			goto :loop_7
			
		:program_single_note_view_notes
			call :draw_ui
			
			echo -cgad %theme2% 1 3 175 " Single Note - View"
			
			set counter=1
			set posy_counter=4
			for /f "tokens=1*" %%i in (users/%login_username%/single_note.txt) do (
				echo -cgd %theme3% 3 !posy_counter! "!counter!. " -cd %theme4% "%%i %%j"
				set /a counter+=1
				set /a posy_counter+=1
			)
			set /a posy_counter+=1
			set /a posy_counter_option1=%posy_counter%+1
			set /a posy_counter_option2=%posy_counter_option1%+1
			echo -cgad %theme2% 1 %posy_counter% 175 " Choose option:"
			echo -cgd %theme3% 3 %posy_counter_option1% "{1} Back to Single Note"
			echo -cgd %theme3% 3 %posy_counter_option2% "{2} Back to desktop"
			
			:loop_8
				darkbox_i -k
				if "!errorlevel!" equ "49" goto :program_single_note
				if "!errorlevel!" equ "50" goto :desktop
				goto :loop_8
			
		:program_single_note_add_note
			call :draw_ui
			
			echo -cgad %theme2% 1 3 175 " Single Note - Add"
			echo -cgd %theme3% 3 4 "Text : "
			
			echo -h 1
			echo -cg %theme4% 10 4
			set /p "program_single_note_add_note_text="
			echo;%program_single_note_add_note_text%>> "users/%login_username%/single_note.txt"
			echo -h 0
			
			echo -cgad %theme2% 1 6 175 " Saved^!"
			echo -w 1000
			
			goto :program_single_note
			
		:program_single_note_delete_all_notes
			call :draw_ui
			
			echo -cgad %theme2% 1 3 175 " Single Note - Delete"
			
			echo -cgad %theme2% 1 5 175 " Are you sure you want delete all notes?"
			echo -cgd %theme3% 3 6 "{1} Yes"
			echo -cgd %theme3% 3 7 "{2} No"
			
			:loop_9
				darkbox_i -k
				if "!errorlevel!" equ "49" (
					echo;|set /p ".=" > "users/%login_username%/single_note.txt"
					echo -cgad %theme2% 1 9 175 " Deleted all notes^!"
					echo -w 1000
					goto :program_single_note
				)
				if "!errorlevel!" equ "50" goto :program_single_note
				goto :loop_9
				
	:program_terminal
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Terminal"
		echo -cgd %theme3% 3 4 "Command : "
		
		set "program_terminal_command="
		echo -h 1
		echo -cg %theme4% 13 4
		set /p "program_terminal_command="
		echo -h 0
		
		if "%program_terminal_command%" equ "" goto :desktop
		
		echo -cgad %theme2% 1 6 175 " Executing command..."
		
		echo;|set /p ".=" > "users/%login_username%/terminal_output.txt"
		%program_terminal_command% >> "users/%login_username%/terminal_output.txt"
		
		echo -cgd %theme2% 1 6 "                     "
		
		set counter=1
		set posy_counter=6
		for /f "tokens=1*" %%i in (users/%login_username%/terminal_output.txt) do (
			echo -cga %theme3% 3 !posy_counter! 177 -cd %theme4% " %%i %%j"
			set /a counter+=1
			set /a posy_counter+=1
		)
		
		pause > nul
		goto :program_terminal
		
	:program_music_player
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Music Player"
		
		echo -cgad %theme2% 1 5 175 " Choose option:"
		echo -cgd %theme3% 3 6 "{1} Play music"
		echo -cgd %theme3% 3 7 "{2} Stop music"
		echo -cgd %theme3% 3 8 "{3} Back to desktop"
		
		:loop_10
				darkbox_i -k
				if "!errorlevel!" equ "49" goto :program_music_player_play
				if "!errorlevel!" equ "50" taskkill /f /im "dlc.exe" & goto :desktop
				if "!errorlevel!" equ "51" goto :desktop
				goto :loop_10
		
		:program_music_player_play
			call :draw_ui
			
			echo -cgad %theme2% 1 3 175 " Music Player - Play"
			echo -cgd %theme3% 3 4 "Filename : "
			
			set "program_music_player_play_command="
			echo -h 1
			echo -cg %theme4% 14 4
			set /p "program_music_player_play_command="
			echo -h 0
			
			if "%program_music_player_play_command%" equ "" goto :desktop
			
			start /b "" "dlc.exe" -p "users/%login_username%/%program_music_player_play_command%" > nul
			
			goto :desktop
			
	:program_ping
		call :draw_ui
		
		echo -cgad %theme2% 1 3 175 " Ping"
		echo -cgd %theme3% 3 4 "Destination : "
		echo -cgd %theme3% 3 5 "Port : "
		
		set "program_ping_command_destination="
		echo -h 1
		echo -cg %theme4% 17 4
		set /p "program_ping_command_destination="
		echo -h 0
		
		if "%program_ping_command_destination%" equ "" goto :desktop
		
		set "program_ping_command_port="
		echo -h 1
		echo -cg %theme4% 10 5
		set /p "program_ping_command_port="
		echo -h 0
		
		if "%program_ping_command_port%" equ "" set "port=80"
		
		echo -cgad %theme2% 1 7 175 " Pinging..."
		
		echo;|set /p ".=" > "users/%login_username%/ping_output.txt"
		paping.exe --nocolor --count 3 --port %program_ping_command_port% %program_ping_command_destination% >> "users/%login_username%/ping_output.txt"
		
		echo -cgd %theme2% 1 7 "           "
		
		set counter=1
		set posy_counter=7
		for /f "tokens=1*" %%i in (users/%login_username%/ping_output.txt) do (
			echo -cga %theme3% 3 !posy_counter! 177 -cd %theme4% " %%i %%j"
			set /a counter+=1
			set /a posy_counter+=1
		)
		
		pause > nul
		goto :desktop
		