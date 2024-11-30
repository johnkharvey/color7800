;################################################################
; "Color" demo for the Atari 7800
; by John K. Harvey
;################################################################

	include "hdr/maria.h"
	include "hdr/palette.h"

	seg.u	RAMdata

;################################################################
; Zero Page RAM
	ORG	$40	;	$40-$FF
;################################################################
Temp				ds	1	;	$40
IndirPtr			ds	2	;	$41, $42	; a Temp word for indirect addressing
IncreasingCounter		ds	1	;	$43
PalOrNtsc			ds	1	;	$44
Latch				ds	1	;	$45
COLOR				ds	1	;	$46
LEFTCOLOR			ds	1	;	$47 - used in DL's
RIGHTCOLOR			ds	1	;	$48 - used in DL's
SWCHB_Previous			ds	1	;	$49

; Canary RAM address, courtesy of Atariage user RevEng
Canary				ds	1	;	$4A

;################################################################
; CHMAP RAM
	ORG	$1800
;################################################################

CHMAP_RAM_Start			ds	256	;	$1800-$18FF

;################################################################
; DL RAM
	ORG	$1900
;################################################################

DL_RAM_Start			ds	256	;	$1900-$19FF

;################################################################
; Another RAM area (this is a good place for SaveKey info)
	ORG	$1F00
;################################################################


;################################################################
; End of Memory 1 - for origin reverse-indexed trapping
	ORG	$203F
;################################################################


;################################################################
; Control equates
	ORG	$2200
;################################################################


;################################################################
	ORG	$2300
;################################################################


;################################################################
; DLL RAM
	ORG	$2400
;################################################################

DLLRam:

;################################################################
; CHMap RAM
	ORG	$2500
;################################################################


;################################################################
; End of Memory 2 - for origin reverse-indexed trapping
	ORG	$27FF
;################################################################


;################################################################
; Equates
;################################################################

GRAPHICS_SPACE		equ	$00	; a null character graphic pointer

PALETTE0		equ	#%00000000
PALETTE1		equ	#%00000001
PALETTE2		equ	#%00000010
PALETTE3		equ	#%00000011
PALETTE4		equ	#%00000100
PALETTE5		equ	#%00000101
PALETTE6		equ	#%00000110
PALETTE7		equ	#%00000111

;################################################################
; Let's define macros here
;################################################################

  MAC STR_LEN ; string, name
.start
	dc.b	{1}
STR_LEN_{2} = . - .start
  ENDM

	seg	code

;################################################################
	ORG	$4000
;################################################################

	dc.b	$FF	; This is just a dummy byte to make sure we build a 48K image
			; This whole space is available for code

;################################################################
; Graphics data for 128 characters
	ORG	$8000
;################################################################

; graphics data for 128 characters - line 8
	dc.b	$00,$7E,$7E,$00,$00,$7C,$7C,$00
	dc.b	$FF,$00,$FF,$78,$18,$E0,$C0,$99
	dc.b	$00,$00,$18,$00,$00,$78,$00,$FF
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$60,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$60,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$FF
	dc.b	$00,$00,$00,$00,$00,$00,$00,$F8
	dc.b	$00,$00,$78,$00,$00,$00,$00,$00
	dc.b	$F0,$1E,$00,$00,$00,$00,$00,$00
	dc.b	$00,$F8,$00,$00,$00,$00,$00,$00
 
	ALIGN	256
; graphics data for 128 characters - line 7
	dc.b	$00,$81,$FF,$10,$10,$38,$38,$00
	dc.b	$FF,$3C,$C3,$CC,$7E,$F0,$E6,$5A
	dc.b	$80,$02,$3C,$66,$1B,$CC,$7E,$18
	dc.b	$18,$18,$00,$00,$00,$00,$00,$00
	dc.b	$00,$30,$00,$6C,$30,$C6,$76,$00
	dc.b	$18,$60,$00,$00,$30,$00,$30,$80
	dc.b	$7C,$FC,$FC,$78,$1E,$78,$78,$30
	dc.b	$78,$70,$30,$30,$18,$00,$60,$30
	dc.b	$78,$CC,$FC,$3C,$F8,$FE,$F0,$3E
	dc.b	$CC,$78,$78,$E6,$FE,$C6,$C6,$38
	dc.b	$F0,$1C,$E6,$78,$78,$FC,$30,$C6
	dc.b	$C6,$78,$FE,$78,$02,$78,$00,$00
	dc.b	$00,$76,$DC,$78,$76,$78,$F0,$0C
	dc.b	$E6,$78,$CC,$E6,$78,$C6,$CC,$78
	dc.b	$60,$0C,$F0,$F8,$18,$76,$30,$6C
	dc.b	$C6,$0C,$FC,$1C,$18,$E0,$00,$FE

	ALIGN	256
