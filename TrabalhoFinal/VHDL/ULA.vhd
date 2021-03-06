library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

--Entidade padrão para ULA fornecida no roteiro --
entity ULA is
	generic (DATA_WIDTH : natural := 32);

port( 
	input1, input2 : in std_logic_vector(DATA_WIDTH -1 downto 0);
	operation : in std_logic_vector(3 downto 0);
	instrucao : in std_logic_vector(DATA_WIDTH -1 downto 0);
	output : out std_logic_vector(DATA_WIDTH -1 downto 0);
	zero, negative : out std_logic;
	carry, overflow : out std_logic
	);

end entity ULA;

--Definição da arquitetura da ULA --
architecture ULA_arch of ULA is


-- Import de todos os componentes da ULA --
component Somador is		
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0);
	c_out: out std_logic
	);

end component;

component Bloco_Slt is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Mux is
	generic (DATA_WIDTH : natural := 32);

port( 
	a,b,c,d,e,f,g,h,i,j,k: in std_logic_vector(DATA_WIDTH -1 downto 0);
	operation : in std_logic_vector(3 downto 0);
	output: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Bloco_And is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Bloco_Xor is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Bloco_Or is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Bloco_Nor is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Subtrator is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Bloco_Sll is
	generic (DATA_WIDTH : natural := 32);

port( 
	a : in std_logic_vector(DATA_WIDTH -1 downto 0);
	b : in std_logic_vector(4 downto 0);
	z : out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Bloco_Srl is
	generic (DATA_WIDTH : natural := 32);

port( 
	a : in std_logic_vector(DATA_WIDTH -1 downto 0);
	b : in std_logic_vector(4 downto 0);
	z : out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Bloco_Sra is
	generic (DATA_WIDTH : natural := 32);

port( 
	a : in std_logic_vector(DATA_WIDTH -1 downto 0);
	b : in std_logic_vector(4 downto 0);
	z : out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;

component Detector_Zero is
	generic (DATA_WIDTH : natural := 32);

port( 
	output: in std_logic_vector(DATA_WIDTH -1 downto 0);
	zero: out std_logic
	);

end component;

Component Detector_Negative is
	generic (DATA_WIDTH : natural := 32);

port( 
	output: in std_logic_vector(DATA_WIDTH -1 downto 0);
	negative: out std_logic
	);

end component;

component Detector_Overflow is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b, z: in std_logic_vector(DATA_WIDTH -1 downto 0);
	operation : in std_logic_vector(3 downto 0);
	overflow: out std_logic
	);

end component;

component Detector_Overflow_Sub is
	generic (DATA_WIDTH : natural := 32);

port( 
	a, b, z: in std_logic_vector(DATA_WIDTH -1 downto 0);
	operation : in std_logic_vector(3 downto 0);
	overflow: out std_logic
	);

end component;

component Bloco_Lui is
	generic (DATA_WIDTH : natural := 32);

port( 
	a : in std_logic_vector(DATA_WIDTH -1 downto 0);
	z: out std_logic_vector(DATA_WIDTH -1 downto 0)
	);

end component;
-- Fim do Import --

-- Declaração de sinais --
signal out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,aux_output: std_logic_vector(DATA_WIDTH -1 downto 0);
signal overflow_soma,overflow_sub : std_logic;
-- Fim sinais --

begin
	-- Port Maps --
	I1: Bloco_And port map (input1,input2,out1);
	I2: Bloco_Or port map (input1,input2,out2);
	I3: Somador port map (input1,input2,out3,carry);
	I5: Subtrator port map (input1,input2,out4);
	I6: Bloco_Slt port map (input1,input2,out5);
	I7: Bloco_Nor port map (input1,input2,out6);
	I8: Bloco_Xor port map (input1,input2,out7); 
	I9: Bloco_Sll port map (input2,instrucao(10 downto 6),out8);
	I10: Bloco_Srl port map (input2,instrucao(10 downto 6),out9);
	I11: Bloco_Sra port map (input2,instrucao(10 downto 6),out10);
	I12: Mux port map (out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out12,operation,aux_output);
	I13: Detector_Zero port map (aux_output,zero);
	I14: Detector_Negative port map (aux_output,negative);
	I15: Detector_Overflow port map (input1,input2,out3,operation,overflow_soma);
	I16: Detector_Overflow_Sub port map (input1,input2,out4,operation,overflow_sub);
	I17: Bloco_Lui port map (input2,out12);
	-- Fim Port Maps --  

	overflow <= overflow_soma or overflow_sub;
	output <= aux_output;
	
end architecture;