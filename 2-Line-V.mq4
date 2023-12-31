//+------------------------------------------------------------------+
//|                                                       2-Line.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 clrRed
#property indicator_color2 clrBlue
#property indicator_color3 clrGreen
#property indicator_color4 clrYellow
#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 1
#property indicator_width4 1
#property indicator_style1 STYLE_SOLID
#property indicator_style2 STYLE_SOLID
#property indicator_style3 STYLE_SOLID
#property indicator_style4 STYLE_SOLID

enum enOutLineStyle
  {
   style_1  = STYLE_SOLID,                // Сплошная линия
   style_2  = STYLE_DASH,                 // Штриховая линия
   style_3  = STYLE_DOT,                  // Пунктирная линия
   style_4 = STYLE_DASHDOT,               // Штрих-пунктирная линия
   style_5 = STYLE_DASHDOTDOT,            // Штрих-пунктирная линия с двойными точками
  };

enum enIntLineStyle
  {
   style_1_1  = STYLE_SOLID,                // Сплошная линия
   style_2_1  = STYLE_DASH,                 // Штриховая линия
   style_3_1  = STYLE_DOT,                  // Пунктирная линия
   style_4_1 = STYLE_DASHDOT,               // Штрих-пунктирная линия
   style_5_1 = STYLE_DASHDOTDOT,            // Штрих-пунктирная линия с двойными точками
  };


//--- input parameters
input int ma_period = 14;
input ENUM_TIMEFRAMES timeframe = PERIOD_H1;

input color          Line_Out_color =     clrRed;       // Цвет внешней линии
input int            Line_Out_width =     1;            // Толщина внешней линии
input enOutLineStyle LineOutStyle   =     style_1;      // Стиль внешней линии
input int            PeriodOutLine  =     5;            // Глубина внешней линии +/-




input color          Line_In_color  =      clrBlue;      // Цвет внутренней линии
input int            Line_In_width  =      1;            // Толщина внутренней линии
input enIntLineStyle LineInStyle    =      style_2_1;    // Стиль внутренней линии
input int            PeriodInLine   =      5;            // Глубина внутренней линии +/-

//--- buffers
double Buffer1[];
double Buffer2[];
double Buffer3[];
double Buffer4[];


// Объявляем переменные для хранения максимальных значений
double maxHigh = 0;
double prevHigh = 0;

int zHight;
int zLow;
int zOpen;
int zClose;

int EndHight_1 = 1;
int StartHight_1 = 0;
datetime StartTimeHight_1;
datetime EndTimeHight_1 = Time[0];

datetime StartTimeHight_2;
datetime EndTimeHight_2 = Time[0];


int EndHight_2 = 1;

double PriceHight_1 = 0;
double PriceHight_2 = 0;

int countHight_1 = 0;
int countHight_2 = 0;

int countLine = 0;
string Hight_1 = "Hight_";

datetime LastActiontime, LastActiontime2, LastActiontime3, LastActiontime4,LastActiontime5,LastActiontime6,LastActiontime7;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator line
   SetIndexStyle(0, DRAW_ARROW, LineOutStyle,Line_Out_width,Line_Out_color);
   SetIndexLabel(0, "OutLineUp");
   SetIndexBuffer(0, Buffer1);
   SetIndexArrow(0, 108);


   SetIndexStyle(1, DRAW_LINE, LineOutStyle,Line_Out_width,Line_Out_color);
   SetIndexLabel(1, "OutLineDwn");
   SetIndexBuffer(1, Buffer2);

   SetIndexStyle(2, DRAW_LINE, LineInStyle,Line_In_width,Line_In_color);
   SetIndexLabel(2, "InLineUp");
   SetIndexBuffer(2, Buffer3);

   SetIndexStyle(3, DRAW_LINE, LineInStyle,Line_In_width,Line_In_color);
   SetIndexLabel(3, "InLineDwn");
   SetIndexBuffer(3, Buffer4);




//---
   return(INIT_SUCCEEDED);
  }