; graphics data for 128 characters - line 6
	dc.b	$00,$99,$E7,$38,$38,$7C,$7C,$18
	dc.b	$E7,$66,$99,$CC,$18,$70,$67,$3C
	dc.b	$E0,$0E,$7E,$00,$1B,$38,$7E,$3C
	dc.b	$18,$3C,$18,$30,$FE,$24,$FF,$18
	dc.b	$00,$00,$00,$6C,$F8,$66,$CC,$00
	dc.b	$30,$30,$66,$30,$30,$00,$30,$C0
	dc.b	$E6,$30,$CC,$CC,$0C,$CC,$CC,$30
	dc.b	$CC,$18,$30,$30,$30,$FC,$30,$00
	dc.b	$C0,$CC,$66,$66,$6C,$62,$60,$66
	dc.b	$CC,$30,$CC,$66,$66,$C6,$C6,$6C
	dc.b	$60,$78,$66,$CC,$30,$CC,$78,$EE
	dc.b	$6C,$30,$66,$60,$06,$18,$00,$00
	dc.b	$00,$CC,$66,$CC,$CC,$C0,$60,$7C
	dc.b	$66,$30,$CC,$6C,$30,$D6,$CC,$CC
	dc.b	$7C,$7C,$60,$0C,$34,$CC,$78,$FE
	dc.b	$6C,$7C,$64,$30,$18,$30,$00,$C6

	ALIGN	256
; graphics data for 128 characters - line 5
	dc.b	$00,$BD,$C3,$7C,$7C,$FE,$FE,$3C
	dc.b	$C3,$42,$BD,$CC,$3C,$30,$63,$E7
	dc.b	$F8,$3E,$18,$66,$1B,$6C,$7E,$7E
	dc.b	$18,$7E,$0C,$60,$C0,$66,$FF,$3C
	dc.b	$00,$30,$00,$FE,$0C,$30,$DC,$00
	dc.b	$60,$18,$3C,$30,$00,$00,$00,$60
	dc.b	$F6,$30,$60,$0C,$FE,$0C,$CC,$30
	dc.b	$CC,$0C,$00,$00,$60,$00,$18,$30
	dc.b	$DE,$FC,$66,$C0,$66,$68,$68,$CE
	dc.b	$CC,$30,$CC,$6C,$62,$D6,$CE,$C6
	dc.b	$60,$DC,$6C,$1C,$30,$CC,$CC,$FE
	dc.b	$38,$30,$32,$60,$0C,$18,$00,$00
	dc.b	$00,$7C,$66,$C0,$CC,$FC,$60,$CC
	dc.b	$66,$30,$0C,$78,$30,$FE,$CC,$CC
	dc.b	$66,$CC,$66,$78,$30,$CC,$CC,$FE
	dc.b	$38,$CC,$30,$30,$18,$30,$00,$C6
 
	ALIGN	256
; graphics data for 128 characters - line 4
	dc.b	$ff,$81,$FF,$FE,$FE,$FE,$7C,$3C
	dc.b	$C3,$42,$BD,$7D,$66,$30,$63,$E7
	dc.b	$FE,$FE,$18,$66,$7B,$6C,$00,$18
	dc.b	$18,$18,$FE,$FE,$C0,$FF,$7E,$7E
	dc.b	$00,$30,$00,$6C,$78,$18,$76,$00
	dc.b	$60,$18,$FF,$FC,$00,$FC,$00,$30
	dc.b	$DE,$30,$38,$38,$CC,$0C,$F8,$18
	dc.b	$78,$7C,$00,$00,$C0,$00,$0C,$18
	dc.b	$DE,$CC,$7C,$C0,$66,$78,$78,$C0
	dc.b	$FC,$30,$0C,$78,$60,$FE,$DE,$C6
	dc.b	$7C,$CC,$7C,$70,$30,$CC,$CC,$D6
	dc.b	$38,$78,$18,$60,$18,$18,$C6,$00
	dc.b	$00,$0C,$7C,$CC,$7C,$CC,$F0,$CC
	dc.b	$76,$30,$0C,$6C,$30,$FE,$CC,$CC
	dc.b	$66,$CC,$76,$C0,$30,$CC,$CC,$D6
	dc.b	$5C,$CC,$98,$E0,$00,$1C,$00,$6C
 
	ALIGN	256
