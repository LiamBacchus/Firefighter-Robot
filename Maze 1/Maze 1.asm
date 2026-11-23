;Program compiled by GCBASIC (2025.10.04 (Windows 64 bit) : Build 1523) for Microchip MPASM/MPLAB-X Assembler using FreeBASIC 1.07.1/2025-10-03 CRC248
;Need help? 
;  Please donate to help support the operational costs of the project.  Donate via https://gcbasic.com/donate/
;  
;  See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;  Check the documentation and Help at http://gcbasic.sourceforge.net/help/,
;or, email us:
;   evanvennn at users dot sourceforge dot net
;********************************************************************************
;   Installation Dir : C:\GCstudio\gcbasic
;   Source file      : C:\Users\Inspirion\OneDrive\Liam's Firefighter Code\Maze 1.gcb
;   Setting file     : C:\GCstudio\gcbasic\use.ini
;   Preserve mode    : 0
;   Assembler        : GCASM
;   Programmer       : 
;   Output file      : C:\Users\Inspirion\OneDrive\Liam's Firefighter Code\Maze 1.asm
;   Float Capability : 0
;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18875, r=DEC
 TITLE       "C:\Users\Inspirion\OneDrive\Liam's Firefighter Code\Maze 1.gcb"
 SUBTITLE    "12-19-2025 11:20:16"
#include <P16F18875.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINT32 & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _MCLRE_OFF
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF & _WRT_OFF
 __CONFIG _CONFIG5, _CPD_OFF & _CP_OFF

;********************************************************************************

;Set aside memory locations for variables
;  Shared/Access RAM = (SA)
ADREADPORT                       EQU      32          ; 0x20
DELAYTEMP                        EQU     112          ; 0x70 (SA)
DELAYTEMP2                       EQU     113          ; 0x71 (SA)
FLAMEV                           EQU      33          ; 0x21
FRONT_WALL_DISTANCE              EQU      34          ; 0x22
INVLA0                           EQU      35          ; 0x23
LCDBYTE                          EQU      36          ; 0x24
LCDCOLUMN                        EQU      37          ; 0x25
LCDLINE                          EQU      38          ; 0x26
LCDTEMPRWCOUNT                   EQU      39          ; 0x27
LCDVALUE                         EQU      40          ; 0x28
LCDVALUETEMP                     EQU      41          ; 0x29
LCD_STATE                        EQU      42          ; 0x2A
LCOUNT                           EQU      43          ; 0x2B
PRINTLEN                         EQU      44          ; 0x2C
READAD                           EQU      45          ; 0x2D
ROOMONEWALLCHECK                 EQU      46          ; 0x2E
STRINGPOINTER                    EQU      47          ; 0x2F
SYSBYTETEMPA                     EQU     117          ; 0x75 (SA)
SYSBYTETEMPB                     EQU     121          ; 0x79 (SA)
SYSBYTETEMPX                     EQU     112          ; 0x70 (SA)
SYSCALCTEMPX                     EQU     112          ; 0x70 (SA)
SYSDIVLOOP                       EQU     116          ; 0x74 (SA)
SYSDIVMULTA                      EQU     119          ; 0x77 (SA)
SYSDIVMULTA_H                    EQU     120          ; 0x78 (SA)
SYSDIVMULTB                      EQU     123          ; 0x7B (SA)
SYSDIVMULTB_H                    EQU     124          ; 0x7C (SA)
SYSDIVMULTX                      EQU     114          ; 0x72 (SA)
SYSDIVMULTX_H                    EQU     115          ; 0x73 (SA)
SYSLCDTEMP                       EQU      48          ; 0x30
SYSPRINTDATAHANDLER              EQU      49          ; 0x31
SYSPRINTDATAHANDLER_H            EQU      50          ; 0x32
SYSPRINTTEMP                     EQU      51          ; 0x33
SYSREPEATTEMP1                   EQU      52          ; 0x34
SYSSTRINGA                       EQU     119          ; 0x77 (SA)
SYSSTRINGA_H                     EQU     120          ; 0x78 (SA)
SYSTEMP1                         EQU      53          ; 0x35
SYSTEMP1_H                       EQU      54          ; 0x36
SYSTEMP2                         EQU      55          ; 0x37
SYSTEMP2_H                       EQU      56          ; 0x38
SYSWAITTEMP10US                  EQU     117          ; 0x75 (SA)
SYSWAITTEMPMS                    EQU     114          ; 0x72 (SA)
SYSWAITTEMPMS_H                  EQU     115          ; 0x73 (SA)
SYSWAITTEMPUS                    EQU     117          ; 0x75 (SA)
SYSWAITTEMPUS_H                  EQU     118          ; 0x76 (SA)
SYSWORDTEMPA                     EQU     117          ; 0x75 (SA)
SYSWORDTEMPA_H                   EQU     118          ; 0x76 (SA)
SYSWORDTEMPB                     EQU     121          ; 0x79 (SA)
SYSWORDTEMPB_H                   EQU     122          ; 0x7A (SA)
SYSWORDTEMPX                     EQU     112          ; 0x70 (SA)
SYSWORDTEMPX_H                   EQU     113          ; 0x71 (SA)
TURNTIME                         EQU      57          ; 0x39
WALL_FRONT_DISTANCE              EQU      58          ; 0x3A
WALL_FRONT_VALUE                 EQU      59          ; 0x3B
WALL_LEFT_DISTANCE               EQU      60          ; 0x3C
WALL_LEFT_VALUE                  EQU      61          ; 0x3D

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5
SYSREADADBYTE EQU 45

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Program_memory_page: 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITLCD
;Automatic pin direction setting
	bcf	TRISB,3

