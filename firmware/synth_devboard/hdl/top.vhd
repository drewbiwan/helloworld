-----------------------------
-- Top level 
-- Author: Drew Coker
-- Date: November 2021
-----------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.build_pkg.all;

entity top is
    port 
    (
        leds_p  : out std_logic_vector(3 downto 0);

        -- ZYNQ PINS
        DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
        DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
        DDR_cas_n : inout STD_LOGIC;
        DDR_ck_n : inout STD_LOGIC;
        DDR_ck_p : inout STD_LOGIC;
        DDR_cke : inout STD_LOGIC;
        DDR_cs_n : inout STD_LOGIC;
        DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
        DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
        DDR_odt : inout STD_LOGIC;
        DDR_ras_n : inout STD_LOGIC;
        DDR_reset_n : inout STD_LOGIC;
        DDR_we_n : inout STD_LOGIC;
        FIXED_IO_ddr_vrn : inout STD_LOGIC;
        FIXED_IO_ddr_vrp : inout STD_LOGIC;
        FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
        FIXED_IO_ps_clk : inout STD_LOGIC;
        FIXED_IO_ps_porb : inout STD_LOGIC;
        FIXED_IO_ps_srstb : inout STD_LOGIC
    );
end top;

architecture bhv of top is
    signal clk_s        : std_logic;
    signal counter_s    : unsigned(31 downto 0);
    

    -- GPIO PS <-> PL
    signal gpo_0_s : STD_LOGIC_VECTOR(31 downto 0);
    signal gpo_1_s : STD_LOGIC_VECTOR(31 downto 0);
    signal gpi_0_s : STD_LOGIC_VECTOR(31 downto 0);
    signal gpi_1_s : STD_LOGIC_VECTOR(31 downto 0);

    -- AXI memory mapped register controller
    signal regmap_addr_s    : std_logic_vector(12 downto 0);
    signal regmap_din_s     : std_logic_vector(31 downto 0);
    signal regmap_dout_s    : std_logic_vector(31 downto 0);
    signal regmap_we_s      : std_logic_vector(3 downto 0);
    signal regmap_en_s      : std_logic;
    signal regmap_rst_s     : std_logic;
    signal regmap_clk_s     : std_logic;

begin

    -- Generate blinky lights from PL clock
    leds_p  <= std_logic_vector(counter_s(24 downto 21));
    process(clk_s)
    begin
        if rising_edge(clk_s) then
            counter_s <= counter_s + 1;
        end if;
    end process;

    -- Zynq BD
    zynq_inst : entity work.zynq_bd_wrapper
    port map
    (
        FCLK_CLK0           => clk_s,
        REGMAP_addr         => regmap_addr_s,
        REGMAP_clk          => regmap_clk_s,
        REGMAP_din          => regmap_din_s,
        REGMAP_dout         => regmap_dout_s,
        REGMAP_en           => regmap_en_s,
        REGMAP_rst          => regmap_rst_s,
        REGMAP_we           => regmap_we_s,
        DDR_addr            => DDR_addr,
        DDR_ba              => DDR_ba,
        DDR_cas_n           => DDR_cas_n,
        DDR_ck_n            => DDR_ck_n,
        DDR_ck_p            => DDR_ck_p,
        DDR_cke             => DDR_cke,
        DDR_cs_n            => DDR_cs_n,
        DDR_dm              => DDR_dm,
        DDR_dq              => DDR_dq,
        DDR_dqs_n           => DDR_dqs_n,
        DDR_dqs_p           => DDR_dqs_p,
        DDR_odt             => DDR_odt,
        DDR_ras_n           => DDR_ras_n,
        DDR_reset_n         => DDR_reset_n,
        DDR_we_n            => DDR_we_n,
        FIXED_IO_ddr_vrn    => FIXED_IO_ddr_vrn,
        FIXED_IO_ddr_vrp    => FIXED_IO_ddr_vrp,
        FIXED_IO_mio        => FIXED_IO_mio,
        FIXED_IO_ps_clk     => FIXED_IO_ps_clk,
        FIXED_IO_ps_porb    => FIXED_IO_ps_porb,
        FIXED_IO_ps_srstb   => FIXED_IO_ps_srstb,
        gpio_rtl_0_tri_o    => gpo_0_s,
        gpio_rtl_1_tri_o    => gpo_1_s,
        gpio_rtl_2_tri_i    => gpi_0_s,
        gpio_rtl_3_tri_i    => gpi_1_s
    );


    --Placeholder loopbacks
    gpi_0_s <= gpo_0_s;
    gpi_1_s <= gpo_1_s;

    regmap_dout_s <= regmap_din_s;


end bhv;
