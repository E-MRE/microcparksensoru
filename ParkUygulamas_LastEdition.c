sbit LCD_RS at RD2_bit;                                 // LCD RS pini tan�mlamas�
sbit LCD_EN at RD3_bit;                                 // LCD EN pini tan�mlamas�
sbit LCD_D4 at RD4_bit;                                 // LCD D4 pini tan�mlamas�
sbit LCD_D5 at RD5_bit;                                 // LCD D5 pini tan�mlamas�
sbit LCD_D6 at RD6_bit;                                 // LCD D6 pini tan�mlamas�
sbit LCD_D7 at RD7_bit;                                 // LCD D7 pini tan�mlamas�

sbit LCD_RS_Direction at TRISD2_bit;                    // LCD RS pini tan�mlamas�
sbit LCD_EN_Direction at TRISD3_bit;                    // LCD EN pini tan�mlamas�
sbit LCD_D4_Direction at TRISD4_bit;                    // LCD D4 pini tan�mlamas�
sbit LCD_D5_Direction at TRISD5_bit;                    // LCD D5 pini tan�mlamas�
sbit LCD_D6_Direction at TRISD6_bit;                    // LCD D6 pini tan�mlamas�
sbit LCD_D7_Direction at TRISD7_bit;                    // LCD D7 pini tan�mlamas�

int mesafe;                                             // Mesafe �l��m� i�in kullan�lan de�i�ken.
char lcd_yaz[15];                                       // LCD ' de yazmak i�in kullan�lan dizi.
  
void main()
{
  TRISA = 0b00000000;                                   // A portunu tamamen ��k�� yap�yoruz.
  TRISB = 0b00010000;                                   // B portunu B4 pini hari� ��k�� yap�yoruz. ( B4 ECHO pini )
  TRISC.B3 = 0;                                         // Buzzer pini.
  
  Lcd_Init();                                           // LCD kullanaca��m�z� belirten kod sat�r�.
  Lcd_Cmd(_LCD_CLEAR);                                  // LCD temizleme kod sat�r�.
  Lcd_Cmd(_LCD_CURSOR_OFF);                             // LCD imlecini kapatan kod sat�r�.
  
  Sound_Init(&PORTC, 3);                                // Buzzer ' � C3 pinine ba�lad�k.
  
  Lcd_Out(1,1,"Park Sensoru");
  Lcd_Out(2,1,"Uygulamasi");

  Delay_ms(500);
  Lcd_Cmd(_LCD_CLEAR);                                  // LCD temizleme kod sat�r�.

  Lcd_Out(1,1,"Emre Gultekir");
  Lcd_Out(2,1,"Enes Ileri");

  Delay_ms(500);
  Lcd_Cmd(_LCD_CLEAR);

  T1CON = 0x10;                                        // Timer  modul�n� ba�latma

  while(1)
  {
    TMR1H = 0;                                        // Timer '�n ba�lang�� de�erini ayarlar. ( HIGH )
    TMR1L = 0;                                        // Timer ' �n ba�lang�� de�erini ayarlar. ( LOW )

    PORTB.B0 = 1;                                     // TRIG pin aktifle�tirilir.
    Delay_us(10);                                     // 10 mikrosaniye beklenir.
    PORTB.B0 = 0;                                     // TRIG pin pasifle�tirilir.

    while(!PORTB.B4);                                 // ECHO pini pasife timer �al���r.
    T1CON.B0 = 1;                                     // Timer ba�lat�ld�.
    while(PORTB.B4);                                  // ECHO pini aktifse timer durdurulur.
    T1CON.B0 = 0;                                     // Timer durduruldu.

    mesafe = (TMR1L | (TMR1H<<8));                    // Timer de�eri okunuyor.
    mesafe = mesafe/58.82;                            // S�reyi mesafeye d�n��t�r�r.
    mesafe = mesafe+1;                                // Mesafe kalibre ediliyor.

    if (mesafe >= 2 && mesafe <= 400)                 // Sens�r�m�z 2 cm ile 400 cm aras�nda �al���yor.
    {
    if (mesafe >= 2 && mesafe <= 15)                  // Engel 2 cm ile 15 cm aras�nda ise
    {
    Sound_Play(400, 100);                             // 400 Hz frekans�nda 100 ms boyunca ses ��kar�l�yor.
    delay_ms(30);
    PORTA.B0 = 1;                                     // K�rm�z� led aktif ediliyor.
    }
    if (mesafe >= 16 && mesafe <= 30)                 // Sens�r�m�z 16 cm ile 30 cm aras�nda ise
    {
    Sound_Play(400, 200);                             // 400 Hz frekans�nda 200 ms boyunca ses ��kar�l�yor.
    delay_ms(120);
    PORTA.B1 = 1;                                     // Sar� led aktif ediliyor.
    }
    if (mesafe >= 31 && mesafe <= 60)                 // Sens�r�m�z 31 cm ile 60 cm aras�nda ise
    {
    Sound_Play(400, 300);                             // 400 Hz frekans�nda 300 ms boyunca ses ��kar�l�yor.
    delay_ms(240);
    PORTA.B2 = 1;                                     // Ye�il led aktif ediliyor.
    }

      IntToStr(mesafe,lcd_yaz);                       // Mesafe de�eri string ' e �eviriliyor.
      Ltrim(lcd_yaz);                                 // Sol taraftaki ( ba�taki ) bo�luklar siliniyor.
      Lcd_Cmd(_LCD_CLEAR);                            // LCD temizleniyor.

      Lcd_Out(1,1,"Mesafe = ");
      Lcd_Out(1,12,lcd_yaz);                          // LCD ' nin 1. sat�r 12. s�tununa mesafe yazd�r�l�yor.
      Lcd_Out(1,15,"cm");
    }

    else                                              // Aral�k d���ndaysa
    {
      Lcd_Cmd(_LCD_CLEAR);                            // LCD temizleniyor.
      Lcd_Out(1,1,"Menzil disi.");                    // 1. sat�r 1. s�tuna 'Menzil disi' yazd�r�l�yor.
    }
    Delay_ms(400);
  }
}