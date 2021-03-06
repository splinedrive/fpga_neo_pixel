/*
 *  FpgaNeoPixel - A spi to ws2812 machine
 *
 *  Copyright (C) 2020  Hirosh Dabui <hirosh@dabui.de>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */
`include "ws2812_sequence.v"

module testbench;
localparam CLK_HZ = 12_000_000;
reg clk;
wire dout;
wire done;
reg reset;


reg [4095:0] vcdfile;
always #5 clk = (clk === 1'b0);
ws2812_sequence uut(.clk(clk),
                     .din(24'h000001),
                     .resetn(reset),
                     .enable(1'b1),
                     .dout(dout),
                     .done(done)
                   );

	initial begin
		if ($value$plusargs("vcd=%s", vcdfile)) begin
			$dumpfile(vcdfile);
			$dumpvars(0, testbench);
		end
	end

	initial begin
    reset = 0;
		repeat (2) @(posedge clk);
    reset = 1;
		repeat (2000) @(posedge clk);
		$finish;
	end
endmodule