;Start_of_the_main_program
	bsf	TRISA,3
	bcf	TRISB,7
	bcf	LATB,7
	bsf	TRISA,2
	bsf	TRISA,1
	bcf	TRISD,0
	bcf	TRISD,1
	bcf	TRISD,2
	bcf	TRISD,4
	bcf	TRISD,5
	bcf	TRISD,6
	bcf	TRISD,7
	bsf	TRISA,0
	clrf	LCOUNT
	clrf	INVLA0
	bcf	TRISC,0
	bcf	TRISC,1
	bcf	TRISC,2
	bcf	TRISC,3
	bcf	TRISB,0
	bcf	TRISB,1
	bcf	TRISB,2
	bcf	TRISB,2
	bcf	LATC,0
	bcf	LATC,1
	bcf	LATC,2
	bcf	LATC,3
	bcf	LATB,0
	bcf	LATB,1
	bcf	LATB,2
	bcf	LATB,2
	movlw	20
	movwf	TURNTIME
	clrf	ROOMONEWALLCHECK
SysDoLoop_S1
	movlw	2
	movwf	ADREADPORT
	call	FN_READAD16
	movf	SYSREADADBYTE,W
	movwf	WALL_LEFT_VALUE
	movlw	1
	movwf	ADREADPORT
	call	FN_READAD16
	movf	SYSREADADBYTE,W
	movwf	WALL_FRONT_VALUE
	movlw	3
	subwf	WALL_LEFT_VALUE,W
	movwf	SysTemp1
	movlw	131
	movwf	SysWORDTempA
	movlw	26
	movwf	SysWORDTempA_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	SysTemp2
	movf	SysWORDTempA_H,W
	movwf	SysTemp2_H
	movlw	4
	subwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	subwfb	SysTemp2_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	5
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	WALL_LEFT_DISTANCE
	movlw	3
	subwf	WALL_FRONT_VALUE,W
	movwf	SysTemp1
	movlw	131
	movwf	SysWORDTempA
	movlw	26
	movwf	SysWORDTempA_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	SysTemp2
	movf	SysWORDTempA_H,W
	movwf	SysTemp2_H
	movlw	4
	subwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	subwfb	SysTemp2_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	5
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSDIVSUB16
	movf	SysWORDTempA,W
	movwf	WALL_FRONT_DISTANCE
	btfss	PORTA,0
	goto	ELSE1_1
	call	MOVE_FORWARDS
	goto	ENDIF1
ELSE1_1
	incf	LCOUNT,F
ENDIF1
	call	CLS
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT129
	movf	FLAMEV,W
	movwf	LCDVALUE
	call	PRINT130
	movlw	1
	movwf	LCDLINE
	movlw	5
	movwf	LCDCOLUMN
	call	LOCATE
	movlw	100
	subwf	FLAMEV,W
	btfsc	STATUS, C
	goto	ELSE2_1
	bsf	LATB,7
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT129
	goto	ENDIF2
