#include "enum.mqh"
#include "timer.mqh"

input group "Limit Per Operation"

input turn active_limit_per_candle = ON;//Active

input turn limit_per_candle_show_string = ON;//Show String

int limit_per_candle_last_operation;

turn limit_per_candle_flag = OFF;

string limit_per_candle_string;

void limit_per_candle_ontick()
    {
        if(active_limit_per_candle == ON)
            {
                if(limit_per_candle_last_operation != iBars(_Symbol, PERIOD_CURRENT))
                    {
                        limit_per_candle_flag = ON;
                    } else limit_per_candle_flag = OFF;
            }
                
        if(limit_per_candle_show_string == ON)
            {
                limit_per_candle_string =
                    "\n" +
                    "      Limit Per Candle " + EnumToString(limit_per_candle_flag) +
                    "\n";
            }     
    }