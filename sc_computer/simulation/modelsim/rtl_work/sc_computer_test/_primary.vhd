library verilog;
use verilog.vl_types.all;
entity sc_computer_test is
    port(
        mem_clk         : in     vl_logic;
        out_port0       : out    vl_logic_vector(31 downto 0);
        in1             : in     vl_logic;
        in2             : in     vl_logic;
        in3             : in     vl_logic;
        in4             : in     vl_logic;
        in5             : in     vl_logic;
        in6             : in     vl_logic;
        in7             : in     vl_logic;
        in8             : in     vl_logic;
        resetn          : in     vl_logic
    );
end sc_computer_test;
