`include "internal_defines.vh"
module PE (
    input  ctr_signals_t ctr_signals_in,
    input  logic         clock, en, reset,
    input  logic [3:0]   PE_out_0,PE_out_1,PE_out_2,PE_out_3, 
    input  logic [3:0]   in_op_0, in_op_1,
    input  logic [3:0]   PE_reg_out_0,PE_reg_out1,PE_reg_out2
    output logic [3:0]   out);

    ctr_signals_t ctr_signals;
    logic [3:0] operand0, operand1, alu_src0, alu_src1;

    register #($bits(ctr_signals), 'h0) Ctrl_Register(.clock, .reset, .en, .clear(1'b0), 
                                        .D(ctr_signals_in), .Q(ctr_signals));
    mux #(8, $bits(in_op_0)) alu_src0_mux(.in({PE_out_0,PE_out_1,PE_out_2,PE_out_3, PE_reg_out_0,PE_reg_out1,PE_reg_out2, in_op_0}), 
                                          .sel(ctr_signals.sel_op_0), .out(operand0));
    mux #(8, $bits(in_op_1)) alu_src1_mux(.in({PE_out_0,PE_out_1,PE_out_2,PE_out_3, PE_reg_out_0,PE_reg_out1,PE_reg_out2, in_op_1}), 
                                          .sel(ctr_signals.sel_op_1), .out(operand1));
    
    register #($bits(operand0), 'h0) alu_sr0_reg(.clock, .reset, .en, .clear(1'b0),
                                                 .D(operand0), .Q(alu_src0));
    register #($bits(operand0), 'h0) alu_sr1_reg(.clock, .reset, .en, .clear(1'b0),
                                                 .D(operand1), .Q(alu_src1));
                                                 
    alu ALU(.alu_src0, .alu_src1, .alu_op(ctr_signals.alu_op), .alu_out(out));

endmodule: PE


module alu (
    input  logic [3:0]    alu_src0,
    input  logic [3:0]    alu_src1,
    input  alu_op_t        alu_op,
    output logic [3:0]    alu_out
);

    always_comb begin
        unique case (alu_op)
            ALU_OR: alu_out = alu_src1 | alu_src2;
            ALU_AND: alu_out = alu_src1 & alu_src2;
            ALU_XOR: alu_out = alu_src1 ^ alu_src2;
            ALU_SLL: alu_out = alu_src1 << {alu_src2[1:0]};
            default: alu_out = 'bx;
        endcase
    end
endmodule: alu