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
input int            Line_Out_width =     3;            // Толщина внешней линии
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

int shag_1 = 0;
int shag_2 = 0;

double max_hight = 0;
double max_price = 0;

datetime LastActiontime, LastActiontime2, LastActiontime3, LastActiontime4,LastActiontime5,LastActiontime6,LastActiontime7;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator line
//SetIndexStyle(0, DRAW_ARROW, LineOutStyle,Line_Out_width,Line_Out_color);
   SetIndexStyle(0, DRAW_ARROW, 0,Line_Out_width,Line_Out_color);
   SetIndexLabel(0, "OutLineUp");
   SetIndexArrow(0, 159);
   SetIndexBuffer(0, Buffer1);


   SetIndexStyle(1, DRAW_ARROW, LineOutStyle,Line_Out_width,Line_Out_color);
   SetIndexLabel(1, "OutLineDwn");
   SetIndexBuffer(1, Buffer2);

   SetIndexStyle(2, DRAW_ARROW, 0,Line_In_width,Line_In_color);
//SetIndexStyle(2, DRAW_ARROW);
   SetIndexLabel(2, "InLineUp");
   SetIndexArrow(2, 159);
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
//int limit = Bars + 1;
   int limit = 200;


   for(int i=limit; i>=0; i--)
     {
      //int val_index=iHighest(NULL,0,MODE_HIGH,10,i);
      //Buffer1[i] = High[val_index];
     // if(High[i+1] > High[i+2])
     //   {
     //    Buffer1[i+2] = High[i+1];
     //   }
    //  else
    //    {
     //    Buffer1[i+2] = High[i+2];
    //    }
    if
        Buffer1[i+1] = High[iHighest(NULL,0,MODE_HIGH,PeriodOutLine*2,i)];
     }

   shag_1 ++;
/*
   if(High[1] > High[2])
     {
      Buffer1[1] = High[2];
     }
   else
     {
      Buffer1[1] = High[1];
     }
*/
// max_price = GetMaxHigh(shag_1);
//Buffer1[1] = max_price;

   /*

      if(shag_1 < 8 && (High[0] < max_price || max_price == 0))
        {
         max_price = GetMaxHigh(shag_1);

         Buffer1[1] = max_price;
         Buffer3[1] = EMPTY_VALUE;
        }

      if(shag_1 > 8  && shag_1 < 12  && High[0] < max_price)
        {
         max_price = GetMaxHigh(shag_1);

         Buffer1[1] = EMPTY_VALUE;
         Buffer3[1] = max_price;
        }

      if(shag_1 < 8 && High[0] > max_price && max_price != 0)
        {
         Print("TUT");
         shag_1 = 0;
         max_price = 0;

         //Buffer1[1] = max_price;
         //Buffer3[1] = EMPTY_VALUE;

        }

   */


//int limit = Bars + 1;
//int limit = 200;
// int y;
//Print(limit);

//i = 200;

// Задаем индекс свечи, с которой начнется линия (в вашем случае 20)
//int startIndex = 20;

// Задаем цену для линии (ваша цена High[20])
// double price = High[startIndex];

// for(int i=limit; i>=0; i--)
//  {
//zHight = iHighest(NULL,0,MODE_HIGH,PeriodOutLine*2,i);
//Buffer1[i]=High[zHight];

//  zHight = iHighest(NULL,0,MODE_HIGH,PeriodOutLine*2,i);

//  Buffer1[i] = EMPTY_VALUE;
// Buffer3[i] = EMPTY_VALUE;

//  if(Buffer3[i+ 1] != EMPTY_VALUE && Buffer3[i+ 2] != EMPTY_VALUE && Buffer3[i+ 3] != EMPTY_VALUE && Buffer3[i+ 4] != EMPTY_VALUE)
//  {
//    Buffer1[i] = High[zHight];
//Buffer3[i]=High[zHight];
//   }
// else
//   {
//    Buffer1[i] = EMPTY_VALUE;
//    Buffer3[i]=High[zHight];
//   }
//Buffer1[i]=High[zHight];

//Buffer1[i] = High[zHight];
//createLine(zHight);
//Print(find_min_two_digit(zHight));


//Print(i);
// }


   /*

      while(i>=limit)
        {
         zHight = iHighest(NULL,0,MODE_HIGH,PeriodOutLine*2,i);
         zLow = iLowest(NULL,0,MODE_LOW,PeriodOutLine*2,i);

         zOpen = iHighest(NULL,0,MODE_OPEN,PeriodOutLine*2,i);
         zClose = iLowest(NULL,0,MODE_CLOSE,PeriodOutLine*2,i);
         Print(i);

         Buffer1[i] = High[zHight];
         /* Print(i);
          y=i+PeriodOutLine*2-0;
          while(y>=i )
            {
             Buffer1[y] = 0;
             Buffer1[y] = High[zHight];

             Buffer2[y] = 0;
             Buffer2[y] = Low[zLow];

             Buffer3[y] = 0;
             Buffer3[y] = Open[zOpen];

             Buffer4[y] = 0;
             Buffer4[y] = Close[zClose];
             ObjectCreate

             y--;
            }
         //  ObjectCreate(0, "Line", OBJ_HLINE,0, Time[i-9],High[zHight],Time[i],High[zHight]);

         //i-=PeriodOutLine*2;
         i--;
        }*/

   return(rates_total);
  }
//+------------------------------------------------------------------+
double GetMaxHigh(int distance)
  {
   double maxHigh = 0;
   for(int i = 0; i < distance; i++)
     {
      double high = High[i];
      if(high > maxHigh)
        {
         maxHigh = high;
        }
     }
   return maxHigh;
  }

//+------------------------------------------------------------------+
int createLine(int index, int starts)
  {
   string name = "Hight_"+index;
   int lineIndex = ObjectCreate(0, name, OBJ_TREND, 0, 0, 0);
   ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, false);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrBlue); // Цвет линии
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 1); // Толщина линии
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID); // Стиль линии
   ObjectSetDouble(0, name, OBJPROP_PRICE1, High[index]); // Устанавливаем цену
   ObjectSetDouble(0, name, OBJPROP_PRICE2, High[index]); // Устанавливаем цену

// Теперь нужно задать время и индекс свечи
   ObjectSetInteger(0, name, OBJPROP_TIME1, Time[starts]); // Время свечи
   ObjectSetInteger(0, name, OBJPROP_RAY_LEFT, false); // Рисовать линию влево

   ObjectSetInteger(0, name, OBJPROP_TIME2, Time[starts-9]); // Время свечи
   return lineIndex;
  }


/*

  // for(int i = limit; i >= 1; i--)
     for(int i = 200; i >= 1; i-=PeriodOutLine*2)
       {
        //Buffer1[i] = iHighest(Symbol(), PERIOD_CURRENT, MODE_HIGH, 9,i);

        int val_index=iHighest(NULL,0,MODE_HIGH,8,i);
        Buffer1[i] = High[val_index];

        /*
          if(Open[i] > Close[i])
            {
             Buffer1[i] = High[i];
            }

       }*/
/*
   for(int i = 200; i >= 1; i-=PeriodOutLine*2)
     {
      //double price = High[i] + (High[i] - Low[i]) * 0.1; // Высота точки над свечей
      if(Open[i] > Close[i])
        {
         Buffer1[i] = High[i];
        }

     }

*/

//+------------------------------------------------------------------+