; graphics data for 128 characters - line 3
	dc.b	$ff,$A5,$DB,$FE,$7C,$38,$38,$18
	dc.b	$E7,$66,$99,$0F,$66,$3F,$7F,$3C
	dc.b	$F8,$3E,$7E,$66,$DB,$38,$00,$7E
	dc.b	$7E,$18,$0C,$60,$C0,$66,$3C,$FF
	dc.b	$00,$78,$6C,$FE,$C0,$CC,$38,$C0
	dc.b	$60,$18,$3C,$30,$00,$00,$00,$18
	dc.b	$CE,$30,$0C,$0C,$6C,$F8,$C0,$0C
	dc.b	$CC,$CC,$30,$30,$60,$FC,$18,$0C
	dc.b	$DE,$CC,$66,$C0,$66,$68,$68,$C0
	dc.b	$CC,$30,$0C,$6C,$60,$FE,$F6,$C6
	dc.b	$66,$CC,$66,$E0,$30,$CC,$CC,$C6
	dc.b	$6C,$CC,$8C,$60,$30,$18,$6C,$00
	dc.b	$18,$78,$60,$78,$0C,$78,$60,$76
	dc.b	$6C,$70,$0C,$66,$30,$CC,$F8,$78
	dc.b	$DC,$76,$DC,$7C,$7C,$CC,$CC,$C6
	dc.b	$C6,$CC,$FC,$30,$18,$30,$00,$38

	ALIGN	256
; graphics data for 128 characters - line 2
	dc.b	$00,$81,$FF,$FE,$38,$7C,$10,$00
	dc.b	$FF,$3C,$C3,$07,$66,$33,$63,$5A
	dc.b	$E0,$0E,$3C,$66,$DB,$63,$00,$3C
	dc.b	$3C,$18,$18,$30,$00,$24,$18,$FF
	dc.b	$00,$78,$6C,$6C,$7C,$C6,$6C,$60
	dc.b	$30,$30,$66,$30,$00,$00,$00,$0C
	dc.b	$C6,$70,$CC,$CC,$3C,$C0,$60,$CC
	dc.b	$CC,$CC,$30,$30,$30,$00,$30,$CC
	dc.b	$C6,$78,$66,$66,$6C,$62,$62,$66
	dc.b	$CC,$30,$0C,$66,$60,$EE,$E6,$6C
	dc.b	$66,$CC,$66,$CC,$B4,$CC,$CC,$C6
	dc.b	$C6,$CC,$C6,$60,$60,$18,$38,$00
	dc.b	$30,$00,$60,$00,$0C,$00,$6C,$00
	dc.b	$60,$00,$00,$60,$30,$00,$00,$00
	dc.b	$00,$00,$00,$00,$30,$00,$00,$00
	dc.b	$00,$00,$00,$30,$18,$30,$DC,$10

	ALIGN	256
; graphics data for 128 characters - line 1
	dc.b	$00,$7E,$7E,$6C,$10,$38,$10,$00
	dc.b	$FF,$00,$FF,$0F,$3C,$3F,$7F,$99
	dc.b	$80,$02,$18,$66,$7F,$3E,$00,$18
	dc.b	$18,$18,$00,$00,$00,$00,$00,$00
	dc.b	$00,$30,$6C,$6C,$30,$00,$38,$60
	dc.b	$18,$60,$00,$00,$00,$00,$00,$06
	dc.b	$7C,$30,$78,$78,$1C,$FC,$38,$FC
	dc.b	$78,$78,$00,$00,$18,$00,$60,$78
	dc.b	$7C,$30,$FC,$3C,$F8,$FE,$FE,$3C
	dc.b	$CC,$78,$1E,$E6,$F0,$C6,$C6,$38
	dc.b	$FC,$78,$FC,$78,$FC,$CC,$CC,$C6
	dc.b	$C6,$CC,$FE,$78,$C0,$78,$10,$00
	dc.b	$30,$00,$E0,$00,$1C,$00,$38,$00
	dc.b	$E0,$30,$0C,$E0,$70,$00,$00,$00
	dc.b	$00,$00,$00,$00,$10,$00,$00,$00
	dc.b	$00,$00,$00,$1C,$18,$E0,$76,$00

