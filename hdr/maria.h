        processor 6502
;*************************************************************************
;*
;*       MEMORY MAP USAGE OF THE 7800
;*
;*       00-1F           TIA REGISTERS
;*       20-3F           MARIA REGISTERS
;*       40-FF           ZERO PAGE RAM
;*       100-13F         SHADOW OF TIA AND MARIA REGISTERS -- USED FOR 
;*                       PUSHING ACCUMULATOR ONTO REGISTERS
;*       140-1FF         RAM (STACK)
;*       200-27F         NOT USED
;*       280-2FF         PIA PORTS AND TIMERS
;*       300-17FF        NOT USED
;*       1800-203F       RAM
;*       2040-20FF       SHADOW OF ZERO PAGE RAM
;*       2100-213F       RAM
;*       2140-21FF       SHADOW OF STACK RAM
;*       2200-27FF       RAM
;*       2800-3FFF       DUPLICATION OF ADDRESS SPACE 2000-27FF
;*       4000-FF7F       UNUSED ADDRESS SPACE
;*       FF80-FFF9       RESERVED FOR ENCRYPTION
;*       FFFA-FFFF       6502 VECTORS
;*

INPTCTRL       equ     $01     ;INPUT PORT CONTROL ("VBLANK" IN TIA )
;*
;*   AFTER INITIALIZING SWCHB AS FOLLOWS:
;*
;*       LDA  #$14
;*       STA  CTLSWB
;*       LDA  #0
;*       STA  SWCHB
;*
;*   ...LEFT AND RIGHT FIRE BUTTONS CAN BE READ FROM THE FOLLOWING 4 LOCATIONS:
;*
;*                              THESE ARE ALSO USED FOR PADDLE INPUT
INPT0          equ     $08     ;PLAYER 0, RIGHT FIRE BUTTON (D7=1 WHEN PUSHED)
INPT1          equ     $09     ;PLAYER 0, LEFT FIRE BUTTON  (D7=1 WHEN PUSHED)
INPT2          equ     $0A     ;PLAYER 1, RIGHT FIRE BUTTON (D7=1 WHEN PUSHED)
INPT3          equ     $0B     ;PLAYER 1, LEFT FIRE BUTTON  (D7=1 WHEN PUSHED)
;*
;*   LEFT OR RIGHT FIRE BUTTONS READ FROM THESE LOCATIONS:
;*
INPT4          equ     $0C     ;PLAYER 0 FIRE BUTTON INPUT (D7=0 WHEN PUSHED)
INPT5          equ     $0D     ;PLAYER 1 FIRE BUTTON INPUT (D7=0 WHEN PUSHED)
;*
AUDC0          equ     $15     ;AUDIO CONTROL CHANNEL 0
AUDC1          equ     $16     ;AUDIO CONTROL CHANNEL 1
AUDF0          equ     $17     ;AUDIO FREQUENCY CHANNEL 0
AUDF1          equ     $18     ;AUDIO FREQUENCY CHANNEL 1
AUDV0          equ     $19     ;AUDIO VOLUME CHANNEL 0
AUDV1          equ     $1A     ;AUDIO VOLUME CHANNEL 1
;
;******************************************************************************
;
BACKGRND       equ     $20     ;BACKGROUND COLOR
P0C1           equ     $21     ;PALETTE 0 - COLOR 1
P0C2           equ     $22     ;          - COLOR 2
P0C3           equ     $23     ;          - COLOR 3
WSYNC          equ     $24     ;WAIT FOR SYNC
P1C1           equ     $25     ;PALETTE 1 - COLOR 1
P1C2           equ     $26     ;          - COLOR 2
P1C3           equ     $27     ;          - COLOR 3
MSTAT          equ     $28     ;MARIA STATUS
P2C1           equ     $29     ;PALETTE 2 - COLOR 1
P2C2           equ     $2A     ;          - COLOR 2
P2C3           equ     $2B     ;          - COLOR 3
DPPH           equ     $2C     ;DISPLAY LIST LIST POINT HIGH BYTE
P3C1           equ     $2D     ;PALETTE 3 - COLOR 1
P3C2           equ     $2E     ;          - COLOR 2
P3C3           equ     $2F     ;          - COLOR 3
DPPL           equ     $30     ;DISPLAY LIST LIST POINT LOW BYTE
P4C1           equ     $31     ;PALETTE 4 - COLOR 1
P4C2           equ     $32     ;          - COLOR 2
P4C3           equ     $33     ;          - COLOR 3
CHBASE         equ     $34     ;CHARACTER BASE ADDRESS
CHARBASE       equ     $34     ;CHARACTER BASE ADDRESS
P5C1           equ     $35     ;PALETTE 5 - COLOR 1
P5C2           equ     $36     ;          - COLOR 2
P5C3           equ     $37     ;          - COLOR 3
OFFSET         equ     $38     ;FOR FUTURE EXPANSION - STORE ZER0 HERE
P6C1           equ     $39     ;PALETTE 6 - COLOR 1
P6C2           equ     $3A     ;          - COLOR 2
P6C3           equ     $3B     ;          - COLOR 3
CTRL           equ     $3C     ;MARIA CONTROL REGISTER
P7C1           equ     $3D     ;PALETTE 7 - COLOR 1
P7C2           equ     $3E     ;          - COLOR 2
P7C3           equ     $3F     ;          - COLOR 3
;*
;*       PIA AND TIMER (6532) LOCATIONS
;*
SWCHA          equ     $280    ;LEFT & RIGHT JOYSTICKS
;*
;*       LEFT RITE
;*       7654 3210       ;BIT POSITION (=0 IF SWITCH IS CLOSED)
;*       ---- ----
;*       RLDU RLDU       ;RIGHT/LEFT/DOWN/UP
;*
CTLSWA         equ     $281    ;SWCHA DATA DIRECTION (0=INPUT)
SWACNT         equ     $281    ;synonym for CTLSWA
;*
SWCHB          equ     $282    ;CONSOLE SWITCHES
;*
;*       D7-RITE DIFFICULTY
;*       D6-LEFT DIFFICULTY
;*       D5/D4 NOT USED
;*       D3-PAUSE
;*       D2-NOT USED
;*       D1-GAME SELECT
;*       D0-GAME RESET
;*
CTLSWB         equ     $283    ;SWCHB DATA DIRECTION (0=INPUT)
SWBCNT         equ     $283    ;synonym for CTLSWB
;*
INTIM          equ     $284    ;INTERVAL TIMER READ
TIM1T          equ     $294    ;SET 1    CLK INTERVAL (838   NSEC/INTERVAL)
TIM8T          equ     $295    ;SET 8    CLK INTERVAL (6.7   USEC/INTERVAL)
TIM64T         equ     $296    ;SET 64   CLK INTERVAL (53.6  USEC/INTERVAL)
T1024T         equ     $297    ;SET 1024 CLK INTERVAL (858.2 USEC/INTERVAL)
;*
;*
;*
;*
RESET          equ     $01     ;bits for consle switches
SELECT         equ     $02
PAUSE          equ     $08
