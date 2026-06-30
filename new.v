`timescale 1 ns / 1 ps

module carrychain_v1_0 #
(
    // Parameters of Axi Slave Bus Interface S00_AXI
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 7    // 7 bits for 23 registers
)
(
    // User ports
    input wire pulse_in,
 
    output wire[63:0] delta_out,
    output wire delta_valid,
    output wire [63:0] m_axis_tdata,
    output wire        m_axis_tvalid,
    output wire        m_axis_tlast,
    input  wire        m_axis_tready, 
    
    // Ports of Axi Slave Bus Interface S00_AXI
    input  wire                                s00_axi_aclk,
    input  wire                                s00_axi_aresetn,
    input  wire [C_S00_AXI_ADDR_WIDTH-1:0]    s00_axi_awaddr,
    input  wire [2:0]                          s00_axi_awprot,
    input  wire                                s00_axi_awvalid,
    output wire                                s00_axi_awready,
    input  wire [C_S00_AXI_DATA_WIDTH-1:0]    s00_axi_wdata,
    input  wire [(C_S00_AXI_DATA_WIDTH/8)-1:0] s00_axi_wstrb,
    input  wire                                s00_axi_wvalid,
    output wire                                s00_axi_wready,
    output wire [1:0]                          s00_axi_bresp,
    output wire                                s00_axi_bvalid,
    input  wire                                s00_axi_bready,
    input  wire [C_S00_AXI_ADDR_WIDTH-1:0]    s00_axi_araddr,
    input  wire [2:0]                          s00_axi_arprot,
    input  wire                                s00_axi_arvalid,
    output wire                                s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1:0]    s00_axi_rdata,
    output wire [1:0]                          s00_axi_rresp,
    output wire                                s00_axi_rvalid,
    input  wire                                s00_axi_rready
    
);

    carrychain_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
    ) carrychain_v1_0_S00_AXI_inst (
        .pulse_in        (pulse_in),
        .S_AXI_ACLK      (s00_axi_aclk),
        .S_AXI_ARESETN   (s00_axi_aresetn),
        .S_AXI_AWADDR    (s00_axi_awaddr),
        .S_AXI_AWPROT    (s00_axi_awprot),
        .S_AXI_AWVALID   (s00_axi_awvalid),
        .S_AXI_AWREADY   (s00_axi_awready),
        .S_AXI_WDATA     (s00_axi_wdata),
        .S_AXI_WSTRB     (s00_axi_wstrb),
        .S_AXI_WVALID    (s00_axi_wvalid),
        .S_AXI_WREADY    (s00_axi_wready),
        .S_AXI_BRESP     (s00_axi_bresp),
        .S_AXI_BVALID    (s00_axi_bvalid),
        .S_AXI_BREADY    (s00_axi_bready),
        .S_AXI_ARADDR    (s00_axi_araddr),
        .S_AXI_ARPROT    (s00_axi_arprot),
        .S_AXI_ARVALID   (s00_axi_arvalid),
        .S_AXI_ARREADY   (s00_axi_arready),
        .S_AXI_RDATA     (s00_axi_rdata),
        .S_AXI_RRESP     (s00_axi_rresp),
        .S_AXI_RVALID    (s00_axi_rvalid),
        .S_AXI_RREADY    (s00_axi_rready),
        .delta_out       (delta_out),
        .delta_valid     (delta_valid),
        .m_axis_tdata    (m_axis_tdata),
        .m_axis_tvalid    (m_axis_tvalid),
        
        .m_axis_tlast      (m_axis_tlast),
        
        .m_axis_tready     (m_axis_tready)
       
    );

endmodule


module carrychain_v1_0_S00_AXI #
(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 7     // 7 bits covers 23 registers
)
(
    // User ports
    input wire pulse_in,
    output wire [63:0] delta_out,
    output wire        delta_valid,
    output wire [63:0] m_axis_tdata,
    output wire        m_axis_tvalid,
    output wire        m_axis_tlast,
  input  wire        m_axis_tready,

    // AXI4-Lite Slave ports
    input  wire                                S_AXI_ACLK,
    input  wire                                S_AXI_ARESETN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]      S_AXI_AWADDR,
    input  wire [2:0]                          S_AXI_AWPROT,
    input  wire                                S_AXI_AWVALID,
    output wire                                S_AXI_AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0]      S_AXI_WDATA,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0]  S_AXI_WSTRB,
    input  wire                                S_AXI_WVALID,
    output wire                                S_AXI_WREADY,
    output wire [1:0]                          S_AXI_BRESP,
    output wire                                S_AXI_BVALID,
    input  wire                                S_AXI_BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]      S_AXI_ARADDR,
    input  wire [2:0]                          S_AXI_ARPROT,
    input  wire                                S_AXI_ARVALID,
    output wire                                S_AXI_ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0]      S_AXI_RDATA,
    output wire [1:0]                          S_AXI_RRESP,
    output wire                                S_AXI_RVALID,
    input  wire                                S_AXI_RREADY
);

    // =========================================================
    // AXI4-Lite internal signals
    // =========================================================
    reg [C_S_AXI_ADDR_WIDTH-1:0]   axi_awaddr;
    reg                             axi_awready;
    reg                             axi_wready;
    reg [1:0]                       axi_bresp;
    reg                             axi_bvalid;
    reg [C_S_AXI_ADDR_WIDTH-1:0]   axi_araddr;
    reg                             axi_arready;
    reg [C_S_AXI_DATA_WIDTH-1:0]   axi_rdata;
    reg [1:0]                       axi_rresp;
    reg                             axi_rvalid;
    reg                             aw_en;

    // ADDR_LSB = 2 for 32-bit bus
    localparam integer ADDR_LSB          = 2;
    // OPT_MEM_ADDR_BITS: covers addresses 0x00..0x16 (23 registers)
    // axi_araddr[ADDR_LSB + OPT_MEM_ADDR_BITS : ADDR_LSB] must be wide enough
    // 5 bits ? 32 slots, enough for 23 registers
    localparam integer OPT_MEM_ADDR_BITS = 4;

    wire slv_reg_rden;
    wire slv_reg_wren;
    reg  [C_S_AXI_DATA_WIDTH-1:0] reg_data_out;

    // =========================================================
    // TDC signals  (668 taps, 125 MHz clock)
    // =========================================================
    localparam TAPS = 668;

    wire [TAPS-1:0]  taps;           // raw carry chain output
    reg  [TAPS-1:0]  thermo;         // captured thermometer code
    reg  [TAPS-1:0]  thermo_reg;     // registered (AXI clock domain)

    // fine_time comes directly from pipelined encoder output (8-cycle latency)
    wire [9:0]       fine_time_out;  // encoder pipeline output
    reg  [9:0]       fine_time_reg;  // latched into AXI read register

    reg              pulse_d1;
    reg              pulse_d2;
    reg              capture_pending;
    reg              pulse_event;

    reg  [31:0]      sec_counter;
    reg  [31:0]      pulse_count;
    reg  [31:0]      pulses_per_second;
    reg [31:0] coarse_counter;
reg [31:0] coarse_capture;

reg [31:0] coarse_pipe0;
reg [31:0] coarse_pipe1;
reg [31:0] coarse_pipe2;
reg [31:0] coarse_pipe3;
reg [31:0] coarse_pipe4;
reg [31:0] coarse_pipe5;
reg [31:0] coarse_pipe6;
reg [31:0] coarse_pipe7;

reg [31:0] sample_id;

reg [63:0] timestamp;
reg [63:0] prev_timestamp;
reg [63:0] delta;
//====================================================
// FIFO Stream Registers
//====================================================
reg [63:0] delta_stream;
reg        delta_stream_valid;
    // =========================================================
    // AXI I/O assignments
    // =========================================================
    assign S_AXI_AWREADY = axi_awready;
    assign S_AXI_WREADY  = axi_wready;
    assign S_AXI_BRESP   = axi_bresp;
    assign S_AXI_BVALID  = axi_bvalid;
    assign S_AXI_ARREADY = axi_arready;
    assign S_AXI_RDATA   = axi_rdata;
    assign S_AXI_RRESP   = axi_rresp;
    assign S_AXI_RVALID  = axi_rvalid;

    // =========================================================
    // AXI Write Address handshake
    // =========================================================
    always @(posedge S_AXI_ACLK)
begin
    if(!S_AXI_ARESETN)
        coarse_counter <= 32'd0;
    else
        coarse_counter <= coarse_counter + 1;
end
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN) begin
            axi_awready <= 1'b0;
            aw_en       <= 1'b1;
        end else begin
            if (!axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
                axi_awready <= 1'b1;
                aw_en       <= 1'b0;
            end else if (S_AXI_BREADY && axi_bvalid) begin
                aw_en       <= 1'b1;
                axi_awready <= 1'b0;
            end else begin
                axi_awready <= 1'b0;
            end
        end
    end

    // Latch write address
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN)
            axi_awaddr <= 0;
        else if (!axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
            axi_awaddr <= S_AXI_AWADDR;
    end

    // AXI Write Data handshake
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN)
            axi_wready <= 1'b0;
        else begin
            if (!axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en)
                axi_wready <= 1'b1;
            else
                axi_wready <= 1'b0;
        end
    end

    // Write response
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN) begin
            axi_bvalid <= 0;
            axi_bresp  <= 2'b0;
        end else begin
            if (axi_awready && S_AXI_AWVALID && !axi_bvalid && axi_wready && S_AXI_WVALID) begin
                axi_bvalid <= 1'b1;
                axi_bresp  <= 2'b0;
            end else if (S_AXI_BREADY && axi_bvalid) begin
                axi_bvalid <= 1'b0;
            end
        end
    end

    // AXI Read Address handshake
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN) begin
            axi_arready <= 1'b0;
            axi_araddr  <= 32'b0;
        end else begin
            if (!axi_arready && S_AXI_ARVALID) begin
                axi_arready <= 1'b1;
                axi_araddr  <= S_AXI_ARADDR;
            end else begin
                axi_arready <= 1'b0;
            end
        end
    end

    // AXI Read Data valid
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN) begin
            axi_rvalid <= 0;
            axi_rresp  <= 0;
        end else begin
            if (axi_arready && S_AXI_ARVALID && !axi_rvalid) begin
                axi_rvalid <= 1'b1;
                axi_rresp  <= 2'b0;
            end else if (axi_rvalid && S_AXI_RREADY) begin
                axi_rvalid <= 1'b0;
            end
        end
    end

    // =========================================================
    // Register read decode
    // Address map (word addresses, byte addr >> 2):
    //   0x00  fine_time [9:0]
    //   0x01  thermo[31:0]
    //   0x02  thermo[63:32]
    //   0x03  thermo[95:64]
    //   0x04  thermo[127:96]
    //   0x05  thermo[159:128]
    //   0x06  thermo[191:160]
    //   0x07  thermo[223:192]
    //   0x08  thermo[255:224]
    //   0x09  thermo[287:256]
    //   0x0A  thermo[319:288]
    //   0x0B  thermo[351:320]
    //   0x0C  thermo[383:352]
    //   0x0D  thermo[415:384]
    //   0x0E  thermo[447:416]
    //   0x0F  thermo[479:448]
    //   0x10  thermo[511:480]
    //   0x11  thermo[543:512]
    //   0x12  thermo[575:544]
    //   0x13  thermo[607:576]
    //   0x14  thermo[639:608]
    //   0x15  thermo[667:640]  (28 valid bits, upper 4 bits = 0)
    //   0x16  pulses_per_second
    // =========================================================
    assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;

    always @(*)
    begin
        case (axi_araddr[ADDR_LSB + OPT_MEM_ADDR_BITS : ADDR_LSB])
            5'h00 : reg_data_out = sample_id;
            5'h01 : reg_data_out = coarse_pipe7;
            5'h02 : reg_data_out ={22'd0,fine_time_reg};
            5'h03 : reg_data_out = timestamp[31:0];
            
            5'h04 : reg_data_out =timestamp[63:32];
            5'h05 : reg_data_out = delta[31:0];
            5'h06 : reg_data_out = delta[63:32];
            5'h07 : reg_data_out = pulses_per_second;
           
            default: reg_data_out = 32'd0;
        endcase
    end

    // Pipeline read data
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN)
            axi_rdata <= 0;
        else if (slv_reg_rden)
            axi_rdata <= reg_data_out;
    end

    // No write registers needed (TDC is read-only from CPU side)
    assign slv_reg_wren = 1'b0;

    // =========================================================
    // TDC - Delay Line instantiation
    // =========================================================
    tdc_delayline #(
        .TAPS(TAPS)
    ) u_delay (
        .pulse_in (pulse_in),
        .taps     (taps)
    );

    // =========================================================
    // TDC - Encoder instantiation
    // =========================================================
    // =========================================================
    // TDC - Pipelined hierarchical encoder (8-cycle latency)
    // fine_time_out is valid 8 cycles after thermo is sampled.
    // For a pulse rate counter this latency is negligible.
    // =========================================================
    tdc_encoder #(
        .TAPS    (TAPS),
        .OUT_BITS(10)
    ) u_encoder (
        .clk       (S_AXI_ACLK),
        .rst_n     (S_AXI_ARESETN),
        .thermo    (thermo),          // driven by capture always block below
        .fine_time (fine_time_out)
    );

    // =========================================================
    // Register thermo snapshot + encoder output into AXI domain
    // thermo_reg: for raw readback by CPU
    // fine_time_reg: latch encoder result when it stabilises
    // =========================================================
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN) begin
            thermo_reg    <= {TAPS{1'b0}};
            fine_time_reg <= 10'd0;
        end else begin
            thermo_reg    <= thermo;       // one-cycle delay snapshot
            fine_time_reg <= fine_time_out; // 8-cycle pipeline result
        end
    end

    // =========================================================
    // Pulse capture - fixed: capture taps immediately on rising edge
    // =========================================================
    always @(posedge S_AXI_ACLK)
    begin
        pulse_d1    <= pulse_in;
        pulse_d2    <= pulse_d1;
        pulse_event <= 1'b0;

        if (!S_AXI_ARESETN) begin
            capture_pending <= 1'b0;
            pulse_d1        <= 1'b0;
            pulse_event     <= 1'b0;
            thermo          <= {TAPS{1'b0}};
        end else begin
            if (pulse_d1 && !pulse_d2) begin
                // Rising edge detected - capture carry chain NOW
                thermo          <= taps;
                coarse_capture <= coarse_counter;
                capture_pending <= 1'b1;
            end else if (capture_pending) begin
                // One cycle later - signal the rate counter
                capture_pending <= 1'b0;
                pulse_event     <= 1'b1;
            end
        end
    end

    // =========================================================
    // Pulse rate counter - 125 MHz ? 1 second = 125,000,000 cycles
    // =========================================================
    always @(posedge S_AXI_ACLK)
    begin
        if (!S_AXI_ARESETN) begin
            sec_counter       <= 32'd0;
            pulse_count       <= 32'd0;
            pulses_per_second <= 32'd0;
        end else begin
            if (pulse_event)
                pulse_count <= pulse_count + 1;

            if (sec_counter == 32'd124_999_999) begin
                sec_counter       <= 32'd0;
                pulses_per_second <= pulse_count;
                pulse_count       <= 32'd0;
            end else begin
                sec_counter <= sec_counter + 1;
            end
        end
    end
always @(posedge S_AXI_ACLK)
begin
    if(!S_AXI_ARESETN) begin

        coarse_pipe0 <= 0;
        coarse_pipe1 <= 0;
        coarse_pipe2 <= 0;
        coarse_pipe3 <= 0;
        coarse_pipe4 <= 0;
        coarse_pipe5 <= 0;
        coarse_pipe6 <= 0;
        coarse_pipe7 <= 0;

    end else if(pulse_event) begin

        coarse_pipe0 <= coarse_capture;
        coarse_pipe1 <= coarse_pipe0;
        coarse_pipe2 <= coarse_pipe1;
        coarse_pipe3 <= coarse_pipe2;
        coarse_pipe4 <= coarse_pipe3;
        coarse_pipe5 <= coarse_pipe4;
        coarse_pipe6 <= coarse_pipe5;
        coarse_pipe7 <= coarse_pipe6;

    end
end
reg [7:0] valid_pipe;

always @(posedge S_AXI_ACLK)
begin
    if(!S_AXI_ARESETN)
        valid_pipe <= 8'd0;
    else
        valid_pipe <= {valid_pipe[6:0], pulse_event};
end




always @(posedge S_AXI_ACLK)
begin
    if(!S_AXI_ARESETN) begin

        sample_id          <= 0;
        timestamp          <= 0;
        prev_timestamp     <= 0;
        delta              <= 0;

        delta_stream       <= 0;
        delta_stream_valid <= 1'b0;

    end
    else begin

        // default
        delta_stream_valid <= 1'b0;

        if(valid_pipe[7]) begin

            sample_id <= sample_id + 1;

            prev_timestamp <= timestamp;

            timestamp <= ({32'd0,coarse_pipe7} * 8000)
                       + fine_time_out;

            if((({32'd0,coarse_pipe7} *8000)+fine_time_out)
                    >= timestamp)
            begin
                delta <= (({32'd0,coarse_pipe7} *8000)
                        + fine_time_out)
                        - timestamp;

                delta_stream <= (({32'd0,coarse_pipe7} *8000)
                               + fine_time_out)
                               - timestamp;
            end
            else
            begin
                delta <= timestamp
                        - (({32'd0,coarse_pipe7} *8000)
                        + fine_time_out);

                delta_stream <= timestamp
                              - (({32'd0,coarse_pipe7} *8000)
                              + fine_time_out);
            end

            delta_stream_valid <= 1'b1;

        end
    end
end
//====================================================
// Delta Stream Output
//====================================================
assign delta_out   = delta_stream;
assign delta_valid = delta_stream_valid;



pingpong_delta_stream #(
    .DATA_WIDTH(64),
    .DEPTH(512)
) u_pingpong (
    .clk             (S_AXI_ACLK),
    .rst_n           (S_AXI_ARESETN),
    .delta_valid_in  (delta_stream_valid),
    .delta_in        (delta_stream),
    .m_axis_tdata    (m_axis_tdata),
    .m_axis_tvalid   (m_axis_tvalid),
    .m_axis_tlast    (m_axis_tlast),
    .m_axis_tready   (m_axis_tready)
);
endmodule
`timescale 1ns / 1ps