;################################################################
; Other data
	ORG	$8780
;################################################################

;################################################################
; Main execution code goes here
	ORG	$D000
;################################################################

	;==============================================================
	; This routine waits for the vertical blanking period to start
	; It is called from many places, so this is a good a place as
	; any to put it
	;==============================================================
WaitVBLANK:
WaitVBoff:
	BIT	MSTAT
	BMI	WaitVBoff
WaitVBon:
	BIT	MSTAT
	BPL	WaitVBon
	RTS
	;===================

;============================================================
; Where the program begins after the encryption check passes
;============================================================
START:
	;===================================
	; Important things to do on startup
	;===================================
	SEI			; disable interrupts
	CLD
	LDA	#$07		; lock the 7800 into MARIA mode
	STA	INPTCTRL
	LDA	#$7F		; turn off DMA, since no output has
	STA	CTRL		; been set up yet
	LDX	#$FF		; set stack pointer to $01ff
	TXS

	;=======================================
	; Global Startup inits (good practices)
	;=======================================
	LDA	#$00
	STA	BACKGRND
	STA	INPTCTRL	; not really nessessary but the
	STA	OFFSET		; manual suggests it anyway
	LDA	#$80		; the font data is located at $8000
	STA	CHBASE
	;=======================================

	;=========================
	; Sound clearing routines
	;=========================
	LDA	#0
	STA	AUDV0
	STA	AUDV1
	;=========================

	;=============================
	; RAM cleanup (lots of Loops)
	;=============================
	LDA	#0
	LDX	#$40
RamCleanupLoop1
	; $40-$FF / $140-$1FF
	STA	$0,X
	STA	$100,X
	INX
	BNE	RamCleanupLoop1

	LDX	#$3F
RamCleanupLoop2
	; $2000-$203F
	STA	$2000,X
	DEX
	BPL	RamCleanupLoop2

	LDX	#$0
RamCleanupLoop3
	; $1800-$1FFF
	STA	$1800,X
	STA	$1900,X
	STA	$1A00,X
	STA	$1B00,X
	STA	$1C00,X
	STA	$1D00,X
	STA	$1E00,X
	STA	$1F00,X
	; $2200-$27FF
	STA	$2200,X
	STA	$2300,X
	STA	$2400,X
	STA	$2500,X
	STA	$2600,X
	STA	$2700,X

	DEX
	BNE	RamCleanupLoop3
	;=============================

	;=====================================
	; Joystick button initialization code
	;=====================================
	LDA	#$14
	STA	SWBCNT
	LDA	#0
	STA	SWCHB
	;=====================================

	;=====================================================
	; A latch to make sure if we hit any console buttons
	; that it reacts only once per press
	;=====================================================
	LDA	#$FF
	STA	SWCHB_Previous
	;=====================================================

	;================================
	; Program-specific Startup inits
	;================================
	LDX	#0
	STX	Latch		; no joystick movements yet
	LDA	#$87
	STA	P0C2		; blue text
	LDA	#$26
	STA	P0C1
	LDA	#$36
	STA	P0C3
	LDA	#$0F		; white background, for starters
	STA	BACKGRND
	STA	COLOR
	LDA	#$80		; the font data is located at $8000
	STA	CHBASE
	;================================

;=============
;Main Routine
;=============
	;===============================================
	; First, we need to do initial graphics seeding
	;===============================================
	JSR	Copy_CHMAPs
	JSR	Copy_DLLs
	JSR	Copy_DLs
	JSR	SetupPALorNTSCPalettes
	;===============================================

	;==================================
	; Next, we fall into the Main Loop
	;==================================
MainLoop:
	JSR	WaitVBLANK	; avoid any process-corruption issues with DMA-interrupts
				; also, force calc's once per frame
	; Canary check, courtesy of Atariage user RevEng
	LDA	Canary
	BEQ	CanaryIsAlive
	LDA	#$45 ; RED
	STA	BACKGRND
	dc.b	$02 ; KIL opcode
