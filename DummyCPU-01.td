// Define records for registers, immediates, and dag names for input/output parameters
def Reg;
def Imm16;
def ins;
def outs;

// Instruction class
class Instruction <string Name, dag Inputs, dag Outputs> {
  bits<32> insn;
  string name = Name;
  dag inputs = Inputs;
  dag outputs = Outputs;
}

// R-format instruction class
class RFormatInsn <bits<6> opcode, bits<11> opcode_ext, string name, dag ins, dag outs> : Instruction<name, ins, outs> {
  bits<5> rd;
  bits<5> rs1;
  bits<5> rs2;
  let insn{5-0} = opcode;
  let insn{10-6} = rd;
  let insn{15-11} = rs1;
  let insn{20-16} = rs2;
  let insn{31-21} = opcode_ext;
}

// I-format instruction class
class IFormatInsn <bits<6> opcode, string name, dag ins, dag outs> : Instruction<name, ins, outs> {
  bits<5> rd;
  bits<5> rs1;
  bits<16> imm;
  let insn{5-0} = opcode;
  let insn{10-6} = rd;
  let insn{15-11} = rs1;
  let insn{31-16} = imm;
}

// ADD instruction (R format)
def ADD : RFormatInsn<0b000101, 0b00000000000, "add", (ins Reg:$rs1, Reg:$rs2), (outs Reg:$rd)>;

// ADDI instruction (I format), setting opcode to 0b100101 and name to "addi"
// EX 1.A: Define the ADDI instruction using a def similar to the previous one

// EX 1.B: Redefine both ADD and ADDI by introducing a ALUBinaryOp multiclass exposing two parameters (opcode and name).
// Consider that the immediate variant uses the same opcode value in bits 0..4 while the most significant bit is set to 1.
