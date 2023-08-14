#include "enum.mqh"

input group "EMA"

input int ema_period_1 = 200;//Period EMA 1

input int ema_period_2 = 50;//Period EMA 2

input int ema_min_limit_confirm_trend = 3;//Minimum Limint to Confirm Trend

input ENUM_TIMEFRAMES ema_timeframes = PERIOD_CURRENT;//Timeframes

input ENUM_MA_METHOD ema_method = MODE_EMA;//Method

input ENUM_APPLIED_PRICE ema_applied_price = PRICE_CLOSE;//Applied Price

input int ema_copied_candles = 10;//Copied Candles

input turn ema_show_string = ON;//Show String

double ema_1[];

double ema_2[];

int ema_handler_1;

int ema_handler_2;

turn ema_flag_bullish = OFF;

turn ema_flag_bearish = OFF;

string ema_string;

void ema_oninit()
    {
        ema_handler_1 = iMA(_Symbol, ema_timeframes, ema_period_1, 0, ema_method, ema_applied_price);

        ema_handler_2 = iMA(_Symbol, ema_timeframes, ema_period_2, 0, ema_method, ema_applied_price);

        ArraySetAsSeries(ema_1, true);

        ArraySetAsSeries(ema_2, true);
    }

void ema_ontick()
    {
        CopyBuffer(ema_handler_1, 0, 0, ema_copied_candles, ema_1);

        CopyBuffer(ema_handler_2, 0, 0, ema_copied_candles, ema_2);
        
        for(int i=0; i<ema_min_limit_confirm_trend; i++)
            {
                if(ema_2[i] < ema_1[i])
                    {
                        ema_flag_bullish = OFF;
                        break;
                    } ema_flag_bullish = ON;
            }
            
        for(int i=0; i<ema_min_limit_confirm_trend; i++)
            {
                if(ema_2[i] > ema_1[i])
                    {
                        ema_flag_bearish = OFF;
                        break;
                    } ema_flag_bearish = ON;
            }            
/*        
        if(ema_2[0] > ema_1[0] && ema_2[1] > ema_1[1] && ema_1[2] > ema_2[2])
            {
                ema_flag_bullish = ON;
            } else ema_flag_bullish= OFF;

        if(ema_2[0] < ema_1[0] && ema_2[1] < ema_1[1] && ema_1[2] < ema_2[2])
            {
                ema_flag_bearish= ON;
            } else ema_flag_bearish = OFF;
*/
        if(ema_show_string == ON)
            {
                ema_string =
                   "\n"                                    +
                   "      Period Ema 1 " + IntegerToString(ema_period_1) + " EMA "  + IntegerToString(ema_period_2) +
                   "\n"
                   "      Timeframes " + EnumToString(ema_timeframes) + " Method " + EnumToString(ema_method) + " Applied Price " + EnumToString(ema_applied_price) + " Copied " + IntegerToString(ema_copied_candles) +
                   "\n"
                   "      Flag Bullish " + EnumToString(ema_flag_bullish) + " Bearish " + EnumToString(ema_flag_bearish) +
                   "\n";                
            }
    }