CanaryIsAlive
	;===================================
	; Handle all housekeeping functions
	;===================================
	INC	IncreasingCounter
	JSR	CheckReset
	JSR	CheckSelect
	JSR	CheckJoystick
	; Now, turn on the screen
	LDA	#%01001011	; then enable normal color output,
	STA	CTRL		; turn on DMA, set one byte wide
				; characters, make the border black
				; enable transparent output, set screen
				; mode to 320A or 320C
	JMP	MainLoop
	;===================


	;=======================================================
	; Subroutine - Copy the text data into the RAM at $1800
	;=======================================================
Copy_CHMAPs:
	LDX	#$00
Copy_CHMAPs_Loop:
	LDA	$e000,X
	STA	$1800,X
	INX
	BNE	Copy_CHMAPs_Loop
	RTS

	;=====================================================
	; Subroutine - Copy the and DL's into the RAM at $1900
	;=====================================================
Copy_DLs:
	LDX	#$00
Copy_DLs_Loop:
	LDA	$e100,X
	STA	$1900,X
	INX
	BNE	Copy_DLs_Loop
	RTS

	;==================================
	; Subroutine - Copy DLL's into RAM
	;==================================
Copy_DLLs
	;===================
	; Set up empty DL
	;===================
	LDA	#0
	STA	DL_Empty
	STA	DL_Empty+1
	;===================
	; Copy all 256dc.bs of DLL data from code into RAM at DLLRam.
	;===================
	LDX	#0
Copy_DLL_Loop:
	LDA	DLL_PAL,x
	STA	DLLRam,x
	INX
	BNE	Copy_DLL_Loop
	;===================
	RTS
	;===================

; Differences between the NTSC and PAL 7800 consoles' output:
;     NTSC     PAL
;      15       15     automatic VBLANK lines
;      25       33     output lines, that can't be seen on many TVs
;     192      228     actual display lines
;      26       32     output lines, that can't be seen on many TVs
;       4        4     automatic VBLANK lines
;
;     262      312     total number of lines per frame
;     243      293     total number of DMA output lines per frame
;      60       50     frames per second
;
; So to make a NTSC game run properly on a PAL console, you can simply
; set up 25 extra blank lines before and after the normal NTSC display.
; Also you would have to adjust anything that is timed by counting the
; number of frames, since PAL consoles do less frames per second than
; NTSC consoles.

;======================
SetupPALorNTSCPalettes
;======================

	;===================
	; To make a NTSC game run on a PAL console, put 25 blank lines before & after NTSC display.
	;===================
	JSR	WaitVBLANK
	;===================

	;===================
	; PAL detector
	;===================
	LDX	#$00
	TXA	; zero accumulator for BIT testing of MSTAT
CountLines:
	BIT	MSTAT
	BMI	CompareCounter
	STA	WSYNC
	STA	WSYNC
	DEX
	BNE	CountLines
CompareCounter:
	CPX	#$78
	LDA	#>DLLRam	; DPPH is common for PAL/NTSC
	STA	DPPH
	BCS	NoPalSetup
;PALSetup:
	LDA	#1 ; PAL
	STA	PalOrNtsc
	LDA	#<DLL_PAL	; prepare PAL setup here
	STA	DPPL		; setup the pointers for the output
	JSR	WaitVBLANK	; wait until no DMA would happen
	RTS
	;===================

	;===================
NoPalSetup:
	LDA	#0 ; NTSC
	STA	PalOrNtsc
	LDA	#<DLL_NTSC	; prepare NTSC setup here
	STA	DPPL	; setup the pointers for the output
	JSR	WaitVBLANK	; wait until no DMA would happen
	RTS
	;===================

	;===========================
	; Function - Console checks
	;===========================
CheckReset
CheckSelect
	LDA	SWCHB
	AND	#$03	; isolate select/reset bits
	EOR	#$03
	BEQ	No_Reset

	; Reset/Select - resets colors to $00
	LDA	#$00
	STA	COLOR
	sta	BACKGRND
	STA	LEFTCOLOR
	STA	RIGHTCOLOR
No_Reset
	RTS
	;===========================

	;============================
	; Function - Joystick checks
	;============================
CheckJoystick
	LDA	SWCHA
	BMI	NotRt
	LDA	Latch
	BPL	NotRt
	; right - increase high nibble of color
WrapDown
	CLC
	LDA	COLOR
	ADC	#$10
	STA	COLOR
	sta	BACKGRND
	JMP	NotUp
