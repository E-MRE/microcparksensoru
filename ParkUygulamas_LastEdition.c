sbit LCD_RS at RD2_bit;                                 // LCD RS pini tanýmlamasý
sbit LCD_EN at RD3_bit;                                 // LCD EN pini tanýmlamasý
sbit LCD_D4 at RD4_bit;                                 // LCD D4 pini tanýmlamasý
sbit LCD_D5 at RD5_bit;                                 // LCD D5 pini tanýmlamasý
sbit LCD_D6 at RD6_bit;                                 // LCD D6 pini tanýmlamasý
sbit LCD_D7 at RD7_bit;                                 // LCD D7 pini tanýmlamasý

sbit LCD_RS_Direction at TRISD2_bit;                    // LCD RS pini tanýmlamasý
sbit LCD_EN_Direction at TRISD3_bit;                    // LCD EN pini tanýmlamasý
sbit LCD_D4_Direction at TRISD4_bit;                    // LCD D4 pini tanýmlamasý
sbit LCD_D5_Direction at TRISD5_bit;                    // LCD D5 pini tanýmlamasý
sbit LCD_D6_Direction at TRISD6_bit;                    // LCD D6 pini tanýmlamasý
sbit LCD_D7_Direction at TRISD7_bit;                    // LCD D7 pini tanýmlamasý

int mesafe;                                             // Mesafe ölçümü için kullanýlan deðiþken.
char lcd_yaz[15];                                       // LCD ' de yazmak için kullanýlan dizi.
  
void main()
{
  TRISA = 0b00000000;                                   // A portunu tamamen çýkýþ yapýyoruz.
  TRISB = 0b00010000;                                   // B portunu B4 pini hariç çýkýþ yapýyoruz. ( B4 ECHO pini )
  TRISC.B3 = 0;                                         // Buzzer pini.
  
  Lcd_Init();                                           // LCD kullanacaðýmýzý belirten kod satýrý.
  Lcd_Cmd(_LCD_CLEAR);                                  // LCD temizleme kod satýrý.
  Lcd_Cmd(_LCD_CURSOR_OFF);                             // LCD imlecini kapatan kod satýrý.
  
  Sound_Init(&PORTC, 3);                                // Buzzer ' ý C3 pinine baðladýk.
  
  Lcd_Out(1,1,"Park Sensoru");
  Lcd_Out(2,1,"Uygulamasi");

  Delay_ms(500);
  Lcd_Cmd(_LCD_CLEAR);                                  // LCD temizleme kod satýrý.

  Lcd_Out(1,1,"Emre Gultekir");
  Lcd_Out(2,1,"Enes Ileri");

  Delay_ms(500);
  Lcd_Cmd(_LCD_CLEAR);

  T1CON = 0x10;                                        // Timer  modulünü baþlatma

  while(1)
  {
    TMR1H = 0;                                        // Timer 'ýn baþlangýç deðerini ayarlar. ( HIGH )
    TMR1L = 0;                                        // Timer ' ýn baþlangýç deðerini ayarlar. ( LOW )

    PORTB.B0 = 1;                                     // TRIG pin aktifleþtirilir.
    Delay_us(10);                                     // 10 mikrosaniye beklenir.
    PORTB.B0 = 0;                                     // TRIG pin pasifleþtirilir.

    while(!PORTB.B4);                                 // ECHO pini pasife timer çalýþýr.
    T1CON.B0 = 1;                                     // Timer baþlatýldý.
    while(PORTB.B4);                                  // ECHO pini aktifse timer durdurulur.
    T1CON.B0 = 0;                                     // Timer durduruldu.

    mesafe = (TMR1L | (TMR1H<<8));                    // Timer deðeri okunuyor.
    mesafe = mesafe/58.82;                            // Süreyi mesafeye dönüþtürür.
    mesafe = mesafe+1;                                // Mesafe kalibre ediliyor.

    if (mesafe >= 2 && mesafe <= 400)                 // Sensörümüz 2 cm ile 400 cm arasýnda çalýþýyor.
    {
    if (mesafe >= 2 && mesafe <= 15)                  // Engel 2 cm ile 15 cm arasýnda ise
    {
    Sound_Play(400, 100);                             // 400 Hz frekansýnda 100 ms boyunca ses çýkarýlýyor.
    delay_ms(30);
    PORTA.B0 = 1;                                     // Kýrmýzý led aktif ediliyor.
    }
    if (mesafe >= 16 && mesafe <= 30)                 // Sensörümüz 16 cm ile 30 cm arasýnda ise
    {
    Sound_Play(400, 200);                             // 400 Hz frekansýnda 200 ms boyunca ses çýkarýlýyor.
    delay_ms(120);
    PORTA.B1 = 1;                                     // Sarý led aktif ediliyor.
    }
    if (mesafe >= 31 && mesafe <= 60)                 // Sensörümüz 31 cm ile 60 cm arasýnda ise
    {
    Sound_Play(400, 300);                             // 400 Hz frekansýnda 300 ms boyunca ses çýkarýlýyor.
    delay_ms(240);
    PORTA.B2 = 1;                                     // Yeþil led aktif ediliyor.
    }

      IntToStr(mesafe,lcd_yaz);                       // Mesafe deðeri string ' e çeviriliyor.
      Ltrim(lcd_yaz);                                 // Sol taraftaki ( baþtaki ) boþluklar siliniyor.
      Lcd_Cmd(_LCD_CLEAR);                            // LCD temizleniyor.

      Lcd_Out(1,1,"Mesafe = ");
      Lcd_Out(1,12,lcd_yaz);                          // LCD ' nin 1. satýr 12. sütununa mesafe yazdýrýlýyor.
      Lcd_Out(1,15,"cm");
    }

    else                                              // Aralýk dýþýndaysa
    {
      Lcd_Cmd(_LCD_CLEAR);                            // LCD temizleniyor.
      Lcd_Out(1,1,"Menzil disi.");                    // 1. satýr 1. sütuna 'Menzil disi' yazdýrýlýyor.
    }
    Delay_ms(400);
  }
}