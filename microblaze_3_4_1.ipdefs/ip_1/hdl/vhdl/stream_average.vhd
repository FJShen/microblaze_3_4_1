-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2017.4
-- Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity stream_average is
port (
    outstream_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    outstream_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
    instream_TDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    instream_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    instream_TVALID : IN STD_LOGIC;
    instream_TREADY : OUT STD_LOGIC;
    outstream_TVALID : OUT STD_LOGIC;
    outstream_TREADY : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC );
end;


architecture behav of stream_average is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "stream_average,hls_ip_2017_4,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7a100tcsg324-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=8.263000,HLS_SYN_LAT=32777,HLS_SYN_TPT=32768,HLS_SYN_MEM=4,HLS_SYN_DSP=5,HLS_SYN_FF=921,HLS_SYN_LUT=1105}";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";

    signal process_instream_U0_buffer_r_address0 : STD_LOGIC_VECTOR (9 downto 0);
    signal process_instream_U0_buffer_r_ce0 : STD_LOGIC;
    signal process_instream_U0_buffer_r_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal process_instream_U0_buffer_r_we0 : STD_LOGIC;
    signal process_instream_U0_buffer_r_address1 : STD_LOGIC_VECTOR (9 downto 0);
    signal process_instream_U0_buffer_r_ce1 : STD_LOGIC;
    signal process_instream_U0_buffer_r_d1 : STD_LOGIC_VECTOR (31 downto 0);
    signal process_instream_U0_buffer_r_we1 : STD_LOGIC;
    signal ap_rst_n_inv : STD_LOGIC;
    signal process_instream_U0_buffer_r_full_n : STD_LOGIC;
    signal process_instream_U0_buffer_r_write : STD_LOGIC;
    signal process_instream_U0_instream_TREADY : STD_LOGIC;
    signal process_instream_U0_ap_done : STD_LOGIC;
    signal process_instream_U0_ap_start : STD_LOGIC;
    signal process_instream_U0_ap_ready : STD_LOGIC;
    signal process_instream_U0_ap_idle : STD_LOGIC;
    signal process_instream_U0_ap_continue : STD_LOGIC;
    signal ap_channel_done_buffer : STD_LOGIC;
    signal process_outstream_U0_outstream_TDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal process_outstream_U0_outstream_TLAST : STD_LOGIC_VECTOR (0 downto 0);
    signal process_outstream_U0_buffer_r_address0 : STD_LOGIC_VECTOR (9 downto 0);
    signal process_outstream_U0_buffer_r_ce0 : STD_LOGIC;
    signal process_outstream_U0_buffer_r_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal process_outstream_U0_buffer_r_we0 : STD_LOGIC;
    signal process_outstream_U0_buffer_r_address1 : STD_LOGIC_VECTOR (9 downto 0);
    signal process_outstream_U0_buffer_r_ce1 : STD_LOGIC;
    signal process_outstream_U0_buffer_r_d1 : STD_LOGIC_VECTOR (31 downto 0);
    signal process_outstream_U0_buffer_r_we1 : STD_LOGIC;
    signal process_outstream_U0_outstream_TVALID : STD_LOGIC;
    signal process_outstream_U0_buffer_r_read : STD_LOGIC;
    signal process_outstream_U0_ap_done : STD_LOGIC;
    signal process_outstream_U0_ap_start : STD_LOGIC;
    signal process_outstream_U0_ap_ready : STD_LOGIC;
    signal process_outstream_U0_ap_idle : STD_LOGIC;
    signal process_outstream_U0_ap_continue : STD_LOGIC;
    signal ap_sync_continue : STD_LOGIC;
    signal buffer_r_i_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal buffer_r_t_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal buffer_r_i_full_n : STD_LOGIC;
    signal buffer_r_t_empty_n : STD_LOGIC;
    signal ap_sync_done : STD_LOGIC;
    signal ap_sync_ready : STD_LOGIC;
    signal process_instream_U0_start_full_n : STD_LOGIC;
    signal process_instream_U0_start_write : STD_LOGIC;
    signal process_outstream_U0_start_full_n : STD_LOGIC;
    signal process_outstream_U0_start_write : STD_LOGIC;

    component process_instream IS
    port (
        instream_TDATA : IN STD_LOGIC_VECTOR (31 downto 0);
        instream_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
        buffer_r_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
        buffer_r_ce0 : OUT STD_LOGIC;
        buffer_r_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_we0 : OUT STD_LOGIC;
        buffer_r_address1 : OUT STD_LOGIC_VECTOR (9 downto 0);
        buffer_r_ce1 : OUT STD_LOGIC;
        buffer_r_d1 : OUT STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_q1 : IN STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_we1 : OUT STD_LOGIC;
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        buffer_r_full_n : IN STD_LOGIC;
        buffer_r_write : OUT STD_LOGIC;
        instream_TVALID : IN STD_LOGIC;
        instream_TREADY : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC );
    end component;


    component process_outstream IS
    port (
        outstream_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        outstream_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
        buffer_r_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
        buffer_r_ce0 : OUT STD_LOGIC;
        buffer_r_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_we0 : OUT STD_LOGIC;
        buffer_r_address1 : OUT STD_LOGIC_VECTOR (9 downto 0);
        buffer_r_ce1 : OUT STD_LOGIC;
        buffer_r_d1 : OUT STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_q1 : IN STD_LOGIC_VECTOR (31 downto 0);
        buffer_r_we1 : OUT STD_LOGIC;
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        outstream_TVALID : OUT STD_LOGIC;
        outstream_TREADY : IN STD_LOGIC;
        buffer_r_empty_n : IN STD_LOGIC;
        buffer_r_read : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC );
    end component;


    component stream_average_bueOg IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        i_address0 : IN STD_LOGIC_VECTOR (9 downto 0);
        i_ce0 : IN STD_LOGIC;
        i_we0 : IN STD_LOGIC;
        i_d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        i_q0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        t_address0 : IN STD_LOGIC_VECTOR (9 downto 0);
        t_ce0 : IN STD_LOGIC;
        t_we0 : IN STD_LOGIC;
        t_d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        t_q0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        i_ce : IN STD_LOGIC;
        t_ce : IN STD_LOGIC;
        i_full_n : OUT STD_LOGIC;
        i_write : IN STD_LOGIC;
        t_empty_n : OUT STD_LOGIC;
        t_read : IN STD_LOGIC );
    end component;



