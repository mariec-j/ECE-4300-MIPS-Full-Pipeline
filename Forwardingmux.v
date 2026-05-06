//Basic mux
module Forwardingmux #(parameter WIDTH_inp_forward =  32) (

    input [1:0] sel_forward,
    input [(WIDTH_inp-1):0] in_1_forward,
    input [(WIDTH_inp-1):0] in_2_forward,
    input [(WIDTH_inp-1):0] in_3_forward,
    output [(WIDTH_inp-1):0] outp_forward
);
assign outp_forward = (sel_forward == 2'b10)? in_3_forward: (sel_forward == 2'b01) ? in_2_forward: in_1_forward;  
endmodule