NotRt
	ROL
	BMI	NotLeft
	LDA	Latch
	ROL
	BPL	NotLeft
	; left - decrease high nibble of color
WrapUp
	SEC
	LDA	COLOR
	SBC	#$10
	STA	COLOR
	STA	BACKGRND
	JMP	NotUp
NotLeft
	ROL
	BMI	NotDown
	LDA	Latch
	ROL
	ROL
	BPL	NotDown
	; down - decrease low nibble of color
	DEC	COLOR
	LDA	COLOR
	STA	BACKGRND
	AND	#$0F
	CMP	#$0F
	BEQ	WrapDown
	JMP	NotUp
NotDown
	ROL
	BMI	NotUp
	LDA	Latch
	ROL
	ROL
	ROL
	BPL	NotUp
	; up - increase low nibble of color
	INC	COLOR
	LDA	COLOR
	STA	BACKGRND
	AND	#$0F
	BEQ	WrapUp
NotUp
	LDA	SWCHA
	AND	#$F0
	STA	Latch
	lda	COLOR
	AND	#$0F
	CMP	#$0A
	BMI	NotLetter1
	CLC
	ADC	#$07
NotLetter1
	ADC	#$30
	STA	RIGHTCOLOR
	LDA	COLOR
	CLC
	AND	#$F0
	ROR
	ROR
	ROR
	ROR
	CMP	#$0A
	BMI	NotLetter2
	CLC
	ADC	#$07
NotLetter2
	ADC	#$30
	STA	LEFTCOLOR
	RTS
	;============================

;############################################################
; CHMAP Pointers to the graphic data are here - $1800 in RAM
	ORG	$E000
;############################################################

CHMAP_Space
   STR_LEN " ", CHMAP_Space

CHMAP_Programmed_by
   STR_LEN "Programmed by", CHMAP_Programmed_by

CHMAP_John_K_Harvey
   STR_LEN "John K. Harvey", CHMAP_John_K_Harvey

CHMAP_COLOR_Equals
   STR_LEN "COLOR = $", CHMAP_COLOR_Equals

CHMAP_Special_Thanks_to
   STR_LEN "Special Thanks to", CHMAP_Special_Thanks_to

CHMAP_Eckhard_Stolberg
   STR_LEN "Eckhard Stolberg", CHMAP_Eckhard_Stolberg

CHMAP_Detected
   STR_LEN "Detected!!", CHMAP_Detected

;###################################
; The DL starts here - $1900 in RAM
	ORG	$E100
;###################################

DL_Empty
	dc.b	$00,$00

DL_Space
	dc.b	<CHMAP_Space
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>CHMAP_RAM_Start
	dc.b	PALETTE0+$20-STR_LEN_CHMAP_Space
	dc.b	0 ; HPos (0-159)
	dc.b	$00,$00

DL_Programmed_by
	dc.b	<CHMAP_Programmed_by
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>CHMAP_RAM_Start
	dc.b	PALETTE0+$20-STR_LEN_CHMAP_Programmed_by
	dc.b	50 ; HPos (0-159)
	dc.b	$00,$00

DL_John_K_Harvey
	dc.b	<CHMAP_John_K_Harvey
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>CHMAP_RAM_Start
	dc.b	PALETTE0+$20-STR_LEN_CHMAP_John_K_Harvey
	dc.b	50 ; HPos (0-159)
	dc.b	$00,$00

DL_Special_Thanks_to
	dc.b	<CHMAP_Special_Thanks_to
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>CHMAP_RAM_Start
	dc.b	PALETTE0+$20-STR_LEN_CHMAP_Special_Thanks_to
	dc.b	50 ; HPos (0-159)
	dc.b	$00,$00

DL_Eckhard_Stolberg
	dc.b	<CHMAP_Eckhard_Stolberg
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>CHMAP_RAM_Start
	dc.b	PALETTE0+$20-STR_LEN_CHMAP_Eckhard_Stolberg
	dc.b	50 ; HPos (0-159)
	dc.b	$00,$00

