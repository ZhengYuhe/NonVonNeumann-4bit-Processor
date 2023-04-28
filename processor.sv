`include "internal_defines.vh"

module processor(
    input logic[11:0] instruction,
    input logic clock, reset,
    output logic [11:0] result
);
    ctrl_signals_t ctr_signals_s;
    logic [3:0] input_op0, input_op1, sel_in0, sel_in1, sel_res, sel_pe;
    logic en_PE_ctr, en_PE_out, en_input0, en_inpu1;

    scheduler control_unit(.*)
    
    logic en_PE_0, en_PE_out0, en_PE_1, en_PE_out1, en_PE_2, en_PE_out2, en_PE_3, en_PE_out3;
    ctrl_signals_t  ctr_signals_0, ctr_signals_1,ctr_signals_2,ctr_signals_3;

    demux #(4, $bits(en_PE_ctr)) en_PE_demux(.out({en_PE_0,en_PE_1,en_PE_2,en_PE_3}), 
                                             .in(en_PE_ctr), .sel(sel_pe));
    
    demux #(4, $bits(en_PE_out)) en_PE_out_demux(.out({en_PE_out0,en_PE_out1,en_PE_out2,en_PE_out3}), 
                                             .in(en_PE_out), .sel(sel_pe));

    demux #(4, $bits(ctr_signals_s)) en_PE_ctr_demux(.out({ctr_signals_0,ctr_signals_1,ctr_signals_2,ctr_signals_3}), 
                                             .in(ctr_signals_s), .sel(sel_pe));

    assign result = 'h0;

endmodule: processor

module scheduler(
    input logic[11:0] instruction,
    input logic clock, reset,
    output ctrl_signals_t ctr_signals_s,
    output logic[3:0] input_op0, input_op1, sel_in0, sel_in1, sel_res, sel_pe,
    output logic en_PE_ctr, en_PE_out, en_input0, en_inpu1;
);
    logic [1:0] PE_counter;
    logic [11:0] instr_fetched;
    register #($bits(instruction), 'h0) Instuction_Register(.clock, .reset, .en(1'b0), .clear(1'b0), 
                                        .D(instruction), .Q(instr_fetched));
    
    always_ff @(posedge clock, posedge reset) begin
        if (reset)
            PE_counter <= 2'b00;
        else
            PE_counter <= PE_counter + 1'b1;
    end

    assign sel_pe = PE_counter;
    assign ctr_signals_s = 'b0;
    assign input_op0 = 'b0;
    assign input_op1 = 'b0;
    assign sel_in0 = 'b0;
    assign sel_in1 = 'b0;
    assign sel_res = 'b0;
    assign sel_pe = 'b0;
    assign en_PE_ctr = 0;
    assign en_PE_out = 0;
    assign en_input0 = 0;
    assign en_input1 = 0;

endmodule: scheduler