ELSE2_1
	bcf	LATB,7
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT129
ENDIF2
	movlw	150
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
SysDoLoop_S2
	movf	LCOUNT,F
	btfss	STATUS, Z
	goto	SysDoLoop_E2
	call	MOVE_FORWARDS
	movf	WALL_LEFT_DISTANCE,W
	sublw	100
	btfsc	STATUS, C
	goto	ENDIF3
	call	LEFT90
	call	MOVE_FORWARDS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	call	LEFT90
	call	MOVE_FORWARDS
ENDIF3
	goto	SysDoLoop_S2
SysDoLoop_E2
	decf	LCOUNT,W
	btfss	STATUS, Z
	goto	ENDIF4
	call	FLAMEDETECTION
	decf	ROOMONEWALLCHECK,W
	btfss	STATUS, Z
	goto	ENDIF6
	movlw	50
	subwf	WALL_FRONT_DISTANCE,W
	btfsc	STATUS, C
	goto	ENDIF9
	call	STOP
	movf	FLAMEV,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movlw	44
	movwf	SysWORDTempA
	movlw	1
	movwf	SysWORDTempA_H
	call	SYSCOMPLESSTHAN16
	btfss	SysByteTempX,0
	goto	ENDIF10
	call	SPIN_RIGHT
	movf	TURNTIME,W
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	incf	ROOMONEWALLCHECK,F
ENDIF10
ENDIF9
ENDIF6
	movlw	2
	subwf	ROOMONEWALLCHECK,W
	btfss	STATUS, Z
	goto	ENDIF7
SysDoLoop_S3
	movlw	50
	subwf	WALL_FRONT_DISTANCE,W
	btfss	STATUS, C
	goto	SysDoLoop_E3
	call	MOVE_FORWARDS
	goto	SysDoLoop_S3
SysDoLoop_E3
	incf	ROOMONEWALLCHECK,F
ENDIF7
	movlw	3
	subwf	ROOMONEWALLCHECK,W
	btfss	STATUS, Z
	goto	ENDIF8
	call	LEFT90
SysDoLoop_S4
	movf	WALL_LEFT_DISTANCE,W
	sublw	200
	btfss	STATUS, C
	goto	SysDoLoop_E4
	call	MOVE_FORWARDS
	goto	SysDoLoop_S4
SysDoLoop_E4
	incf	ROOMONEWALLCHECK,F
ENDIF8
ENDIF4
SysDoLoop_S5
	movlw	2
	subwf	LCOUNT,W
	btfss	STATUS, Z
	goto	SysDoLoop_E5
SysDoLoop_S6
	movlw	50
	subwf	FRONT_WALL_DISTANCE,W
	btfss	STATUS, C
	goto	SysDoLoop_E6
	call	MOVE_FORWARDS
	goto	SysDoLoop_S6
SysDoLoop_E6
	movlw	50
	subwf	FRONT_WALL_DISTANCE,W
	btfss	STATUS, C
	call	LEFT90
	goto	SysDoLoop_S5
SysDoLoop_E5
SysDoLoop_S7
	movlw	3
	subwf	LCOUNT,W
	btfss	STATUS, Z
	goto	SysDoLoop_E7
	call	FLAMEDETECTION
	call	FLAMEEXTINGUISH
	goto	SysDoLoop_S7
SysDoLoop_E7
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

CHECKBUSYFLAG
	bcf	SYSLCDTEMP,2
	btfsc	PORTD,0
	bsf	SYSLCDTEMP,2
	bsf	TRISD,7
	bcf	LATD,0
	bsf	LATD,1
	clrf	LCDTEMPRWCOUNT
SysDoLoop_S10
	movlw	2
	movwf	DELAYTEMP
DelayUS14
	decfsz	DELAYTEMP,F
	goto	DelayUS14
	nop
	bsf	LATD,2
	movlw	2
	movwf	DELAYTEMP
DelayUS15
	decfsz	DELAYTEMP,F
	goto	DelayUS15
	nop
	bcf	SYSLCDTEMP,7
	btfsc	PORTD,7
	bsf	SYSLCDTEMP,7
	bcf	LATD,2
	movlw	2
	movwf	DELAYTEMP
DelayUS16
	decfsz	DELAYTEMP,F
	goto	DelayUS16
	nop
	bsf	LATD,2
	movlw	2
	movwf	DELAYTEMP
DelayUS17
	decfsz	DELAYTEMP,F
	goto	DelayUS17
	bcf	LATD,2
	movlw	2
	movwf	DELAYTEMP
