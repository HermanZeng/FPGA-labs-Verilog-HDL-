library verilog;
use verilog.vl_types.all;
entity display is
    port(
        in_port0        : in     vl_logic_vector(3 downto 0);
        in_port1        : in     vl_logic_vector(3 downto 0);
        out_port0       : in     vl_logic_vector(3 downto 0);
        hex0            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0)
    );
end display;
