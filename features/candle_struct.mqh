#include "enum.mqh"

input group "Candle Struct"

input uint candle_struct_rates = 100;//Rates

input ENUM_TIMEFRAMES candle_struct_timeframes = PERIOD_CURRENT;//Timeframes

input turn candle_struct_show_string = ON;//Show String

uint candle_struct_pilote_arms = 2;

uint candle_struct_last_pilote_bearish_index;

uint candle_struct_last_pilote_bullish_index;

double candle_struct_last_pilote_bearish;

double candle_struct_last_pilote_bullish;

string candle_struct_string;

MqlRates rates[];

void candle_struct_ontick()
    {
        CopyRates(_Symbol, candle_struct_timeframes, 0, candle_struct_rates, rates);
        
        ArraySetAsSeries(rates, true);

        for(uint i = candle_struct_pilote_arms; i < candle_struct_rates - candle_struct_pilote_arms; i++)
            {
                if(rates[i+1].high > rates[i+2].high && rates[i].high > rates[i+1].high &&  rates[i].high > rates[i-1].high && rates[i-1].high > rates[i-2].high)
                    {
                        candle_struct_last_pilote_bullish = rates[i].high;
                        
                        candle_struct_last_pilote_bullish_index = i;
                        
                        //Print("Index Bullish ", IntegerToString(i), " ", DoubleToString(rates[i].high));
                        
                        break;
                    }
            }

        for(uint i = candle_struct_pilote_arms + 1; i < candle_struct_rates - candle_struct_pilote_arms; i++)
            {
                if(rates[i+1].low < rates[i+2].low && rates[i].low < rates[i+1].low && rates[i].low < rates[i-1].low && rates[i-1].low < rates[i-2].low)
                    {
                        candle_struct_last_pilote_bearish= rates[i].low;
                        
                        candle_struct_last_pilote_bearish_index = i;
                        
                        //Print("Index Bearish ", IntegerToString(i), " ", DoubleToString(rates[i].low));
                        
                        break;
                    }
            }
        if(candle_struct_show_string == ON)
            {
                candle_struct_string =
                       "\n" +
                       "      Index Bullish " + IntegerToString(candle_struct_last_pilote_bullish_index) + " " + DoubleToString(rates[candle_struct_last_pilote_bullish_index].high, 2) +
                       "\n" +
                       "      Index Bearish " + IntegerToString(candle_struct_last_pilote_bearish_index) + " " + DoubleToString(rates[candle_struct_last_pilote_bearish_index].low, 2) +
                       "\n";           
            }    
    }