DelayUS18
	decfsz	DELAYTEMP,F
	goto	DelayUS18
	nop
	incf	LCDTEMPRWCOUNT,W
	btfsc	STATUS, Z
	bcf	SYSLCDTEMP,7
	incf	LCDTEMPRWCOUNT,F
	btfsc	SYSLCDTEMP,7
	goto	SysDoLoop_S10
SysDoLoop_E10
	bcf	LATD,0
	btfsc	SYSLCDTEMP,2
	bsf	LATD,0
	return

;********************************************************************************

CLS
	bcf	LATD,0
	movlw	1
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	4
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	movlw	128
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	133
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	25
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	14
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	189
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

FLAMEDETECTION
	call	CLS
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
	movlw	low StringTable1
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT129
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT129
	movf	FLAMEV,W
	sublw	250
	btfsc	STATUS, C
	goto	ENDIF11
SysDoLoop_S8
	movlw	100
	subwf	FLAMEV,W
	btfss	STATUS, C
	goto	SysDoLoop_E8
	call	MOVE_FORWARDS
	goto	SysDoLoop_S8
SysDoLoop_E8
ENDIF11
	return

;********************************************************************************

FLAMEEXTINGUISH
SysDoLoop_S9
	movf	FLAMEV,W
	sublw	250
	btfss	STATUS, C
	goto	SysDoLoop_E9
	bsf	LATB,7
	goto	SysDoLoop_S9
SysDoLoop_E9
	return

;********************************************************************************

INITLCD
;`LCD_IO selected is ` LCD_IO
;`LCD_Speed is FAST`
;`OPTIMAL is set to ` OPTIMAL
;`LCD_Speed is set to ` LCD_Speed
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	bcf	TRISD,1
	bcf	LATD,1
	bcf	TRISD,4
	bcf	TRISD,5
	bcf	TRISD,6
	bcf	TRISD,7
	bcf	TRISD,0
	bcf	TRISD,2
	bcf	LATD,0
	bcf	LATD,2
	bcf	LATD,7
	bcf	LATD,6
	bsf	LATD,5
	bsf	LATD,4
	movlw	5
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	bsf	LATD,2
	movlw	5
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
	bcf	LATD,2
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	movlw	3
	movwf	SysRepeatTemp1
SysRepeatLoop1
	bsf	LATD,2
	movlw	5
	movwf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
	bcf	LATD,2
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	bcf	LATD,7
	bcf	LATD,6
	bsf	LATD,5
	bcf	LATD,4
	movlw	5
	movwf	DELAYTEMP
DelayUS5
	decfsz	DELAYTEMP,F
	goto	DelayUS5
	bsf	LATD,2
	movlw	5
	movwf	DELAYTEMP
DelayUS6
	decfsz	DELAYTEMP,F
	goto	DelayUS6
	bcf	LATD,2
	movlw	1
	movwf	DELAYTEMP2
DelayUSO7
	clrf	DELAYTEMP
DelayUS7
	decfsz	DELAYTEMP,F
	goto	DelayUS7
	decfsz	DELAYTEMP2,F
	goto	DelayUSO7
	movlw	9
	movwf	DELAYTEMP
DelayUS8
	decfsz	DELAYTEMP,F
	goto	DelayUS8
	movlw	40
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	6
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	12
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	call	CLS
	movlw	12
	movwf	LCD_STATE
	return

;********************************************************************************

INITSYS
;Default settings for microcontrollers with _OSCCON1_
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
	clrf	OSCCON3
	clrf	OSCEN
	clrf	OSCTUNE
;The MCU is a chip family ChipFamily
;OSCCON type is 102
	movlw	6
	movwf	OSCFRQ
;_Complete_the_chip_setup_of_BSR_ADCs_ANSEL_and_other_key_setup_registers_or_register_bits
	banksel	ADCON0
	bcf	ADCON0,ADFRM0
	bcf	ADCON0,ADON
	banksel	ANSELA
	clrf	ANSELA
	clrf	ANSELB
	clrf	ANSELC
	clrf	ANSELD
	clrf	ANSELE
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
	bcf	CM1CON0,C1ON
	banksel	PORTA
	clrf	PORTA
	clrf	PORTB
	clrf	PORTC
	clrf	PORTD
	clrf	PORTE
	return

;********************************************************************************

