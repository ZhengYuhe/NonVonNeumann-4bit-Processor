`ifndef INTERNAL_DEFINES_VH_
`define INTERNAL_DEFINES_VH_
typedef enum logic [3:0] {
    PE0,
    PE1,
    PE2,
    PE3, 
    IN_OP_0,
    IN_OP_1,
    IN_OP_DC = 'bx
} sel_op_t;

typedef enum logic [2:0] {
    ALU_AND,
    ALU_OR,
    ALU_NOT,
    ALU_SLL,
    ALU_SRL,
    ALU_DC = 'bx
} alu_op_t;


typedef struct packed {
    sel_op_t sel_op_0; //select input to first operea
    sel_op_t sel_op_1;
    alu_op_t alu_op;
}ctrl_signals_t;

`endif