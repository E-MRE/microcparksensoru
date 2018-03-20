#line 1 "C:/Users/asus/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/Development Systems/EASYPIC7/Led Blinking/ParkUygulamas_LastEdition.c"
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

void main()
{
 int mesafe;
 char lcd_yaz[15];
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 TRISA = 0b00000000;
 TRISB = 0b00010000;
 TRISC.B3 = 0;
 Sound_Init(&PORTC, 3);
 Lcd_Out(1,1,"Park Sensoru");
 Lcd_Out(2,1,"Uygulamasi");

 Delay_ms(500);
 Lcd_Cmd(_LCD_CLEAR);

 Lcd_Out(1,1,"Emre Gultekir");
 Lcd_Out(2,1,"Enes Ileri");

 Delay_ms(500);
 Lcd_Cmd(_LCD_CLEAR);

 T1CON = 0x10;

 while(1)
 {
 TMR1H = 0;
 TMR1L = 0;

 PORTB.F0 = 1;
 Delay_us(10);
 PORTB.F0 = 0;

 while(!PORTB.F4);
 T1CON.F0 = 1;
 while(PORTB.F4);
 T1CON.F0 = 0;

 mesafe = (TMR1L | (TMR1H<<8));
 mesafe = mesafe/58.82;
 mesafe = mesafe+1;

 if (mesafe >= 2 && mesafe <= 400)
 {
 if (mesafe >= 2 && mesafe <= 15)
 {
 Sound_Play(400, 100);
 delay_ms(30);
 PORTA.B0 = 1;
 }
 if (mesafe >= 16 && mesafe <= 30)
 {
 Sound_Play(400, 200);
 delay_ms(120);
 PORTA.B1 = 1;
 }
 if (mesafe >= 31 && mesafe <= 60)
 {
 Sound_Play(400, 300);
 delay_ms(240);
 PORTA.B2 = 1;
 }

 IntToStr(mesafe,lcd_yaz);
 Ltrim(lcd_yaz);
 Lcd_Cmd(_LCD_CLEAR);

 Lcd_Out(1,1,"Mesafe = ");
 Lcd_Out(1,12,lcd_yaz);
 Lcd_Out(1,15,"cm");
 }

 else
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Menzil disi.");
 }
 Delay_ms(400);
 }
}
