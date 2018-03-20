
_main:

;ParkUygulamas_LastEdition.c,15 :: 		void main()
;ParkUygulamas_LastEdition.c,19 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;ParkUygulamas_LastEdition.c,20 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ParkUygulamas_LastEdition.c,21 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ParkUygulamas_LastEdition.c,23 :: 		TRISA = 0b00000000;
	CLRF       TRISA+0
;ParkUygulamas_LastEdition.c,24 :: 		TRISB = 0b00010000;                        // ECHO pini
	MOVLW      16
	MOVWF      TRISB+0
;ParkUygulamas_LastEdition.c,25 :: 		TRISC.B3 = 0;
	BCF        TRISC+0, 3
;ParkUygulamas_LastEdition.c,26 :: 		Sound_Init(&PORTC, 3);
	MOVLW      PORTC+0
	MOVWF      FARG_Sound_Init_snd_port+0
	MOVLW      3
	MOVWF      FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;ParkUygulamas_LastEdition.c,27 :: 		Lcd_Out(1,1,"Park Sensoru");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ParkUygulamas_LastEdition+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,28 :: 		Lcd_Out(2,1,"Uygulamasi");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_ParkUygulamas_LastEdition+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,30 :: 		Delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;ParkUygulamas_LastEdition.c,31 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ParkUygulamas_LastEdition.c,33 :: 		Lcd_Out(1,1,"Emre Gultekir");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_ParkUygulamas_LastEdition+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,34 :: 		Lcd_Out(2,1,"Enes Ileri");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_ParkUygulamas_LastEdition+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,36 :: 		Delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;ParkUygulamas_LastEdition.c,37 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ParkUygulamas_LastEdition.c,39 :: 		T1CON = 0x10;                        // Timer modülü
	MOVLW      16
	MOVWF      T1CON+0
;ParkUygulamas_LastEdition.c,41 :: 		while(1)
L_main2:
;ParkUygulamas_LastEdition.c,43 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;ParkUygulamas_LastEdition.c,44 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;ParkUygulamas_LastEdition.c,46 :: 		PORTB.F0 = 1;
	BSF        PORTB+0, 0
;ParkUygulamas_LastEdition.c,47 :: 		Delay_us(10);                               // 10uS bekle
	MOVLW      6
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	NOP
;ParkUygulamas_LastEdition.c,48 :: 		PORTB.F0 = 0;
	BCF        PORTB+0, 0
;ParkUygulamas_LastEdition.c,50 :: 		while(!PORTB.F4);                           // ECHO pinini bekle
L_main5:
	BTFSC      PORTB+0, 4
	GOTO       L_main6
	GOTO       L_main5
L_main6:
;ParkUygulamas_LastEdition.c,51 :: 		T1CON.F0 = 1;                               // Timer baþlatýldý
	BSF        T1CON+0, 0
;ParkUygulamas_LastEdition.c,52 :: 		while(PORTB.F4);
L_main7:
	BTFSS      PORTB+0, 4
	GOTO       L_main8
	GOTO       L_main7
L_main8:
;ParkUygulamas_LastEdition.c,53 :: 		T1CON.F0 = 0;                              // Timer durduruldu
	BCF        T1CON+0, 0
;ParkUygulamas_LastEdition.c,55 :: 		mesafe = (TMR1L | (TMR1H<<8));           // Timer deðeri okunuyor
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      main_mesafe_L0+0
	MOVF       R0+1, 0
	MOVWF      main_mesafe_L0+1
;ParkUygulamas_LastEdition.c,56 :: 		mesafe = mesafe/58.82;
	CALL       _int2double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      main_mesafe_L0+0
	MOVF       R0+1, 0
	MOVWF      main_mesafe_L0+1
;ParkUygulamas_LastEdition.c,57 :: 		mesafe = mesafe+1;                             // Mesafe hesaplanýyor
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      main_mesafe_L0+0
	MOVF       R2+1, 0
	MOVWF      main_mesafe_L0+1
;ParkUygulamas_LastEdition.c,59 :: 		if (mesafe >= 2 && mesafe <= 400)
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      2
	SUBWF      R2+0, 0