DL_Color
	; This DL has multiple entries
	dc.b	<CHMAP_COLOR_Equals
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>CHMAP_RAM_Start
	dc.b	PALETTE0+$20-STR_LEN_CHMAP_COLOR_Equals
	dc.b	50 ; HPos (0-159)

	; DL for left nibble hex Color
	dc.b	<LEFTCOLOR
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>LEFTCOLOR
	dc.b	$1f ; 1 character, pallete 0
	dc.b	85

	; DL for right nibble hex Color
	dc.b	<RIGHTCOLOR
	dc.b	$60 ; D7 = Write Mode bit: 0=160x2 or 320x1, 1=160x4 or 320x2. D6=1. D5 = Indirect mode bit: 0=direct, 1=indirect mode.
	dc.b	>RIGHTCOLOR
	dc.b	$1f ; 1 character, pallete 0
	dc.b	89

	dc.b	$00, $00

;#####################################
; The DLL starts here - $1A00 in RAM
	ORG	$E200
;#####################################

DLL_PAL:
	dc.b	$00, >DL_Empty, <DL_Empty	; 25 extra blank lines for PAL
	dc.b	$07, >DL_Empty, <DL_Empty
	dc.b	$07, >DL_Empty, <DL_Empty
	dc.b	$07, >DL_Empty, <DL_Empty

	; $E20C
DLL_NTSC:
	dc.b	$00, >DL_Empty, <DL_Empty	; 25 blank lines that can't be seen
	dc.b	$07, >DL_Empty, <DL_Empty	; on most NTSC TVs anyway
	dc.b	$07, >DL_Empty, <DL_Empty
	dc.b	$07, >DL_Empty, <DL_Empty	; if the highest bit of the firstdc.b
						; in a DLL entry is set, an interrupt
						; will occur after the DMA for the
						; last line in this block of scanlines
						; has ended

Code_DLL_On_Screen:
DLL_On_Screen	EQU	Code_DLL_On_Screen - DLL_PAL + DLLRam

	dc.b	$07, >DL_RAM_Start, <DL_Space	; [8] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [16] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [24] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [32] blank
	dc.b	$07, >DL_RAM_Start, <DL_Programmed_by	; [40] DL for "Programmed by"
	dc.b	$07, >DL_RAM_Start, <DL_John_K_Harvey	; [48] DL for "John K. Harvey"
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [56] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [64] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [72] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [80] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [88] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [96] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [104] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [112] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [120] blank
	dc.b	$07, >DL_RAM_Start, <DL_Color	; [128] DL for Color
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [136] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [144] blank
	dc.b	$07, >DL_RAM_Start, <DL_Special_Thanks_to	; [152] DL for "Special Thanks to"
	dc.b	$07, >DL_RAM_Start, <DL_Eckhard_Stolberg	; [160] DL for "Eckhard Stolberg"
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [168] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [176] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [184] blank
	dc.b	$07, >DL_RAM_Start, <DL_Space	; [192] blank

	dc.b	$07, >DL_Empty, <DL_Empty	; The DMA keeps doing another 26 lines
	dc.b	$07, >DL_Empty, <DL_Empty	; which can't be seen on most NTSC
	dc.b	$07, >DL_Empty, <DL_Empty	; TVs, so they are set to be blank
	dc.b	$01, >DL_Empty, <DL_Empty

	dc.b	$00, >DL_Empty, <DL_Empty	; 25 extra blank lines for PAL
	dc.b	$07, >DL_Empty, <DL_Empty
	dc.b	$07, >DL_Empty, <DL_Empty
	dc.b	$07, >DL_Empty, <DL_Empty


;#####################
; DLI Interrupt code
	ORG	$FF00
;#####################

; At this address the execution will continue after an interrupt has
; occured. Here we change the horizontal position for the two lines of
; text to shift them continuously over the screen. In this example code
; the interrupt occurs in the scanline before the PAL/NTSC text starts
; displaying in every frame.
INTERRUPT:

	; Canary code, courtesy of Atariage user RevEng
	;LDA	#$1A ; YELLOW
	;STA	BACKGRND
	;dc.b	$02 ; KIL opcode. Stop the 6502.

	RTI

;#####################
; BRK interrupt code
	ORG	$FF7F
;#####################

BRKroutine:
	RTI

;#####################
; Encryption space
	ORG	$FF80
;#####################

	; reserved for encryption
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00

	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00

	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00

	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00

	ORG	$FFF8
	dc.b	$FF	; Region verification
	dc.b	$47	; Starts at $4000

	.word	INTERRUPT
	.word	START
	.word	BRKroutine

