; Muhammad Ateeb i220888 C

INCLUDE Irvine32.inc
INCLUDE macros.inc
includelib Winmm.lib
BUFFER_SIZE = 10

.data
; win
win1 db "                                                        .---.                       ",0ah,0
win2 db "        ,---,                                          /. ./|                       ",0ah,0
win3 db "       /_ ./|   ,---.           ,--,               .--'.  ' ;   ,---.        ,---,  ",0ah,0
win4 db " ,---, |  ' :  '   ,'\        ,'_ /|              /__./ \ : |  '   ,'\   ,-+-. /  | ",0ah,0
win5 db "/___/ \.  : | /   /   |  .--. |  | :          .--'.  '   \' . /   /   | ,--.'|'   | ",0ah,0
win6 db " .  \  \ ,' '.   ; ,. :,'_ /| :  . |         /___/ \ |    ' '.   ; ,. :|   |  ,'' | ",0ah,0
win7 db "  \  ;  `  ,''   | |: :|  ' | |  . .         ;   \  \;      :'   | |: :|   | /  | | ",0ah,0
win8 db "   \  \    ' '   | .; :|  | ' |  | |          \   ;  `      |'   | .; :|   | |  | | ",0ah,0
win9 db "    '  \   | |   :    |:  | : ;  ; |           .   \    .\  ;|   :    ||   | |  |/  ",0ah,0
wina db "     \  ;  ;  \   \  / '  :  `--'   \           \   \   ' \ | \   \  / |   | |--'   ",0ah,0
winb db "      :  \  \  `----'  :  ,      .-./            :   '  |--''   `----'  |   |/       ",0ah,0
winc db "       \  ' ;           `--`----'                 \   \ ;              '---'        ",0ah,0
wind db "        `--`                                       '---''                            ",0ah,0
;game oever 
gameover1 db " ****      *     **      ** ****  **** *          * ****  ******     ",0ah,0                   
gameover2 db " *        * *    * *    * * *     *  *  *        *  *     *    *     ",0ah,0 
gameover3 db " * * *   *   *   *  *  *  * *     *  *   *      *   ****  ******     ",0ah,0 
gameover4 db " *   *  *     *  *   *    * ****  *  *    *    *    *     *     *    ",0ah,0
gameover5 db " *   * ********* *        * *     *  *     *  *     *     *      *   ",0ah,0
gameover6 db "  ***  *       * *        * ****  ****      *       ****  *       *  ",0ah,0
; instructions
T1 BYTE "    +--------------------------+     ", 0ah,0
T2 BYTE "    |      Instructions     |", 0ah,0   
T3 BYTE "    +--------------------------+     ",0ah, 0
i_1 BYTE "    +--------------------------+     ", 0ah,0
i_2 BYTE "    | [1] press w to move up   |     ", 0ah,0
i_3 BYTE "    | [2] press w to move up   |     ", 0ah,0
i_4 BYTE "    | [3] press w to move up   |     ", 0ah,0
i_5 BYTE "    | [4] press w to move up   |     ", 0ah,0
i_6 BYTE "    | [5] press w to move up   |     ", 0ah,0
i_7 BYTE "    +--------------------------+     ",0ah, 0

i_8 BYTE "    +--------------------------+     ",0ah, 0

;sound
beginSound BYTE "D:\asds\sound\pacman_beginning.wav", 0
death BYTE "D:\asds\sound\pacman_death.wav", 0
wave BYTE "D:\asds\sound\waka.wav", 0
PlaySoundA PROTO,
pszSound:PTR BYTE, 
hmod:DWORD, 
fdwSound:DWORD
SND_ASY   equ 00000001h
SND_NOWAIT  equ 00002000h

; fruit
collected db 0
xfPos BYTE ?
yfPos BYTE ?
;game_ovr
stay dword 0
;level1
level_1 byte "------------------------------------------------------------------------------------------------------------------------",0ah,
             "-----------------------------------------------------LEVEL   ------------------------------------------------------------",0
lvl db 1
flick_lvl db 0
; Game Grid
EMPTY_CELL equ 0
WALL_CELL equ 1
FOOD_CELL equ 3
gameGrid byte 30 DUP (120 DUP (?))
; pause
resumeWindowLine1 BYTE "    +------------------------+", 0ah,0
resumeWindowLine2 BYTE "    |        Resume?         |", 0ah,0
resumeWindowLine3 BYTE "    +------------------------+", 0ah,0
resumeWindowLine4 BYTE "    |  [1] Yes, Resume       |", 0ah,0
resumeWindowLine5 BYTE "    |  [2] Main Menu         |", 0ah,0
resumeWindowLine6 BYTE "    +------------------------+", 0
; menu
menuTitleLine1 BYTE "    +--------------------------+     ", 0ah,0
menuTitleLine2 BYTE "    |      Main Menu      |", 0ah,0
menuTitleLine3 BYTE "    +--------------------------+     ",0ah, 0

menuOptionsLine1 BYTE "    +--------------------------+     ", 0ah,0
menuOptionsLine2 BYTE "    | [1] Start Game           |     ", 0ah,0
menuOptionsLine3 BYTE "    | [2] Instructions         |     ", 0ah,0
menuOptionsLine4 BYTE "    | [3] High Scores          |     ", 0ah,0
menuOptionsLine5 BYTE "    | [4] Settings             |     ", 0ah,0
menuOptionsLine6 BYTE "    | [5] Exit                 |     ", 0ah,0
menuOptionsLine7 BYTE "    +--------------------------+     ",0ah, 0

menuBottomLine1 BYTE "    +--------------------------+     ",0ah, 0
; file handle
Levelbuffer byte BUFFER_SIZE DUP(?)
buffer BYTE BUFFER_SIZE DUP(?)
    filename BYTE "helo.txt", 0
    fileHandle HANDLE ?
    stringLength DWORD ?
    bytesWritten DWORD ?
    separator db "-------", 0 ; Assuming is your separator

    str1 BYTE "Cannot create file ", 0
    str3 BYTE "Enter your name and press [Enter]: ", 0
;tile
title1 byte "                                                                               ", 0ah, 0
title2 byte " _ __   __ _  ___ _ __ ___   __ _ _ __     ", 0ah, 0
title3 byte "| '_ \ / _` |/ __| '_ ` _ \ / _` | '_ \ ", 0ah, 0
title4 byte "| |_) | (_| | (__| | | | | | (_| | | | | ", 0ah, 0
title5 byte "| .__/ \__,_|\___|_| |_| |_|\__,_|_| |_|      ", 0ah, 0
title6 byte "|_|     ", 0ah, 0
title7 byte "                                                                               ", 0ah, 0
outhandle dword ?
inhandle dword ?
x dword ?
;logo
logoLine1  byte  "                  " ,0ah,0
logoLine2  byte  "      -----   " ,0ah,0
logoLine3 byte  "   /           \  " ,0ah,0
logoLine4 byte  "  / 0         0 \ " ,0ah,0
logoLine5 byte  " |               |" ,0ah,0
logoLine6 byte  "  \      -      / " ,0ah,0
logoLine7 byte  "   \           /  " ,0ah,0
logoLine8 byte  "       -----   " ,0ah,0
logoLine9 byte  "                  " ,0ah,0
ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0