LCDNORMALWRITEBYTE
	call	CHECKBUSYFLAG
	bcf	LATD,1
	bcf	TRISD,4
	bcf	TRISD,5
	bcf	TRISD,6
	bcf	TRISD,7
	bcf	LATD,7
	btfsc	LCDBYTE,7
	bsf	LATD,7
	bcf	LATD,6
	btfsc	LCDBYTE,6
	bsf	LATD,6
	bcf	LATD,5
	btfsc	LCDBYTE,5
	bsf	LATD,5
	bcf	LATD,4
	btfsc	LCDBYTE,4
	bsf	LATD,4
	movlw	2
	movwf	DELAYTEMP
DelayUS9
	decfsz	DELAYTEMP,F
	goto	DelayUS9
	nop
	bsf	LATD,2
	movlw	2
	movwf	DELAYTEMP
DelayUS10
	decfsz	DELAYTEMP,F
	goto	DelayUS10
	bcf	LATD,2
	bcf	LATD,7
	btfsc	LCDBYTE,3
	bsf	LATD,7
	bcf	LATD,6
	btfsc	LCDBYTE,2
	bsf	LATD,6
	bcf	LATD,5
	btfsc	LCDBYTE,1
	bsf	LATD,5
	bcf	LATD,4
	btfsc	LCDBYTE,0
	bsf	LATD,4
	movlw	2
	movwf	DELAYTEMP
DelayUS11
	decfsz	DELAYTEMP,F
	goto	DelayUS11
	nop
	bsf	LATD,2
	movlw	2
	movwf	DELAYTEMP
DelayUS12
	decfsz	DELAYTEMP,F
	goto	DelayUS12
	bcf	LATD,2
	movlw	93
	movwf	DELAYTEMP
DelayUS13
	decfsz	DELAYTEMP,F
	goto	DelayUS13
	btfsc	PORTD,0
	goto	ENDIF20
	movlw	16
	subwf	LCDBYTE,W
	btfsc	STATUS, C
	goto	ENDIF21
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF22
	movf	LCDBYTE,W
	movwf	LCD_STATE
ENDIF22
ENDIF21
ENDIF20
	return

;********************************************************************************

LEFT90
	call	SPIN_LEFT
	movf	TURNTIME,W
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	goto	Delay_MS

;********************************************************************************

LOCATE
	bcf	LATD,0
	movf	LCDLINE,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF13
	movlw	2
	subwf	LCDLINE,F
	movlw	16
	addwf	LCDCOLUMN,F
ENDIF13
	movf	LCDLINE,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SYSMULTSUB
	movf	LCDCOLUMN,W
	addwf	SysBYTETempX,W
	movwf	SysTemp1
	movlw	128
	iorwf	SysTemp1,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

MOVE_FORWARDS
	bsf	LATC,0
	bcf	LATC,1
	bcf	LATC,2
	bsf	LATC,3
	bsf	LATB,0
	bcf	LATB,1
	bcf	LATB,2
	bsf	LATB,3
	return

;********************************************************************************

PRINT129
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	return
	bsf	LATD,0
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
	return

;********************************************************************************

PRINT130
	clrf	LCDVALUETEMP
	bsf	LATD,0
	movlw	100
	subwf	LCDVALUE,W
	btfss	STATUS, C
	goto	ENDIF17
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
ENDIF17
	movf	LCDVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SYSCOMPLESSTHAN
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSCOMPLESSTHAN
	comf	SysByteTempX,F
	movf	SysTemp1,W
	iorwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF18
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SYSDIVSUB
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
ENDIF18
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

FN_READAD16
	banksel	ADCON0
	bcf	ADCON0,ADFRM0
	banksel	ADREADPORT
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
SysSelect1Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
	banksel	ANSELA
	bsf	ANSELA,0
	goto	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
	banksel	ANSELA
	bsf	ANSELA,1
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
	banksel	ANSELA
	bsf	ANSELA,2
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
	banksel	ANSELA
	bsf	ANSELA,3
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
	banksel	ANSELA
	bsf	ANSELA,4
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
	banksel	ANSELA
	bsf	ANSELA,5
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
	banksel	ANSELA
	bsf	ANSELA,6
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
	banksel	ANSELA
	bsf	ANSELA,7
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
	banksel	ANSELB
	bsf	ANSELB,0
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case11
	banksel	ANSELB
	bsf	ANSELB,1
	goto	SysSelectEnd1
