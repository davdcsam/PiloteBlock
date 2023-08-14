//+------------------------------------------------------------------+
//|                                                   ProfitStep.mq5 |
//|                                         Copyright 2023, DavdCsam |
//|                                      https://github.com/davdcsam |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, DavdCsam"
#property link      "https://github.com/davdcsam"

#include "features\\enum.mqh"
#include "features\\timer.mqh"
#include "features\\trailing_stop.mqh"
#include "features\\send_order.mqh"
#include "features\\select_operation.mqh"
#include "features\\candle_struct.mqh"
#include "features\\ema.mqh"
#include "features\\limit_operation.mqh"
#include "features\\set_timer.mqh"

void operation_module()
    {
        if(rates[1].close < rates[candle_struct_last_pilote_bearish_index].low && ema_flag_bearish == ON && limit_operation_flag == OFF && set_timer_state == ON)
            {
                select_position_bearish();
            }
            
        if(rates[1].close > rates[candle_struct_last_pilote_bullish_index].high && ema_flag_bullish == ON && limit_operation_flag == OFF && set_timer_state == ON)
            {
                select_position_bullish();
            }            
    }

int OnInit()
    {
        ema_oninit();
        
        return(INIT_SUCCEEDED);
    }

void OnDeinit(const int reason) {Comment("");}

void OnTick()
    {
        timer_ontick();
        
        send_order_ontick();
        
        select_position_ontick();
        
        trailing_stop_ontick();
        
        candle_struct_ontick();
        
        ema_ontick();
        
        limit_operation_ontick();
        
        operation_module();
    
        Comment(
               timer_string,
               send_order_string,
               select_position_string,
               trailing_stop_string,
               candle_struct_string,
               ema_string,
               limit_operation_string,
               "\n\n ", EnumToString(set_timer_state)
        );
    }
    
void OnTradeTransaction(const MqlTradeTransaction& transaction, const MqlTradeRequest& request, const MqlTradeResult& result)
    {
        if(transaction.type == TRADE_TRANSACTION_ORDER_ADD && transaction.order_type == ORDER_TYPE_BUY)
            {
                set_timer_last_operation = ORDER_TYPE_SELL;
            }

        if(transaction.type == TRADE_TRANSACTION_ORDER_DELETE && transaction.order_type == set_timer_last_operation)
            {
                EventSetTimer(set_timer);
                
                set_timer_state = OFF;
            }            
    }

void OnTimer()
    {
        set_timer_state = ON;
    }