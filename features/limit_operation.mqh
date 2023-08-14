#include "enum.mqh"
#include "send_order.mqh"

input group "Limit Operation"

input turn active_limit_operation = ON; // Active

input int limit_operation_max = 1; // Max Operation Open

input turn limit_operation_show_string = ON;//Show String

turn limit_operation_flag = OFF;

int limit_operation_total_position;

string limit_operation_string;

void limit_operation_ontick()
    {
        if(active_limit_operation == ON)
            {
                limit_operation_total_position = 0;
         
                for(int i = PositionsTotal() -1; i >= 0; i--)
                    {
                        ulong position_ticket = PositionGetTicket(i);
                  
                        if(PositionSelectByTicket(position_ticket))
                            {
                                if(PositionGetString(POSITION_SYMBOL) == _Symbol && PositionGetInteger(POSITION_MAGIC) == magic_number)
                                    {
                                        limit_operation_total_position++;
                                    }
                            }
                    }
                
                if(limit_operation_total_position >= limit_operation_max) { limit_operation_flag = ON; }
                else limit_operation_flag = OFF;                    
            }
            
        if(limit_operation_show_string == ON)
            {
                 limit_operation_string =
                    "\n" +
                    "      Limit Operation               "  + EnumToString(active_limit_operation) +
                    "\n"
                    "      Max Open                   "    + IntegerToString(limit_operation_max) +
                    "\n";          
            }
    }