SysSelect1Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case12
	banksel	ANSELB
	bsf	ANSELB,2
	goto	SysSelectEnd1
SysSelect1Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case13
	banksel	ANSELB
	bsf	ANSELB,3
	goto	SysSelectEnd1
SysSelect1Case13
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case14
	banksel	ANSELB
	bsf	ANSELB,4
	goto	SysSelectEnd1
SysSelect1Case14
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case15
	banksel	ANSELB
	bsf	ANSELB,5
	goto	SysSelectEnd1
SysSelect1Case15
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case16
	banksel	ANSELB
	bsf	ANSELB,6
	goto	SysSelectEnd1
SysSelect1Case16
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case17
	banksel	ANSELB
	bsf	ANSELB,7
	goto	SysSelectEnd1
SysSelect1Case17
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case18
	banksel	ANSELC
	bsf	ANSELC,0
	goto	SysSelectEnd1
SysSelect1Case18
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case19
	banksel	ANSELC
	bsf	ANSELC,1
	goto	SysSelectEnd1
SysSelect1Case19
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case20
	banksel	ANSELC
	bsf	ANSELC,2
	goto	SysSelectEnd1
SysSelect1Case20
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case21
	banksel	ANSELC
	bsf	ANSELC,3
	goto	SysSelectEnd1
SysSelect1Case21
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case22
	banksel	ANSELC
	bsf	ANSELC,4
	goto	SysSelectEnd1
SysSelect1Case22
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case23
	banksel	ANSELC
	bsf	ANSELC,5
	goto	SysSelectEnd1
SysSelect1Case23
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case24
	banksel	ANSELC
	bsf	ANSELC,6
	goto	SysSelectEnd1
SysSelect1Case24
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case25
	banksel	ANSELC
	bsf	ANSELC,7
	goto	SysSelectEnd1
SysSelect1Case25
	movlw	24
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case26
	banksel	ANSELD
	bsf	ANSELD,0
	goto	SysSelectEnd1
SysSelect1Case26
	movlw	25
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case27
	banksel	ANSELD
	bsf	ANSELD,1
	goto	SysSelectEnd1
SysSelect1Case27
	movlw	26
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case28
	banksel	ANSELD
	bsf	ANSELD,2
	goto	SysSelectEnd1
SysSelect1Case28
	movlw	27
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case29
	banksel	ANSELD
	bsf	ANSELD,3
	goto	SysSelectEnd1
SysSelect1Case29
	movlw	28
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case30
	banksel	ANSELD
	bsf	ANSELD,4
	goto	SysSelectEnd1
SysSelect1Case30
	movlw	29
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case31
	banksel	ANSELD
	bsf	ANSELD,5
	goto	SysSelectEnd1
SysSelect1Case31
	movlw	30
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case32
	banksel	ANSELD
	bsf	ANSELD,6
	goto	SysSelectEnd1
SysSelect1Case32
	movlw	31
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case33
	banksel	ANSELD
	bsf	ANSELD,7
	goto	SysSelectEnd1
SysSelect1Case33
	movlw	32
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case34
	banksel	ANSELE
	bsf	ANSELE,0
	goto	SysSelectEnd1
SysSelect1Case34
	movlw	33
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case35
	banksel	ANSELE
	bsf	ANSELE,1
	goto	SysSelectEnd1
SysSelect1Case35
	movlw	34
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
	banksel	ANSELE
	bsf	ANSELE,2
SysSelectEnd1
	banksel	ADCON0
	bcf	ADCON0,ADCS
	movlw	1
	movwf	ADCLK
	bcf	ADCON0,ADCS
	movlw	15
	movwf	ADCLK
	bcf	ADCON0,ADFRM0
	bcf	ADCON0,ADFM0
	banksel	ADREADPORT
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
	bsf	ADCON0,ADON
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
	nop
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop1
	bcf	ADCON0,ADON
	banksel	ANSELA
	clrf	ANSELA
	clrf	ANSELB
	clrf	ANSELC
	clrf	ANSELD
	clrf	ANSELE
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD
	movwf	READAD
	banksel	ADCON0
	bcf	ADCON0,ADFRM0
	banksel	STATUS
	return

;********************************************************************************

SPIN_LEFT
	bcf	LATC,0
	bsf	LATC,1
	bsf	LATC,2
	bcf	LATC,3
	bsf	LATB,0
	bcf	LATB,1
	bcf	LATB,2
	bsf	LATB,3
	return