begin
    process_instream_U0 : component process_instream
    port map (
        instream_TDATA => instream_TDATA,
        instream_TLAST => instream_TLAST,
        buffer_r_address0 => process_instream_U0_buffer_r_address0,
        buffer_r_ce0 => process_instream_U0_buffer_r_ce0,
        buffer_r_d0 => process_instream_U0_buffer_r_d0,
        buffer_r_q0 => ap_const_lv32_0,
        buffer_r_we0 => process_instream_U0_buffer_r_we0,
        buffer_r_address1 => process_instream_U0_buffer_r_address1,
        buffer_r_ce1 => process_instream_U0_buffer_r_ce1,
        buffer_r_d1 => process_instream_U0_buffer_r_d1,
        buffer_r_q1 => ap_const_lv32_0,
        buffer_r_we1 => process_instream_U0_buffer_r_we1,
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        buffer_r_full_n => buffer_r_i_full_n,
        buffer_r_write => process_instream_U0_buffer_r_write,
        instream_TVALID => instream_TVALID,
        instream_TREADY => process_instream_U0_instream_TREADY,
        ap_done => process_instream_U0_ap_done,
        ap_start => process_instream_U0_ap_start,
        ap_ready => process_instream_U0_ap_ready,
        ap_idle => process_instream_U0_ap_idle,
        ap_continue => process_instream_U0_ap_continue);

    process_outstream_U0 : component process_outstream
    port map (
        outstream_TDATA => process_outstream_U0_outstream_TDATA,
        outstream_TLAST => process_outstream_U0_outstream_TLAST,
        buffer_r_address0 => process_outstream_U0_buffer_r_address0,
        buffer_r_ce0 => process_outstream_U0_buffer_r_ce0,
        buffer_r_d0 => process_outstream_U0_buffer_r_d0,
        buffer_r_q0 => buffer_r_t_q0,
        buffer_r_we0 => process_outstream_U0_buffer_r_we0,
        buffer_r_address1 => process_outstream_U0_buffer_r_address1,
        buffer_r_ce1 => process_outstream_U0_buffer_r_ce1,
        buffer_r_d1 => process_outstream_U0_buffer_r_d1,
        buffer_r_q1 => ap_const_lv32_0,
        buffer_r_we1 => process_outstream_U0_buffer_r_we1,
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        outstream_TVALID => process_outstream_U0_outstream_TVALID,
        outstream_TREADY => outstream_TREADY,
        buffer_r_empty_n => ap_const_logic_0,
        buffer_r_read => process_outstream_U0_buffer_r_read,
        ap_done => process_outstream_U0_ap_done,
        ap_start => process_outstream_U0_ap_start,
        ap_ready => process_outstream_U0_ap_ready,
        ap_idle => process_outstream_U0_ap_idle,
        ap_continue => process_outstream_U0_ap_continue);

    buffer_r_U : component stream_average_bueOg
    generic map (
        DataWidth => 32,
        AddressRange => 1024,
        AddressWidth => 10)
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        i_address0 => process_instream_U0_buffer_r_address0,
        i_ce0 => process_instream_U0_buffer_r_ce0,
        i_we0 => process_instream_U0_buffer_r_we0,
        i_d0 => process_instream_U0_buffer_r_d0,
        i_q0 => buffer_r_i_q0,
        t_address0 => process_outstream_U0_buffer_r_address0,
        t_ce0 => process_outstream_U0_buffer_r_ce0,
        t_we0 => ap_const_logic_0,
        t_d0 => ap_const_lv32_0,
        t_q0 => buffer_r_t_q0,
        i_ce => ap_const_logic_1,
        t_ce => ap_const_logic_1,
        i_full_n => buffer_r_i_full_n,
        i_write => process_instream_U0_ap_done,
        t_empty_n => buffer_r_t_empty_n,
        t_read => process_outstream_U0_ap_ready);




    ap_channel_done_buffer <= process_instream_U0_ap_done;
    ap_done <= process_outstream_U0_ap_done;
    ap_idle <= (process_outstream_U0_ap_idle and process_instream_U0_ap_idle and (buffer_r_t_empty_n xor ap_const_logic_1));
    ap_ready <= process_instream_U0_ap_ready;

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    ap_sync_continue <= ap_const_logic_1;
    ap_sync_done <= process_outstream_U0_ap_done;
    ap_sync_ready <= process_instream_U0_ap_ready;
    instream_TREADY <= process_instream_U0_instream_TREADY;
    outstream_TDATA <= process_outstream_U0_outstream_TDATA;
    outstream_TLAST <= process_outstream_U0_outstream_TLAST;
    outstream_TVALID <= process_outstream_U0_outstream_TVALID;
    process_instream_U0_ap_continue <= process_instream_U0_buffer_r_full_n;
    process_instream_U0_ap_start <= ap_start;
    process_instream_U0_buffer_r_full_n <= buffer_r_i_full_n;
    process_instream_U0_start_full_n <= ap_const_logic_1;
    process_instream_U0_start_write <= ap_const_logic_0;
    process_outstream_U0_ap_continue <= ap_const_logic_1;
    process_outstream_U0_ap_start <= buffer_r_t_empty_n;
    process_outstream_U0_start_full_n <= ap_const_logic_1;
    process_outstream_U0_start_write <= ap_const_logic_0;
end behav;