temp byte ?

strScore BYTE "Your score is: ",0
score word 0

life BYTE "Lives: ",0
lives word 3

xPos BYTE ?
yPos BYTE ?
;ghost1
xG1Pos BYTE ?
yG1Pos BYTE ?
direction db 0
pos_g_f db 0
;ghost 2
xG2Pos BYTE ?
yG2Pos BYTE ?
direction1 db 0
pos_g_f_1 db 0
;ghost 3
xG3Pos BYTE ?
yG3Pos BYTE ?
direction3 db 0
pos_g_f_3 db 0
inputChar BYTE ?

.code

display proc

invoke getstdhandle, -11
mov outhandle, eax
invoke getstdhandle, -10
mov inhandle, eax

    invoke SetConsoleTextAttribute, outhandle, 00000011b
    invoke WriteConsoleA, outhandle, ADDR title1, LENGTHOF title1, ADDR x, 0
     mov  dl,40 ;column
     mov  dh,3 ;row
     call Gotoxy
    invoke SetConsoleTextAttribute, outhandle, 00001010b
    invoke WriteConsoleA, outhandle, ADDR title2, LENGTHOF title2, ADDR x, 0
      mov  dl,40 ;column
     mov  dh,4 ;row
     call Gotoxy
    invoke SetConsoleTextAttribute, outhandle, 00001001b
    invoke WriteConsoleA, outhandle, ADDR title3, LENGTHOF title3, ADDR x, 0
    mov  dl,40 ;column
     mov  dh,5 ;row
     call Gotoxy
    invoke SetConsoleTextAttribute, outhandle, 00000001b
    invoke WriteConsoleA, outhandle, ADDR title4, LENGTHOF title4, ADDR x, 0
     mov  dl,40 ;column
     mov  dh,6 ;row
     call Gotoxy
    invoke SetConsoleTextAttribute, outhandle, 00001110b
    invoke WriteConsoleA, outhandle, ADDR title5, LENGTHOF title5, ADDR x, 0
     mov  dl,40 ;column
     mov  dh,7 ;row
     call Gotoxy
    invoke SetConsoleTextAttribute, outhandle, 00000101b
    invoke WriteConsoleA, outhandle, ADDR title6, LENGTHOF title6, ADDR x, 0
    
    invoke SetConsoleTextAttribute, outhandle, 00001101b
    invoke WriteConsoleA, outhandle, ADDR title7, LENGTHOF title7, ADDR x, 0
    call Crlf

    ;color
    mov eax,white
    call settextcolor
    ; Display game logo
     mov  dl,40 ;column
     mov  dh,9;row
     call Gotoxy
    mov edx, OFFSET logoLine1
    call WriteString
    call Crlf
      mov  dl,40 ;column
     mov  dh,10;row
     call Gotoxy
    mov edx, OFFSET logoLine2
    call WriteString
    call Crlf
      mov  dl,40 ;column
     mov  dh,11;row
     call Gotoxy
    mov edx, OFFSET logoLine3
    call WriteString
    call Crlf
      mov  dl,40 ;column
     mov  dh,12;row
     call Gotoxy
    mov edx, OFFSET logoLine4
    call WriteString
    call Crlf
     mov  dl,40 ;column
     mov  dh,13;row
     call Gotoxy
    mov edx, OFFSET logoLine5
    call WriteString
    call Crlf
     mov  dl,40 ;column
     mov  dh,14;row
     call Gotoxy
    mov edx, OFFSET logoLine6
    call WriteString
    call Crlf
     mov  dl,40 ;column
     mov  dh,15;row
     call Gotoxy
    mov edx, OFFSET logoLine7
    call WriteString
    call Crlf
     mov  dl,40 ;column
     mov  dh,16;row
     call Gotoxy
    mov edx, OFFSET logoLine8
    call WriteString
     mov  dl,40 ;column
     mov  dh,17;row
     call Gotoxy
    mov edx, OFFSET logoLine9
    call WriteString
    call Crlf
    call Crlf
   
    ; Wait for user input or continue with your game initialization
    call WaitMsg
    ; Continue with the rest of your game setup...
    call Clrscr
    ret
display endp
user_name proc
    ; Create a new text file.
    
    invoke CreateFile, ADDR filename, FILE_APPEND_DATA, FILE_SHARE_READ, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
    mov fileHandle, eax

    cmp eax, INVALID_HANDLE_VALUE
    je error

    ; Prompt user for input
    mov edx, OFFSET str3
    call WriteString

    ; Input a string
    mov ecx, BUFFER_SIZE
    mov edx, OFFSET buffer
    call ReadString
    ; Get the length of the string
    mov stringLength, eax
    ; Write the buffer to the output file.
    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, stringLength
    call WriteToFile
    ; Write the buffer to the output file.
    mov eax, fileHandle
    mov edx, OFFSET separator
    mov ecx, sizeof separator
    call WriteToFile
    call close_file
    call clrscr
    ret

    error:
        mov edx, OFFSET str1
        call WriteString
        jmp quit

    quit:
        call clrscr
        ret