L__main31:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_mesafe_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       main_mesafe_L0+0, 0
	SUBLW      144
L__main32:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
L__main29:
;ParkUygulamas_LastEdition.c,61 :: 		if (mesafe >= 2 && mesafe <= 15)
	MOVLW      128
	XORWF      main_mesafe_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      2
	SUBWF      main_mesafe_L0+0, 0
L__main33:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_mesafe_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVF       main_mesafe_L0+0, 0
	SUBLW      15
L__main34:
	BTFSS      STATUS+0, 0
	GOTO       L_main14
L__main28:
;ParkUygulamas_LastEdition.c,63 :: 		Sound_Play(400, 100);
	MOVLW      144
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      100
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;ParkUygulamas_LastEdition.c,64 :: 		delay_ms(30);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
;ParkUygulamas_LastEdition.c,65 :: 		PORTA.B0 = 1;
	BSF        PORTA+0, 0
;ParkUygulamas_LastEdition.c,66 :: 		}
L_main14:
;ParkUygulamas_LastEdition.c,67 :: 		if (mesafe >= 16 && mesafe <= 30)
	MOVLW      128
	XORWF      main_mesafe_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      16
	SUBWF      main_mesafe_L0+0, 0
L__main35:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_mesafe_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVF       main_mesafe_L0+0, 0
	SUBLW      30
L__main36:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
L__main27:
;ParkUygulamas_LastEdition.c,69 :: 		Sound_Play(400, 200);
	MOVLW      144
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      200
	MOVWF      FARG_Sound_Play_duration_ms+0
	CLRF       FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;ParkUygulamas_LastEdition.c,70 :: 		delay_ms(120);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      56
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
;ParkUygulamas_LastEdition.c,71 :: 		PORTA.B1 = 1;
	BSF        PORTA+0, 1
;ParkUygulamas_LastEdition.c,72 :: 		}
L_main18:
;ParkUygulamas_LastEdition.c,73 :: 		if (mesafe >= 31 && mesafe <= 60)
	MOVLW      128
	XORWF      main_mesafe_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main37
	MOVLW      31
	SUBWF      main_mesafe_L0+0, 0
L__main37:
	BTFSS      STATUS+0, 0
	GOTO       L_main22
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_mesafe_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main38
	MOVF       main_mesafe_L0+0, 0
	SUBLW      60
L__main38:
	BTFSS      STATUS+0, 0
	GOTO       L_main22
L__main26:
;ParkUygulamas_LastEdition.c,75 :: 		Sound_Play(400, 300);
	MOVLW      144
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVLW      44
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVLW      1
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;ParkUygulamas_LastEdition.c,76 :: 		delay_ms(240);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
;ParkUygulamas_LastEdition.c,77 :: 		PORTA.B2 = 1;
	BSF        PORTA+0, 2
;ParkUygulamas_LastEdition.c,78 :: 		}
L_main22:
;ParkUygulamas_LastEdition.c,80 :: 		IntToStr(mesafe,lcd_yaz);
	MOVF       main_mesafe_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_mesafe_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_lcd_yaz_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;ParkUygulamas_LastEdition.c,81 :: 		Ltrim(lcd_yaz);
	MOVLW      main_lcd_yaz_L0+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;ParkUygulamas_LastEdition.c,82 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ParkUygulamas_LastEdition.c,84 :: 		Lcd_Out(1,1,"Mesafe = ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_ParkUygulamas_LastEdition+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,85 :: 		Lcd_Out(1,12,lcd_yaz);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_lcd_yaz_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,86 :: 		Lcd_Out(1,15,"cm");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_ParkUygulamas_LastEdition+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,87 :: 		}
	GOTO       L_main24
L_main11:
;ParkUygulamas_LastEdition.c,91 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ParkUygulamas_LastEdition.c,92 :: 		Lcd_Out(1,1,"Menzil disi.");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_ParkUygulamas_LastEdition+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ParkUygulamas_LastEdition.c,93 :: 		}
L_main24:
;ParkUygulamas_LastEdition.c,94 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
;ParkUygulamas_LastEdition.c,95 :: 		}
	GOTO       L_main2
;ParkUygulamas_LastEdition.c,96 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
