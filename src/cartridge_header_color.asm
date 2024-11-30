	;==================================
	; The most recent version of the
	; a7800 header can be found here:
	; http://7800.8bitdev.org/index.php/A78_Header_Specification
	;==================================

	processor	6502
	org		$F000

	; This module inserts the 128-byte field for
	; use on the 7800 emulators

	; Header version 	1 byte 	0 / 0x00
	dc.b	$04

  	; ATARI7800 magic-text 	16 bytes 	1 / 0x01
        dc.b	"ATARI7800       "

  	; Cart title 	32 bytes 	17 / 0x11
	dc.b	"Color Demo (by John K. Harvey)  "

  	; Rom size without header 	4 bytes 	49 / 0x31
	; 16K header:
	;dc.b	$00,$00,$40,$00
	; 48K Header:
	dc.b	$00,$00,$c0,$00
	; 32K Header:
	;dc.b	$00,$00,$80,$00

  	; Cart type 	2 bytes 	53 / 0x35
  	; bit 0     = pokey at $4000
  	; bit 1     = supergame bank switched
  	; bit 2     = supergame ram at $4000
  	; bit 3     = rom at $4000
  	; bit 4     = bank 6 at $4000
  	; bit 5     = banked ram
  	; bit 6     = pokey at $450
  	; bit 7     = mirror ram at $4000
  	; bit 8     = activision banking
  	; bit 9     = absolute banking
  	; bit 10    = pokey at $440
  	; bit 11    = ym2151 at $460/$461
  	; bit 12    = souper
  	; bit 13    = banksets
  	; bit 14    = halt banked ram
  	; bit 15    = pokey@800
	dc.b	%00000000, %00001000

	; Controller 1 type 	1 byte 	55 / 0x37
 	; bit 0 = none
 	; bit 1 = 7800 joystick
 	; bit 2 = lightgun
 	; bit 3 = paddle
 	; bit 4 = trakball
 	; bit 5 = 2600 joystick
 	; bit 6 = 2600 driving
 	; bit 7 = 2600 keypad
 	; bit 8 = ST mouse
 	; bit 9 = Amiga mouse
 	; bit 10 = AtariVox/SaveKey
 	; bit 11 = SNES2Atari
 	; bit 12 = Mega7800
	dc.b	$01

	; Controller 2 type 	1 byte 	56 / 0x38
	; 0 = none
	; 1 = 7800 joystick
	; 2 = lightgun
	; 3 = paddle
	; 4 = trakball
	; 5 = 2600 joystick
	; 6 = 2600 driving
	; 7 = 2600 keypad
	; 8 = ST mouse
	; 9 = Amiga mouse
	; 10 = AtariVox/SaveKey
	; 11 = SNES2Atari
	; 12 = Mega7800
	dc.b	$01

	; TV type 	1 byte 	57 / 0x39
	; bit 0 : 0=NTSC, 1=PAL
	; bit 1 : 0=component, 1=composite
	; bit 2 : 0=single region, 1=multi-region
	dc.b	0

	; save device 	1 byte 	58 / 0x3A
	; bit 0 : HSC
	; bit 1 : SaveKey/AtariVox
	dc.b	%00000000

	; reserved	4 bytes	59 / 0x3B
	dc.b	0, 0, 0, 0

	; slot passthrough device 	1 byte 	63 / 0x3F
	; bit 0 : XM
	dc.b	0

	; v4+ mapper 	1 byte 	64 / 0x40
	; 0 = Linear
	; 1 = SuperGame
	; 2 = Activision
	; 3 = Absolute
	; 4 = Souper
	dc.b	0

	; v4+ mapper options 	1 byte 	65 / 0x41
	; Linear
	; - bit 7	: Bankset ROM
	; - bits 0-1	: Option at @4000 (0=none, 1=16K RAM, 2=8K EXRAM/A8, 3=32K EXRAM/M2)
	; SuperGame
	; - bit 7	: Bankset ROM
	; - bits 0-2	: Option at @4000 (0=none, 1=16K RAM, 2=8K EXRAM/A8, 3=32K EXRAM/M2, 4=EXROM, 5=EXFIX, 6=32k EXRAM/X2)
	dc.b	0

	; v4+ audio 	2 bytes 	66 / 0x42
	; bit 5		: ADPCM Audio Stream @420
	; bit 4		: COVOX @430
	; bit 3		: YM2151 @460
	; bits 0-2	: POKEY (0=none, 1=@440, 2=@450, 3=@450+@440, 4=@800, 5=@4000)
	dc.b	0
	dc.b	%00000000

	; v4+ interrupt 	2 bytes 	68 / 0x44
	; bit 2 : YM2151
	; bit 1 : POKEY 2 (@440)
	; bit 0 : POKEY 1 (@450 | @800 | @4000)
	dc.b	0
	dc.b	%00000001

	; 70..99 Not used - 30 bytes
	.byte	$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF

	; Header end magic-text
	; 100..127 "ACTUAL CART DATA STARTS HERE" - 28 bytes
	dc.b	$41,$43,$54,$55,$41,$4c		; Actual
	dc.b	$20					; (space)
	dc.b	$43,$41,$52,$54			; Cart
	dc.b	$20					; (space)
	dc.b	$44,$41,$54,$41			; Data
	dc.b	$20					; (space)
	dc.b	$53,$54,$41,$52,$54,$53		; Starts
	dc.b	$20					; (space)
	dc.b	$48,$45,$52,$45			; Here

	incbin	out/color.bin