user_name endp
border proc
; draw ground at (0,29):
    mov eax,blue +(blue * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    
    mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    loop l1

    mov temp,0

    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2
    ret
border endp
ghost1_mov proc
cmp pos_g_f,1
jne norm
jmp no_upd_g1
norm:
call UpdateG1 
no_upd_g1:
cmp direction,1
jne dir
inc xG1Pos
ret
 dir:
dec xG1Pos 
ret
ghost1_mov endp

ghost2_mov proc
cmp pos_g_f_1,1
jne norm
jmp no_upd_g2
norm:
call UpdateG2 
no_upd_g2:
cmp direction1,1
jne dir
inc yG2Pos
ret
 dir:
dec yG2Pos 
ret
ghost2_mov endp
ghost3_mov proc
cmp pos_g_f_3,1
jne norm
jmp no_upd_g3
norm:
call UpdateG3 
no_upd_g3:
cmp direction3,1
jne dir
inc yG3Pos
ret
 dir:
dec yG3Pos 
ret
ghost3_mov endp
which_way proc
cmp direction,1
    jne lft
    call chkWallsRight_g1
    jmp monster
    lft:
    call chkWallsLeft_g1
    monster:
    ret
which_way endp
which_way2 proc
cmp direction1,1
    jne up
    call chkWallsdown_g2
    jmp monster
    up:
    call chkWallsup_g2
    monster:
    ret
which_way2 endp
which_way3 proc
cmp direction3,1
    jne up
    call chkWallsdown_g3
    jmp monster
    up:
    call chkWallsup_g3
    monster:
    ret
which_way3 endp
show_life proc
mov dl,110
        mov dh,0
        call Gotoxy
        mov edx,OFFSET life
        call WriteString
        mov ax,lives
        call WriteInt
        ret
show_life endp
draw_score proc
   mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov ax,score
        call WriteInt
        ret
draw_score endp
ghst_ply_col proc
mov al,yG1Pos
cmp al,yPos
jne no_col
mov al,xG1Pos
cmp al,xPos
jne no_col
invoke PlaySoundA, ADDR death, NULL, SND_ASY or SND_NOWAIT
dec lives
 mov xPos,2
 mov yPos,28
 call DrawPlayer
no_col:
ret
ghst_ply_col endp
;g2
ghst2_ply_col proc
mov al,yG2Pos
cmp al,yPos
jne no_col
mov al,xG2Pos
cmp al,xPos
jne no_col
invoke PlaySoundA, ADDR death, NULL, SND_ASY or SND_NOWAIT
dec lives
 mov xPos,2
 mov yPos,28
 call DrawPlayer
no_col:
ret
ghst2_ply_col endp
;ghost 3
ghst3_ply_col proc
mov al,yG3Pos
cmp al,yPos
jne no_col
mov al,xG3Pos
cmp al,xPos
jne no_col
invoke PlaySoundA, ADDR death, NULL, SND_ASY or SND_NOWAIT
dec lives
 mov xPos,2
 mov yPos,28
 call DrawPlayer
no_col:
ret
ghst3_ply_col endp
change_lvl proc
mov esi,offset gameGrid+120+120+120+120+120+120
mov ecx,2280
again:
mov al,byte ptr[esi]
cmp al,FOOD_CELL
je lvl_same
inc esi
loop again
inc lvl
mov flick_lvl,1
lvl_same:
ret
change_lvl endp
fruit_checking proc
 mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xfPos    ; Current x position
        sub dl,1
        mov al, yfPos    ; Current y position
        dec al
        mov bl,al
        mov eax,ebx
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al, byte ptr [gameGrid + edx]
ret
fruit_checking endp
fruit_ply_col proc
 ; getting points:
        mov bl,xPos
        cmp bl,xfPos
        jne notCollecting
        mov bl,yPos
        cmp bl,yfPos
        jne notCollecting
        ; player is intersecting coin:
        call fruit_checking
        cmp al,2
        jne notCollecting
        add score,5
         mov byte ptr [gameGrid + edx],0
        notCollecting:
        cmp stay,600
        jne no_need
        mov stay,0
        call CreateFruit
        call DrawFruit
        ret
        no_need:
        cmp stay,200
        jng moveON
        call fruit_checking
        cmp al,2
        jne moveOn
        mov byte ptr [gameGrid + edx],0
        call updateFruit
        moveOn:
        inc stay
ret
fruit_ply_col endp
updateFruit PROC
    mov dl,xfPos
    mov dh,yfPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
updateFruit ENDP
DrawFruit PROC
    mov eax,red ;(red * 16)
    call SetTextColor
    mov dl,xfPos
    mov dh,yfPos
    call Gotoxy
    mov al,"F"
    call WriteChar
    call bigFruit
    ret
DrawFruit ENDP
CreateFruit PROC
    mov eax,55
    inc eax
    call RandomRange
    mov xfPos,al
    cmp xfPos,2
    je increase
    cmp xfPos,118
    jne no_adjust
    dec xfPos
    jmp no_adjust
    increase:
    inc xfPos
    no_adjust:
    cmp yfPos,28
    jne fruit_up
    mov yfPos,6
    ret
    fruit_up:
    mov yfPos,28
    ret
CreateFruit ENDP
displayMainMenu PROC
 ;color
    mov eax,black+(red*16)
    call settextcolor
     mov  dl,40 ;column
     mov  dh,5;row
     call Gotoxy
    ; Display menu title
    mov edx, OFFSET menuTitleLine1
    call WriteString
     mov  dl,40 ;column
     mov  dh,6;row
     call Gotoxy
    mov edx, OFFSET menuTitleLine2
    call WriteString
     mov  dl,40 ;column
     mov  dh,7;row
     call Gotoxy
    mov edx, OFFSET menuTitleLine3
    call WriteString
     mov  dl,40 ;column
     mov  dh,8;row
     call Gotoxy
     mov eax,black+(white*16)
     call settextcolor
    ; Display menu options
    mov edx, OFFSET menuOptionsLine1
    call WriteString
     mov  dl,40 ;column
     mov  dh,9;row
     call Gotoxy
    mov edx, OFFSET menuOptionsLine2
    call WriteString
     mov  dl,40 ;column
     mov  dh,10;row
     call Gotoxy
    mov edx, OFFSET menuOptionsLine3
    call WriteString
     mov  dl,40 ;column
     mov  dh,11;row
     call Gotoxy
    mov edx, OFFSET menuOptionsLine4
    call WriteString
     mov  dl,40 ;column
     mov  dh,12;row
     call Gotoxy
    mov edx, OFFSET menuOptionsLine5
    call WriteString
     mov  dl,40 ;column
     mov  dh,13;row
     call Gotoxy
    mov edx, OFFSET menuOptionsLine6
    call WriteString
     mov  dl,40 ;column
     mov  dh,14;row
     call Gotoxy
    mov edx, OFFSET menuOptionsLine7
    call WriteString
     mov  dl,40 ;column
     mov  dh,15;row
     call Gotoxy
    ; Display menu bottom
    mov edx, OFFSET menuBottomLine1
    call WriteString
    mov eax,white+(black*16)
    call settextcolor
    ; Wait for user input or handle menu selection
    ret
displayMainMenu ENDP
instruction proc
 ;color
    mov eax,black+(red*16)
    call settextcolor
     mov  dl,40 ;column
     mov  dh,5;row
     call Gotoxy
    ; Display menu title
    mov edx, OFFSET T1
    call WriteString
     mov  dl,40 ;column
     mov  dh,6;row
     call Gotoxy
    mov edx, OFFSET T2
    call WriteString
     mov  dl,40 ;column
     mov  dh,7;row
     call Gotoxy
    mov edx, OFFSET T3
    call WriteString
     mov  dl,40 ;column
     mov  dh,8;row
     call Gotoxy
     mov eax,black+(white*16)
     call settextcolor
    ; Display menu options
    mov edx, OFFSET i_1
    call WriteString
     mov  dl,40 ;column
     mov  dh,9;row
     call Gotoxy
    mov edx, OFFSET i_2
    call WriteString
     mov  dl,40 ;column
     mov  dh,10;row
     call Gotoxy
    mov edx, OFFSET i_3
    call WriteString
     mov  dl,40 ;column
     mov  dh,11;row
     call Gotoxy
    mov edx, OFFSET i_4
    call WriteString
     mov  dl,40 ;column
     mov  dh,12;row
     call Gotoxy
    mov edx, OFFSET i_5
    call WriteString
     mov  dl,40 ;column
     mov  dh,13;row
     call Gotoxy
    mov edx, OFFSET i_6
    call WriteString
     mov  dl,40 ;column
     mov  dh,14;row
     call Gotoxy
    mov edx, OFFSET i_7
    call WriteString
     mov  dl,40 ;column
     mov  dh,15;row
     call Gotoxy
    ; Display menu bottom
    mov edx, OFFSET i_1
    call WriteString
    mov eax,white+(black*16)
    call settextcolor
    ret
instruction endp
draw_teleport proc
mov eax,green+(black*16)
call settextcolor
mov dl,1
mov dh,6
call gotoxy
mwrite "$"
mov dl,1
mov dh,28
call gotoxy
mwrite "$"
mov dl,118
mov dh,6
call gotoxy
mwrite "$"
mov dl,118
mov dh,28
call gotoxy
mwrite "$"
ret
draw_teleport endp
game_play proc
    lets_go:
    call displayMainMenu
    LookForKey:
     mov  eax,50          ; sleep, to allow OS to time slice
    call Delay           ; (otherwise, some key presses are lost)

    call ReadKey         ; look for keyboard input
    jz   LookForKey      ; no key pressed yet
    cmp al, '1'
    je option1
    cmp al, '2'
    je option2
    cmp al, '3'
    je option3
    cmp al, '4'
    je option4
    cmp al, '5'
    je  exitGame
    jmp LookForKey
    ; ...
     option1:
    jmp strt
    option2:
    ; Your code for option 2
    call Clrscr
    call instruction
    call waitmsg
    call Clrscr
    jmp lets_go
    ; ...

    option3:
    ; Your code for option 3
    call Clrscr
    jmp LookForKey
    ; ...

    option4:
    ; Your code for option 4
    call Clrscr
    jne    LookForKey    ; no, go get next key.
    strt:
    call Clrscr
    invoke PlaySoundA, ADDR beginSound, NULL, SND_ASY or SND_NOWAIT
    mov flick_lvl,0
    mov xG1Pos,108
    mov yG1Pos,11
    mov xPos,15
    mov yPos,28
    cmp lvl,1
    jne chk_nxt
    call InitGameGrid
    jmp  game_walls
    chk_nxt:
    cmp lvl,2
    jne chk_nxt1
    mov yG1Pos,10
    call InitGameGrid2
    jmp  game_walls
    chk_nxt1:
    mov yG1Pos,20
    call InitGameGrid3 
    game_walls:
    call DrawGameGrid
    call border
    call DrawPlayer
    cmp lvl,1
    je here
    mov xG2Pos,22
    mov yG2Pos,16
    call G2Draw
    call CreateFruit
    call DrawFruit
    call Randomize
    here:
    call G1Draw
    cmp lvl,3
    jne gameloop
    call draw_teleport
    mov xG3Pos,68
    mov yG3Pos,16
    call G3Draw
    gameLoop:
    call ghst_ply_col
    call chk_food
    cmp lvl,1
    je s1
    call ghst2_ply_col
    call chk_food2
    call fruit_ply_col
    call which_way2
    call ghost2_mov
    call G2Draw
    call ghst2_ply_col
    s1:
    cmp lvl,3
    jne s2
    call ghst3_ply_col
    call chk_food3
    call which_way3
    call ghost3_mov
    call G3Draw
    call ghst3_ply_col
    s2:
    call which_way
    call ghost1_mov
    call G1Draw
    call ghst_ply_col
    cmp lives,1
    jl Over
    call change_lvl
    cmp flick_lvl,1
    jne no_lvl_chng
    call make_empty
    cmp lvl,4
    je win
    jmp strt
    no_lvl_chng:
     mov eax,white (black * 16)
     call SetTextColor

        call show_life
        call draw_score
        ;get user key input:
        mov  eax,40          ; sleep, to allow OS to time slice
        call Delay           ; (otherwise, some key presses are lost)
        call Readkey
        jz   gameLoop       ; no key pressed yet
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        cmp inputChar,"p"
        je stop
        moveUp:
        ; check if the cell above Pac-Man is not a wall
        call chkWallsUp
        cmp al, WALL_CELL
        je gameLoop ; If it's a wall, don't move
        cmp yPos,6
        je gameLoop
        invoke PlaySoundA, ADDR wave, NULL, SND_ASY or SND_NOWAIT
            call UpdatePlayer
            dec yPos
            call DrawPlayer
        jmp gameLoop

        moveDown:
        call chkWallsDown
        cmp al, WALL_CELL
        je gameLoop ; If it's a wall, don't move
        cmp yPos,28
        je gameLoop
         invoke PlaySoundA, ADDR wave, NULL, SND_ASY or SND_NOWAIT
         call UpdatePlayer
         inc yPos
         call DrawPlayer
         jmp gameLoop

        moveLeft:
        call chkWallsLeft
        cmp al, WALL_CELL
        je gameLoop ; If it's a wall, don't move
        cmp xPos,1
        je gameLoop
        invoke PlaySoundA, ADDR wave, NULL, SND_ASY or SND_NOWAIT
        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

        moveRight:
        call chkWallsRight
        cmp al, WALL_CELL
        je gameLoop ; If it's a wall, don't move
        cmp xPos,118
        je gameLoop
        invoke PlaySoundA, ADDR wave, NULL, SND_ASY or SND_NOWAIT
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop

        stop:
        call clrscr
        pushad
        call Pause_game
        cmp al,2
        je menue
         popad
        call clrscr
        call DrawGameGrid
        call border
        call DrawPlayer
        jmp gameLoop
   
    exitGame:
    call clrscr
    exit
    ret
    win:
   call clrscr
   call you_won
   call waitmsg
   mov lives,3
   mov score,0
   mov lvl,1
   call clrscr
   jmp lets_go
    Over:
   call clrscr
   call ConvertAndWriteScoreAndLevel
   call game_over
   call waitmsg
   call make_empty
   mov lives,3
   mov score,0
   mov lvl,1
   call clrscr
   jmp lets_go
    menue:
    popad
    call clrscr
    call make_empty
    mov lives,3
    mov score,0
    mov lvl,1
    jmp lets_go
ret
game_play endp
you_won proc
;color
    dec lvl
    mov eax,magenta+(black*16)
    call settextcolor
     mov  dl,30 ;column
     mov  dh,5;row
     call Gotoxy
    mov edx, OFFSET win1
    call WriteString
     mov  dl,30 ;column
     mov  dh,6;row
     call Gotoxy
    mov edx, OFFSET win2
    call WriteString
     mov  dl,30 ;column
     mov  dh,7;row
     call Gotoxy
    mov edx, OFFSET win3
    call WriteString
     mov  dl,30 ;column
     mov  dh,8;row
     call Gotoxy
    mov edx, OFFSET win4
    call WriteString
     mov  dl,30 ;column
     mov  dh,9;row
     call Gotoxy
    mov edx, OFFSET win5
    call WriteString
     mov  dl,30 ;column
     mov  dh,10;row
     call Gotoxy
    mov edx, OFFSET win6
    call WriteString
      mov  dl,30 ;column
     mov  dh,11;row
     call Gotoxy
    mov edx, OFFSET win7
    call WriteString
      mov  dl,30 ;column
     mov  dh,12;row
     call Gotoxy
    mov edx, OFFSET win8
    call WriteString
      mov  dl,30 ;column
     mov  dh,13;row
     call Gotoxy
    mov edx, OFFSET win9
    call WriteString
      mov  dl,30 ;column
     mov  dh,14;row
     call Gotoxy
    mov edx, OFFSET wina
    call WriteString
    mov  dl,30 ;column
    mov  dh,15;row
    call Gotoxy
    mov edx, OFFSET winb
    call  WriteString
    mov  dl,30 ;column
    mov  dh,16;row
    call Gotoxy
    mov edx, OFFSET winc
    call WriteString
      mov  dl,30 ;column
     mov  dh,17;row
     call Gotoxy
    mov edx, OFFSET wind
    call WriteString
     mov  dl,30 ;column
     mov  dh,20;row
     call Gotoxy
    mwrite "level: "
    mov eax,0
    mov al,lvl
    call writedec
     mov  dl,40 ;column
     mov  dh,20;row
     call Gotoxy
     mwrite "score: "
     mov eax,0
     mov ax,score
     call writedec
     call Crlf
     mov eax,white+(black*16)
    call settextcolor
    ret
you_won endp
game_over proc
;color
    mov eax,magenta+(black*16)
    call settextcolor
     mov  dl,40 ;column
     mov  dh,5;row
     call Gotoxy
    mov edx, OFFSET gameover1
    call WriteString
     mov  dl,40 ;column
     mov  dh,6;row
     call Gotoxy
    mov edx, OFFSET gameover2
    call WriteString
     mov  dl,40 ;column
     mov  dh,7;row
     call Gotoxy
    mov edx, OFFSET gameover3
    call WriteString
     mov  dl,40 ;column
     mov  dh,8;row
     call Gotoxy
    ; Display menu options
    mov edx, OFFSET gameover4
    call WriteString
     mov  dl,40 ;column
     mov  dh,9;row
     call Gotoxy
    mov edx, OFFSET gameover5
    call WriteString
     mov  dl,40 ;column
     mov  dh,10;row
     call Gotoxy
    mov edx, OFFSET gameover6
    call WriteString
     mov  dl,40 ;column
     mov  dh,13;row
     call Gotoxy
    mwrite "level: "
    mov eax,0
    mov al,lvl
    call writedec
     mov  dl,70 ;column
     mov  dh,13;row
     call Gotoxy
     mwrite "score: "
     mov eax,0
     mov ax,score
     call writedec
     mov  dl,40 ;column
     mov  dh,15;row
     call Gotoxy
     mov edx,offset buffer
     call writestring
     call Crlf
     mov eax,white+(black*16)
    call settextcolor
    ret
ret
game_over endp
ConvertAndWriteScoreAndLevel proc
    ; Convert and write the score and level to the file
    ; Assume score and level are byte variables
    ; Convert score to ASCII
  ;  Convert level to ASCII
  invoke CreateFile, ADDR filename, FILE_APPEND_DATA, FILE_SHARE_READ, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
  mov fileHandle, eax
     mov eax, 0
     mov al, lvl
     mov ecx, 1
     mov edx, OFFSET Levelbuffer
     call ConvertByteToASCII
     mov eax, fileHandle
     mov edx, OFFSET Levelbuffer
     call WriteToFile
     call close_file
    ret
ConvertAndWriteScoreAndLevel endp
ConvertByteToASCII proc
    ; Convert a byte value in AL to ASCII and store it in the buffer
    add al, '0'
    mov [edx], al
    ret
ConvertByteToASCII endp
close_file proc
; Save return value
 mov bytesWritten, eax

     ;Close the file handle
     mov eax, fileHandle
    call CloseFile
    ret
close_file endp
main PROC
call display
call user_name
call game_play
exit
ret
main ENDP

DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"D"
    call WriteChar
    ret
DrawPlayer ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP
draw_food3 proc uses eax
   ;draw food at (xPos,yPos):
    mov eax,green ;(blue*16)
    call SetTextColor
    mov dl,temp
    mov dh,yG3Pos
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
draw_food3 endp
draw_food2 proc uses eax
   ;draw food at (xPos,yPos):
    mov eax,green ;(blue*16)
    call SetTextColor
    mov dl,temp
    mov dh,yG2Pos
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
draw_food2 endp
draw_food proc uses eax
   ;draw food at (xPos,yPos):
    mov eax,green ;(blue*16)
    call SetTextColor
    mov dl,temp
    mov dh,yG1Pos
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
draw_food endp
G1Draw PROC
    mov eax,magenta+(black * 16)
    call SetTextColor
    mov dl,xG1Pos
    mov dh,yG1Pos
    call Gotoxy
    mov al,"G"
    call WriteChar
    ret
G1Draw ENDP
G2Draw PROC
    mov eax,green+(black * 16)
    call SetTextColor
    mov dl,xG2Pos
    mov dh,yG2Pos
    call Gotoxy
    mov al,"G"
    call WriteChar
    ret
G2Draw ENDP
G3Draw PROC
    mov eax,cyan+(black * 16)
    call SetTextColor
    mov dl,xG3Pos
    mov dh,yG3Pos
    call Gotoxy
    mov al,"G"
    call WriteChar
    ret
G3Draw ENDP
 UpdateG1 PROC  uses eax
    mov dl,xG1Pos
    mov dh,yG1Pos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateG1 ENDP
 UpdateG2 PROC  uses eax
    mov dh,yG2Pos
    mov dl,xG2Pos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateG2 ENDP
UpdateG3 PROC  uses eax
    mov dh,yG3Pos
    mov dl,xG3Pos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateG3 ENDP
Pause_game proc
      
    ; Display the window
    mov  dl,40 ;column
     mov  dh,12;row
     call Gotoxy
    mov edx, OFFSET resumeWindowLine1
    call WriteString
    mov  dl,40 ;column
     mov  dh,13;row
     call Gotoxy
    mov edx, OFFSET resumeWindowLine2
    call WriteString
    mov  dl,40 ;column
     mov  dh,14;row
     call Gotoxy
    mov edx, OFFSET resumeWindowLine3
    call WriteString
    mov  dl,40 ;column
     mov  dh,15;row
     call Gotoxy
    mov edx, OFFSET resumeWindowLine4
    call WriteString
    mov  dl,40 ;column
     mov  dh,16;row
     call Gotoxy
    mov edx, OFFSET resumeWindowLine5
    call WriteString
    mov  dl,40 ;column
     mov  dh,17;row
     call Gotoxy
    mov edx, OFFSET resumeWindowLine6
    call WriteString
LookForKey2:
    mov  eax,50          ; sleep, to allow OS to time slice
    call Delay           ; (otherwise, some key presses are lost)

    call ReadKey         ; look for keyboard input
    jz   LookForKey2      ; no key pressed yet
    cmp al, '1'
    je option1
    cmp al, '2'
    je option2
    jne  LookForKey2    ; no, go get next key.
 
 option2:
  mov al,2
  ret
 option1:
 mov al,1
ret
Pause_game endp

; Function to initialize the game grid
InitGameGrid PROC
    ; Initialize  
   call Food
   mov esi, OFFSET [gameGrid+120+120+120+120+120+120+2]    
   mov ebx, WALL_CELL
   call Lines1_3
   add esi,4
   call Lines1_3
   add esi,4
   call Lines1_3
   add esi,4
   call Lines4_6
   add esi,4   
   call Lines4_6
   add esi,4   
   call Lines4_6
   add esi,4
   call Lines7_9
   add esi,4
   call Lines7_9
   add esi,4
   call Lines7_9
   add esi,4
   call Lines10_12
   add esi,4
   call Lines10_12
   add esi,4
   call Lines10_12
   add esi,4
   call Lines13_15
  
   add esi,4
   call Lines13_15
   add esi,4
   call Lines13_15
   add esi,4
   call Lines16_17
   add esi,4
   call Lines16_17
   add esi,4
   call Lines16_17
   add esi,4
   call Lines18_19
   add esi,4
   call Lines18_19
   add esi,4
   call Lines18_19 
    ret
InitGameGrid ENDP
; Function to initialize the game grid2
InitGameGrid2 PROC
    ; Initialize  
   call Food
   mov esi, OFFSET [gameGrid+120+120+120+120+120+120+2]    
   mov ebx, WALL_CELL
   call Lines1_3_g2
   add esi,4
   call Lines1_3_g2
   add esi,4    
   call Lines1_3_g2
   add esi,4  
   call Lines4_6_g2
   sub esi,50
   mov ecx,50
   f:
   mov byte ptr [esi],3
   inc esi
   loop f
   add esi,4    
   call Lines4_6_g2
   add esi,4    
   call Lines4_6_g2
    sub esi,50
   mov ecx,50
   f1:
   mov byte ptr [esi],3
   inc esi
   loop f1
   add esi,4    
   call Lines7_9_g2
   add esi,4    
   call Lines7_9_g2
   add esi,4    
   call Lines7_9_g2
   add esi,4
   call Lines10_12_g2
   add esi,4      
   call Lines10_12_g2
   add esi,4      
   call Lines10_12_g2
   add esi,4      
   call Lines13_15_g2
                  
   add esi,4      
   call Lines13_15_g2
   add esi,4      
   call Lines13_15_g2
   add esi,4      
   call Lines16_17_g2
   add esi,4      
   call Lines16_17_g2
   add esi,4      
   call Lines16_17_g2
   add esi,4      
   call Lines18_19_g2
   add esi,4      
   call Lines18_19_g2
   add esi,4      
   call Lines18_19_g2 
    ret
InitGameGrid2 ENDP
; Function to initialize the game grid3
InitGameGrid3 PROC
    ; Initialize  
   call Food
   mov esi, OFFSET [gameGrid+120+120+120+120+120+120+2]    
   mov ebx, WALL_CELL
   call Lines1_3_g3
   add esi,4
   call Lines1_3_g3
   add esi,4    
   call Lines1_3_g3
   add esi,4  
   call Lines4_6_g3
   sub esi,50
   mov ecx,50
   f:
   mov byte ptr [esi],3
   inc esi
   loop f
   add esi,4    
   call Lines4_6_g3
   add esi,4    
   call Lines4_6_g3
    sub esi,50
   mov ecx,50
   f1:
   mov byte ptr [esi],3
   inc esi
   loop f1
   add esi,4    
   call Lines7_9_g3
   add esi,4    
   call Lines7_9_g3
   add esi,4    
   call Lines7_9_g3
   add esi,4
   call Lines10_12_g3
   add esi,4        
   call Lines10_12_g3
   add esi,4        
   call Lines10_12_g3
   add esi,4        
   call Lines13_15_g3
                    
   add esi,4        
   call Lines13_15_g3
   add esi,4        
   call Lines13_15_g3
   add esi,4        
   call Lines16_17_g3
   add esi,4        
   call Lines16_17_g3
   add esi,4        
   call Lines16_17_g3
   add esi,4       
   call Lines18_19_g3
   add esi,4        
   call Lines18_19_g3
   add esi,4        
   call Lines18_19_g3 
    ret
InitGameGrid3 ENDP
; Function to draw the game grid
DrawGameGrid PROC
; top heading
    mov eax,black+(16*red)
    call settextcolor
   mov dl,1
   mov dh,2
   call gotoxy
   mWriteString OFFSET level_1 
   mov dl,60
   mov dh,4
   call gotoxy
   mov eax,0
   mov al,lvl
   call writedec 
    mov ecx, 30           ; Number of rows
    mov esi, OFFSET gameGrid   

drawRow:
    mov ebx, ecx          ; Current row number
    mov ecx, 120          ; Number of columns

drawCell:
    mov al,byte ptr[esi]
    ; Draw walls, or food based on the cell value
    cmp al, WALL_CELL
    je drawWall
    cmp al, FOOD_CELL
    je drawFood
    ; Handle other cases if needed
    jmp nextCell
drawWall:
    mov eax,0
    ; Draw wall character at the current position
    push ecx
    push ebx
    mov ebx,31
    pop eax
    sub ebx,eax
    mov dh, bl
    mov ebx,eax
    mov ecx,120
    pop eax
    sub ecx,eax
    mov dl, cl
    mov ecx,eax
    mov eax,brown+(16*black)
    call settextcolor
    call Gotoxy
    mwrite "="
    jmp nextCell
drawFood:
   mov eax,0
    ; Draw food character at the current position
    push ecx
    push ebx
    mov ebx,31
    pop eax
    sub ebx,eax
    mov dh, bl
    mov ebx,eax
    mov ecx,120
    pop eax
    sub ecx,eax
    mov dl, cl
    mov ecx,eax
    mov eax,white+(16*black)
    call settextcolor
    call Gotoxy
    mwrite "*"
nextCell:
    add esi, 1             ; Move to the next cell
    dec ecx
    jne drawCell
    ; Move to the next row
    mov ecx, ebx
    dec ecx
    jne drawRow

    ret
DrawGameGrid ENDP


chkWallsUp proc
        mov edx,0
        mov eax,0
        mov dl, xPos    ; Current x position
        mov al, yPos    ; Current y position
        sub al, 2       ; Move one cell up
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,FOOD_CELL
        jne return
        mov byte ptr [gameGrid + edx],0
        inc score
        return:
        cmp lvl,3
        jne return2
        cmp yPos,7
        jne return1
        cmp xPos,1
        jne return1
        call UpdatePlayer
        mov yPos,27
        return1:
        cmp xPos,118
        jne return2
        cmp yPos,7
        jne return2
        call UpdatePlayer
        mov yPos,27
        return2:
ret
chkWallsUp endp

chkWallsDown proc
        mov edx,0
        mov eax,0
        mov dl, xPos    ; Current x position
        mov al, yPos    ; Current y position
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,FOOD_CELL
        jne return
        mov byte ptr [gameGrid + edx],0
        inc score
        return:
        cmp lvl,3
        jne return2
         cmp yPos,27
        jne return1
        cmp xPos,1
        jne return1
        call UpdatePlayer
        mov yPos,7
        return1:
        cmp xPos,118
        jne return2
        cmp yPos,27
        jne return2
        call UpdatePlayer
        mov yPos,7
        return2:
ret
chkWallsDown endp

chkWallsRight proc
        mov edx,0
        mov eax,0
        mov dl, xPos    ; Current x position
        add dl,1
        mov al, yPos    ; Current y position
        dec al
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,FOOD_CELL
        jne return
        mov byte ptr [gameGrid + edx],0
        inc score
        return:
        cmp lvl,3
        jne return2
         cmp yPos,28
        jne return1
        cmp xPos,117
        jne return1
        call UpdatePlayer
        mov xPos,2
        return1:
         cmp yPos,6
        jne return2
        cmp xPos,117
        jne return2
        call UpdatePlayer
        mov xPos,2
        return2:
        ret
chkWallsRight endp

chkWallsLeft proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xPos    ; Current x position
        sub dl,1
        mov al, yPos    ; Current y position
        dec al
        mov bl,al
        mov eax,ebx
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,FOOD_CELL
        jne return
        mov byte ptr [gameGrid + edx],0
        inc score
        return:
        cmp lvl,3
        jne return2
        cmp yPos,28
        jne return1
        cmp xPos,2
        jne return1
        call UpdatePlayer
        mov xPos,117
        return1:
        cmp yPos,6
        jne return2
        cmp xPos,2
        jne return2
        call UpdatePlayer
        mov xPos,117
        return2:
        ret
chkWallsLeft endp
bigFruit proc
        mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xfPos    ; Current x position
        sub dl,1
        mov al, yfPos    ; Current y position
        dec al
        mov bl,al
        mov eax,ebx
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov byte ptr  [gameGrid + edx],2
ret
bigFruit endp
;;;g1
chkWallsLeft_g1 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG1Pos    ; Current x position
        sub dl,1
        mov al, yG1Pos    ; Current y position
        dec al
        mov bl,al
        mov eax,ebx
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,1
        jne bk
        mov direction,1
        ret
        bk:
        cmp xG1Pos,2
        jne bk1
        mov direction,1
        bk1:
        ret
chkWallsLeft_g1 endp
chkWallsRight_g1 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG1Pos    ; Current x position
        add dl,1
        mov al, yG1Pos    ; Current y position
        dec al
        mov bl,al
        mov eax,ebx
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,1
        jne bk
        mov direction,0
        ret
        bk:
        cmp xG1Pos,117
        jne bk1
        mov direction,0
        bk1:
        ret
chkWallsRight_g1 endp
chkWallsdown_g2 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG2Pos    ; Current x position
        mov al, yG2Pos    ; Current y position
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,1
        jne bk
        mov direction1,0
        ret
        bk:
        cmp yG2Pos,28
        jne bk1
        mov direction1,0
        bk1:
        ret
chkWallsdown_g2 endp
chkWallsdown_g3 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG3Pos    ; Current x position
        mov al, yG3Pos    ; Current y position
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,1
        jne bk
        mov direction3,0
        ret
        bk:
        cmp yG3Pos,28
        jne bk1
        mov direction3,0
        bk1:
        ret
chkWallsdown_g3 endp
chkWallsup_g2 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG2Pos    ; Current x position
        mov al, yG2Pos    ; Current y position
        sub al, 2       ; Move one cell up
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,1
        jne bk
        mov direction1,1
        ret
        bk:
        cmp yG2Pos,5
        jne bk1
        mov direction1,1
        bk1:
        ret
chkWallsup_g2 endp
chkWallsup_g3 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG3Pos    ; Current x position
        mov al, yG3Pos    ; Current y position
        sub al, 2       ; Move one cell up
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,1
        jne bk
        mov direction3,1
        ret
        bk:
        cmp yG3Pos,5
        jne bk1
        mov direction3,1
        bk1:
        ret
chkWallsup_g3 endp
chk_food2 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG2Pos    ; Current x position
        mov al, yG2Pos    ; Current y position
        dec al
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,3
        jne bk
        mov pos_g_f_1,1
        mov al,xG2pos
        mov temp,al
       call draw_food2
       ret
        bk:
        mov pos_g_f_1,0
        ret
chk_food2 endp
chk_food3 proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG3Pos    ; Current x position
        mov al, yG3Pos    ; Current y position
        dec al
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,3
        jne bk
        mov pos_g_f_3,1
        mov al,xG3pos
        mov temp,al
       call draw_food3
       ret
        bk:
        mov pos_g_f_3,0
        ret
chk_food3 endp
chk_food proc
mov ebx,0
        mov edx,0
        mov eax,0
        mov dl, xG1Pos    ; Current x position
        mov al, yG1Pos    ; Current y position
        dec al
        mov bl,al
        mov eax,ebx
        imul eax, 120    ; Multiply by the number of columns
        add edx, eax     ; Calculate the index
        mov al,byte ptr [gameGrid + edx] ; Read the value in the cell
        cmp al,3
        jne bk
        mov pos_g_f,1
        mov al,xG1pos
        mov temp,al
       call draw_food
       ret
        bk:
        mov pos_g_f,0
        ret
chk_food endp
Food proc
mov esi, OFFSET [gameGrid+120+120+120+120+120+120] 
mov ecx,20           ; Number of rows 

drawRow1:
    mov ebx, ecx          ; Current row number
    mov ecx,120          ; Number of columns

drawCell1:
    cmp ecx,120
    je no_add
    cmp ecx,1
    je no_add
    mov byte ptr[esi],3
    no_add:
    inc esi
    loop drawCell1
    mov ecx, ebx
    loop drawRow1

    ret
Food endp
make_empty proc
mov esi, OFFSET [gameGrid+120+120+120+120+120+120] 
mov ecx,21          ; Number of rows 

drawRow1:
    mov ebx, ecx          ; Current row number
    mov ecx, 120          ; Number of columns

drawCell1:
    cmp ecx,120
    je no_add
    cmp ecx,1
    je no_add
    mov byte ptr[esi],0
    no_add:
    inc esi
    loop drawCell1
    mov ecx, ebx
    loop drawRow1
    ret
make_empty endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Lines1_3_g2 proc
mov ecx, 116
   initRow:
   cmp ecx,70
   jle next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,60
   jle next1
   inc esi
   loop initRow
   next1:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines1_3_g2 endp
Lines4_6_g2 proc
mov ecx, 116
   initRow:
   cmp ecx,100
   jl next
   inc esi
   loop initRow
   next:
   cmp ecx,90
   jl next1
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next1:
   cmp ecx,70
   jl next2
   inc esi
   loop initRow
   next2:
   cmp ecx,60
   jl next3
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next3:
   cmp ecx,50
   jl next4
   inc esi
   loop initRow
   next4:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines4_6_g2 endp
Lines7_9_g2 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,89
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,80
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,58
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,53
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,48
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,18
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,10
   jl next7
   inc esi
   loop initRow
   next7:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines7_9_g2 endp
Lines10_12_g2 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,80
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,68
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,58
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,53
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,48
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,38
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,10
   jl next7
   inc esi
   loop initRow
   next7:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines10_12_g2 endp
Lines13_15_g2 proc
mov ecx, 116
   initRow:
   cmp ecx,102
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,90
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,80
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,48
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,38
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,10
   jl next5
   inc esi
   loop initRow
   next5:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines13_15_g2 endp
Lines16_17_g2 proc
mov ecx, 116
   initRow:
   cmp ecx,75
   jl next
   inc esi
   loop initRow
   next:
   cmp ecx,68
   jl next1
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next1:
   cmp ecx,58
   jl next2
   inc esi
   loop initRow
   next2:
   cmp ecx,53
   jl next3
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next3:
   cmp ecx,28
   jl next4
   inc esi
   loop initRow
   next4:
   cmp ecx,18
   jl next5
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next5:
   cmp ecx,10
   jl next6
   inc esi
   loop initRow
   next6:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines16_17_g2 endp
Lines18_19_g2 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,98
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,88
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,75
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,68
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,58
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,53
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,48
   jl next7
   inc esi
   loop initRow
   next7:
   cmp ecx,38
   jl next8
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next8:
   inc esi
   loop initRow
   ret
Lines18_19_g2 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Lines1_3 proc
mov ecx, 116
   initRow:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines1_3 endp
Lines4_6 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,70
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,60
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,10
   jl next3
   inc esi
   loop initRow
   next3:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines4_6 endp
Lines7_9 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,98
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,88
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,58
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,53
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,48
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,18
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,10
   jl next7
   inc esi
   loop initRow
   next7:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines7_9 endp
Lines10_12 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,86
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,68
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,58
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,53
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,28
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,18
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,10
   jl next7
   inc esi
   loop initRow
   next7:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines10_12 endp
Lines13_15 proc
mov ecx, 116
   initRow:
   cmp ecx,102
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,90
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,80
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,48
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,38
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,10
   jl next5
   inc esi
   loop initRow
   next5:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines13_15 endp
Lines16_17 proc
mov ecx, 116
   initRow:
   cmp ecx,75
   jl next
   inc esi
   loop initRow
   next:
   cmp ecx,68
   jl next1
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next1:
   cmp ecx,58
   jl next2
   inc esi
   loop initRow
   next2:
   cmp ecx,53
   jl next3
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next3:
   cmp ecx,28
   jl next4
   inc esi
   loop initRow
   next4:
   cmp ecx,18
   jl next5
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next5:
   cmp ecx,10
   jl next6
   inc esi
   loop initRow
   next6:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines16_17 endp
Lines18_19 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,98
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,88
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,75
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,68
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,58
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,53
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,48
   jl next7
   inc esi
   loop initRow
   next7:
   cmp ecx,38
   jl next8
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next8:
   inc esi
   loop initRow
   ret
Lines18_19 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Lines1_3_g3 proc
mov ecx, 116
   initRow:
   cmp ecx,70
   jle next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,60
   jle next1
   inc esi
   loop initRow
   next1:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines1_3_g3 endp
Lines4_6_g3 proc
mov ecx, 116
   initRow:
   cmp ecx,100
   jl next
   inc esi
   loop initRow
   next:
   cmp ecx,90
   jl next1
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next1:
   cmp ecx,70
   jl next2
   inc esi
   loop initRow
   next2:
   cmp ecx,60
   jl next3
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next3:
   cmp ecx,50
   jl next4
   inc esi
   loop initRow
   next4:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines4_6_g3 endp
Lines7_9_g3 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,89
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,80
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,58
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,53
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,48
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,18
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,10
   jl next7
   inc esi
   loop initRow
   next7:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines7_9_g3 endp
Lines10_12_g3 proc
mov ecx, 116
   initRow:
   cmp ecx,108
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,80
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,68
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,58
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,53
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,48
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,38
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   cmp ecx,28
   jl next7
   inc esi
   loop initRow
   next7:
   cmp ecx,18
   jl next8
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next8:
   inc esi
   loop initRow
   ret
Lines10_12_g3 endp
Lines13_15_g3 proc
mov ecx, 116
   initRow:
   cmp ecx,102
   jl next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,90
   jl next1
   inc esi
   loop initRow
   next1:
   cmp ecx,80
   jl next2
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next2:
   cmp ecx,58
   jl next3
   inc esi
   loop initRow
   next3:
   cmp ecx,53
   jl next4
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next4:
   cmp ecx,28
   jl next5
   inc esi
   loop initRow
   next5:
   cmp ecx,18
   jl next6
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next6:
   inc esi
   loop initRow
   ret
Lines13_15_g3 endp
Lines16_17_g3 proc
mov ecx, 116
   initRow:
   cmp ecx,80
   jl next
   inc esi
   loop initRow
   next:
   cmp ecx,75
   jl next1
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next1:
   cmp ecx,58
   jl next2
   inc esi
   loop initRow
   next2:
   cmp ecx,53
   jl next3
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next3:
   cmp ecx,28
   jl next4
   inc esi
   loop initRow
   next4:
   cmp ecx,18
   jl next5
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next5:
   cmp ecx,10
   jl next6
   inc esi
   loop initRow
   next6:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines16_17_g3 endp
Lines18_19_g3 proc
mov ecx, 116
   initRow:
   cmp ecx,70
   jle next
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   next:
   cmp ecx,60
   jle next1
   inc esi
   loop initRow
   next1:
   mov byte ptr [esi], bl
   inc esi
   loop initRow
   ret
Lines18_19_g3 endp
END main