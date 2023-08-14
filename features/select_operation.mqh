#include "send_order.mqh"

input group "Select Operation"

input ENUM_ORDER_TYPE select_position_input_bearish = ORDER_TYPE_SELL;//Select Order for Bearish

input ENUM_ORDER_TYPE select_position_input_bullish = ORDER_TYPE_BUY;//Select Order for Bullish

input turn select_position_show_string = ON;//Show String

string select_position_string;

void select_position_bearish()
    {
        switch(select_position_input_bearish)
            {
               case ORDER_TYPE_BUY:
                    buy_function();
                 break;
               case ORDER_TYPE_SELL:
                    sell_function();
                 break;
               default:
                    Print("Only select ", EnumToString(ORDER_TYPE_BUY), " or ", EnumToString(ORDER_TYPE_SELL));
                 break;
            }
    }

void select_position_bullish()
    {
        switch(select_position_input_bullish)
            {
               case ORDER_TYPE_BUY:
                    buy_function();
                 break;
               case ORDER_TYPE_SELL:
                    sell_function();
                 break;
               default:
                    Print("Only select ", EnumToString(ORDER_TYPE_BUY), " or ", EnumToString(ORDER_TYPE_SELL));
                 break;
            }
    }
    
void select_position_ontick()
    {
        if(select_position_show_string == ON)
            {
                select_position_string = 
                    "\n" +
                    "      Bearish " + EnumToString(select_position_input_bearish) + "   " + " Bullish " + EnumToString(select_position_input_bullish) +
                    "\n";               
            }
    }    