// Обработчик OnDeinit
void OnDeinit(const int reason)
  {
// Удаляем горизонтальную линию при завершении работы индикатора
   ObjectsDeleteAll();
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   if(LastActiontime!=Time[0])
     {


      countHight_1 ++;
      countHight_2 ++;


      Print(ObjectFind("Hight_1"));


      if(ObjectFind("Hight_"+countLine) < 0)
        {
         countLine++;
         Print("Создана линия №"+countLine);
         StartTimeHight_1 = Time[countHight_1];
         PriceHight_1 = High[0];
         EndTimeHight_1 = Time[0];
         createLine(PriceHight_1, StartTimeHight_1, EndTimeHight_1, "Hight_"+countLine);
        }


      if(ObjectFind("Hight_"+countLine)==0 && ObjectFind("Hight_"+countLine+1) < 0)
        {
         if(High[0] < PriceHight_1 && countHight_1 > 2)
           {
            StartTimeHight_1 = Time[countHight_1];

            if(countHight_1 > 2)
               PriceHight_1 = High[HightPeriod(0, countHight_1)];
            else
               PriceHight_1 = High[0];

            EndTimeHight_1 = Time[0];

            if(countHight_1 < PeriodOutLine*2)
              {
               createLine(PriceHight_1, StartTimeHight_1, EndTimeHight_1, "Hight_"+countLine);
              }
            else
              {
               countLine++;
               Print("Создана линия №"+countLine);
               countHight_2 = 1;
               StartTimeHight_2 = Time[countHight_2];
               PriceHight_2 = High[0];
               EndTimeHight_2 = Time[0];
               createLine(PriceHight_2, StartTimeHight_2, EndTimeHight_2, "Hight_"+countLine);
               createLine(PriceHight_1, StartTimeHight_1, EndTimeHight_1, "Hight_"+(countLine-1));
              }
           }
         else
           {
            if(countHight_1 > 2)
              {
               countLine++;
               Print("Создана линия №"+countLine);
               countHight_1 = 1;
               StartTimeHight_1 = Time[countHight_1];
               PriceHight_1 = High[0];
               EndTimeHight_1 = Time[0];
               createLine(PriceHight_1, StartTimeHight_1, EndTimeHight_1, "Hight_"+countLine);
              }
           }
        }

      if(ObjectFind("Hight_"+(countLine-1))==0 && ObjectFind("Hight_"+countLine) == 0)
        {
         Print("Обработка линий №"+(countLine-1) +" и линии № " + countLine);

        }



      int limit = 90;
      for(int i=limit; i>=0; i-=10)
        {
         //zHight = iHighest(NULL,0,MODE_HIGH,PeriodOutLine*2,i);
         //Buffer1[i]=High[zHight];

         zHight = iHighest(NULL,0,MODE_HIGH,PeriodOutLine*2,i);
         //Buffer1[i]=High[zHight];

         //Buffer1[i] = High[zHight];
         //createLine(zHight);
         //Print(find_min_two_digit(zHight));


         //Print(i);
        }
      LastActiontime=Time[0];
     }

   return(rates_total);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HightPeriod(int starts, int ends)
  {

   int indexHight=0;
   indexHight = iHighest(NULL,0,MODE_HIGH,ends,starts);

   return indexHight;
  }
//+------------------------------------------------------------------+
int find_min_two_digit(int number)
  {
   int tens_digit;
   if(10 <= number <= 99)
      tens_digit = number;
   else
      tens_digit = 10;

   return tens_digit * 10;
  }

//+------------------------------------------------------------------+
int createLine(double price, datetime starts, datetime ends, string name)
  {
//Print(price, starts, ends, name);

   int lineIndex = ObjectCreate(0, name, OBJ_TREND, 0, 0, 0);
   ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, false);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrBlue); // Цвет линии
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 1); // Толщина линии
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID); // Стиль линии
   ObjectSetDouble(0, name, OBJPROP_PRICE1, price); // Устанавливаем цену
   ObjectSetDouble(0, name, OBJPROP_PRICE2, price); // Устанавливаем цену

// Теперь нужно задать время и индекс свечи
   ObjectSetInteger(0, name, OBJPROP_TIME1, starts); // Время свечи
   ObjectSetInteger(0, name, OBJPROP_RAY_LEFT, false); // Рисовать линию влево

   ObjectSetInteger(0, name, OBJPROP_TIME2, ends); // Время свечи
   return lineIndex;
  }


//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
