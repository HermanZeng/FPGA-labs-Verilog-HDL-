library verilog;
use verilog.vl_types.all;
entity vending_machine_v is
    generic(
        S_select        : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        S_confirm       : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        S_allselled     : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        S_money         : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        S_enough        : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        S_requirechange : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        S_change        : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        S_out           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        S_init          : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        money           : in     vl_logic_vector(3 downto 0);
        confirm         : in     vl_logic;
        drink_selected  : in     vl_logic_vector(3 downto 0);
        hex0            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S_select : constant is 1;
    attribute mti_svvh_generic_type of S_confirm : constant is 1;
    attribute mti_svvh_generic_type of S_allselled : constant is 1;
    attribute mti_svvh_generic_type of S_money : constant is 1;
    attribute mti_svvh_generic_type of S_enough : constant is 1;
    attribute mti_svvh_generic_type of S_requirechange : constant is 1;
    attribute mti_svvh_generic_type of S_change : constant is 1;
    attribute mti_svvh_generic_type of S_out : constant is 1;
    attribute mti_svvh_generic_type of S_init : constant is 1;
end vending_machine_v;
