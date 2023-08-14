#include "enum.mqh"

input group "Timer"

input int set_timer = 21600;//Time Between Each Operation

turn set_timer_state = ON;

ENUM_ORDER_TYPE set_timer_last_operation;