//=====================================================================
// pingpong_delta_stream
//
// Buffers ONLY the 64-bit "delta" value into one of two internal FIFOs.
// While FIFO A is being filled by new samples, FIFO B (already full)
// is drained out over a single AXI4-Stream master to the DMA, and
// vice versa. Only one streaming output exists -> no AXI4-Stream
// Switch needed in the block design, just this module -> AXI DMA (S2MM).
//
// Both buffers are simple single-clock-domain FIFOs (same clock as
// s00_axi_aclk), implemented here directly so write-fill and read-drain
// can be arbitrated internally without any extra IP.
//=====================================================================
module pingpong_delta_stream #(
    parameter integer DATA_WIDTH     = 64,
    parameter integer DEPTH          = 512,              // samples per buffer
    parameter integer ADDR_WIDTH     = $clog2(DEPTH)
)
(
    input  wire                    clk,
    input  wire                    rst_n,

    // Sample input (tap directly from existing delta/valid_pipe[7] logic)
    input  wire                    delta_valid_in,
    input  wire [DATA_WIDTH-1:0]   delta_in,

    // Single AXI4-Stream master output -> AXI DMA S2MM
    output reg  [DATA_WIDTH-1:0]   m_axis_tdata,
    output reg                     m_axis_tvalid,
    output reg                     m_axis_tlast,
    input  wire                    m_axis_tready,

    // Optional status bits (wire to spare AXI-Lite register or GPIO)
    output reg                     active_wr_buf,   // 0 = filling A, 1 = filling B
    output reg                     buf_a_overflow,  // debug: write attempted while A still draining
    output reg                     buf_b_overflow
);

    // ---------------- Buffer A ----------------
    reg [DATA_WIDTH-1:0] mem_a [0:DEPTH-1];
    reg [ADDR_WIDTH-1:0] wr_addr_a, rd_addr_a;
    reg                  a_ready_to_drain;   // A is full and waiting/being read
    reg                  a_draining;

    // ---------------- Buffer B ----------------
    reg [DATA_WIDTH-1:0] mem_b [0:DEPTH-1];
    reg [ADDR_WIDTH-1:0] wr_addr_b, rd_addr_b;
    reg                  b_ready_to_drain;
    reg                  b_draining;

    // ---------------- Write side: fill active buffer ----------------
    always @(posedge clk) begin
        if (!rst_n) begin
            wr_addr_a        <= {ADDR_WIDTH{1'b0}};
            wr_addr_b        <= {ADDR_WIDTH{1'b0}};
            active_wr_buf    <= 1'b0;
            a_ready_to_drain <= 1'b0;
            b_ready_to_drain <= 1'b0;
            buf_a_overflow   <= 1'b0;
            buf_b_overflow   <= 1'b0;
        end else begin
            if (delta_valid_in) begin
                if (active_wr_buf == 1'b0) begin
                    // filling A
                    if (a_draining || a_ready_to_drain) begin
                        buf_a_overflow <= 1'b1; // A not yet fully drained, would overwrite - widen DEPTH or speed up DMA
                    end else begin
                        mem_a[wr_addr_a] <= delta_in;
                        if (wr_addr_a == DEPTH-1) begin
                            wr_addr_a        <= {ADDR_WIDTH{1'b0}};
                            a_ready_to_drain <= 1'b1;  // A full -> hand off to reader
                            active_wr_buf    <= 1'b1;  // start filling B
                        end else begin
                            wr_addr_a <= wr_addr_a + 1'b1;
                        end
                    end
                end else begin
                    // filling B
                    if (b_draining || b_ready_to_drain) begin
                        buf_b_overflow <= 1'b1;
                    end else begin
                        mem_b[wr_addr_b] <= delta_in;
                        if (wr_addr_b == DEPTH-1) begin
                            wr_addr_b        <= {ADDR_WIDTH{1'b0}};
                            b_ready_to_drain <= 1'b1;
                            active_wr_buf    <= 1'b0;  // start filling A again
                        end else begin
                            wr_addr_b <= wr_addr_b + 1'b1;
                        end
                    end
                end
            end

            // clear ready_to_drain once the reader has fully drained that buffer
            if (a_ready_to_drain && rd_addr_a == DEPTH-1 && a_draining && m_axis_tvalid && m_axis_tready)
                a_ready_to_drain <= 1'b0;
            if (b_ready_to_drain && rd_addr_b == DEPTH-1 && b_draining && m_axis_tvalid && m_axis_tready)
                b_ready_to_drain <= 1'b0;
        end
    end

    // ---------------- Read side: drain whichever buffer is ready ----------------
    always @(posedge clk) begin
        if (!rst_n) begin
            rd_addr_a     <= {ADDR_WIDTH{1'b0}};
            rd_addr_b     <= {ADDR_WIDTH{1'b0}};
            a_draining    <= 1'b0;
            b_draining    <= 1'b0;
            m_axis_tdata  <= {DATA_WIDTH{1'b0}};
            m_axis_tvalid <= 1'b0;
            m_axis_tlast  <= 1'b0;
        end else begin
            m_axis_tlast <= 1'b0;

            if (!a_draining && !b_draining) begin
                // pick a buffer to start draining (A has priority if both ready)
                if (a_ready_to_drain) begin
                    a_draining    <= 1'b1;
                    rd_addr_a     <= {ADDR_WIDTH{1'b0}};
                    m_axis_tdata  <= mem_a[0];
                    m_axis_tvalid <= 1'b1;
                end else if (b_ready_to_drain) begin
                    b_draining    <= 1'b1;
                    rd_addr_b     <= {ADDR_WIDTH{1'b0}};
                    m_axis_tdata  <= mem_b[0];
                    m_axis_tvalid <= 1'b1;
                end else begin
                    m_axis_tvalid <= 1'b0;
                end
            end else if (a_draining) begin
                if (m_axis_tvalid && m_axis_tready) begin
                    if (rd_addr_a == DEPTH-1) begin
                        m_axis_tlast  <= 1'b1;   // last beat of this buffer
                        a_draining    <= 1'b0;
                        m_axis_tvalid <= 1'b0;
                    end else begin
                        rd_addr_a     <= rd_addr_a + 1'b1;
                        m_axis_tdata  <= mem_a[rd_addr_a + 1'b1];
                        m_axis_tvalid <= 1'b1;
                    end
                end
            end else if (b_draining) begin
                if (m_axis_tvalid && m_axis_tready) begin
                    if (rd_addr_b == DEPTH-1) begin
                        m_axis_tlast  <= 1'b1;
                        b_draining    <= 1'b0;
                        m_axis_tvalid <= 1'b0;
                    end else begin
                        rd_addr_b     <= rd_addr_b + 1'b1;
                        m_axis_tdata  <= mem_b[rd_addr_b + 1'b1];
                        m_axis_tvalid <= 1'b1;
                    end
                end
            end
        end
    end

endmodule