;********************************************************************************

SPIN_RIGHT
	bsf	LATC,0
	bcf	LATC,1
	bcf	LATC,2
	bsf	LATC,3
	bcf	LATB,0
	bsf	LATB,1
	bsf	LATB,2
	bcf	LATB,3
	return

;********************************************************************************

STOP
	bcf	LATC,0
	bcf	LATC,1
	bcf	LATC,2
	bcf	LATC,3
	bcf	LATB,0
	bcf	LATB,1
	bcf	LATB,2
	bcf	LATB,3
	return

;********************************************************************************

SYSCOMPEQUAL16
	clrf	SYSBYTETEMPX
	movf	SYSWORDTEMPA, W
	subwf	SYSWORDTEMPB, W
	btfss	STATUS, Z
	return
	movf	SYSWORDTEMPA_H, W
	subwf	SYSWORDTEMPB_H, W
	btfss	STATUS, Z
	return
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN
	clrf	SYSBYTETEMPX
	bsf	STATUS, C
	movf	SYSBYTETEMPB, W
	subwf	SYSBYTETEMPA, W
	btfss	STATUS, C
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN16
	clrf	SYSBYTETEMPX
	movf	SYSWORDTEMPA_H,W
	subwf	SYSWORDTEMPB_H,W
	btfss	STATUS,C
	return
	movf	SYSWORDTEMPB_H,W
	subwf	SYSWORDTEMPA_H,W
	btfss	STATUS,C
	goto	SCLT16TRUE
	movf	SYSWORDTEMPB,W
	subwf	SYSWORDTEMPA,W
	btfsc	STATUS,C
	return
SCLT16TRUE
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSDIVSUB
	movf	SYSBYTETEMPB, F
	btfsc	STATUS, Z
	return
	clrf	SYSBYTETEMPX
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
	bcf	STATUS, C
	rlf	SYSBYTETEMPA, F
	rlf	SYSBYTETEMPX, F
	movf	SYSBYTETEMPB, W
	subwf	SYSBYTETEMPX, F
	bsf	SYSBYTETEMPA, 0
	btfsc	STATUS, C
	goto	DIV8NOTNEG
	bcf	SYSBYTETEMPA, 0
	movf	SYSBYTETEMPB, W
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
	decfsz	SYSDIVLOOP, F
	goto	SYSDIV8START
	return

;********************************************************************************

SYSDIVSUB16
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SYSCOMPEQUAL16
	btfss	SysByteTempX,0
	goto	ENDIF30
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
	return
ENDIF30
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
	bcf	STATUS,C
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
	bsf	SYSDIVMULTA,0
	btfsc	STATUS,C
	goto	ENDIF31
	bcf	SYSDIVMULTA,0
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF31
	decfsz	SYSDIVLOOP, F
	goto	SYSDIV16START
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

SYSMULTSUB
	clrf	SYSBYTETEMPX
MUL8LOOP
	movf	SYSBYTETEMPA, W
	btfsc	SYSBYTETEMPB, 0
	addwf	SYSBYTETEMPX, F
	bcf	STATUS, C
	rrf	SYSBYTETEMPB, F
	bcf	STATUS, C
	rlf	SYSBYTETEMPA, F
	movf	SYSBYTETEMPB, F
	btfss	STATUS, Z
	goto	MUL8LOOP
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	6
	retlw	77	;M
	retlw	111	;o
	retlw	100	;d
	retlw	117	;u
	retlw	108	;l
	retlw	101	;e


StringTable2
	retlw	15
	retlw	70	;F
	retlw	108	;l
	retlw	97	;a
	retlw	109	;m
	retlw	101	;e
	retlw	32	; 
	retlw	68	;D
	retlw	101	;e
	retlw	116	;t
	retlw	101	;e
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n


StringTable3
	retlw	5
	retlw	70	;F
	retlw	108	;l
	retlw	97	;a
	retlw	109	;m
	retlw	101	;e


StringTable4
	retlw	3
	retlw	72	;H
	retlw	111	;o
	retlw	116	;t


StringTable5
	retlw	4
	retlw	67	;C
	retlw	111	;o
	retlw	108	;l
	retlw	100	;d


;********************************************************************************

;Program_memory_page: 1
	ORG	2048
;Program_memory_page: 2
	ORG	4096
;Program_memory_page: 3
	ORG	6144

 END
