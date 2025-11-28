# Projeto 3 — Laboratório de Arquitetura de Computadores

## 📘 Descrição do Projeto
Este projeto tem como objetivo **projetar e implementar uma CPU de 16 bits** em **VHDL**, capaz de executar um conjunto reduzido de instruções (RISC-like).  
O trabalho foi desenvolvido como parte da disciplina **Laboratório de Arquitetura de Computadores**, com foco em compreender os princípios de construção de processadores, controle de fluxo e tratamento de hazards.

A CPU deverá ser capaz de executar as seguintes instruções:

| Instrução | Significado | Descrição |
|------------|--------------|-----------|
| `NOP` | No Operation | Nenhuma operação |
| `LW rt, offset(rs)` | Load Word | `Rt ← MEM[rs + offset]` |
| `SW rt, offset(rs)` | Store Word | `MEM[rs + offset] ← Rt` |
| `ADD rd, rs, rt` | Add | `Rd ← Rs + Rt` |
| `SUB rd, rs, rt` | Subtract | `Rd ← Rs - Rt` |
| `BEQ rt, rs, offset` | Branch if Equal | `PC ← offset` se `Rs = Rt` |
| `JMP end` | Jump | `PC ← end` |

---

## ⚙️ Especificações Técnicas
- **Palavra da CPU:** 16 bits  
- **Registradores:** 16 registradores de 16 bits cada  
- **Tipos de Instrução:**
  - **R:** operações aritméticas (`ADD`, `SUB`)
  - **MEM:** acesso à memória (`LW`, `SW`)
  - **COND:** salto condicional (`BEQ`)
  - **J:** salto incondicional (`JMP`)

### 🧩 OPCODES
| Instrução | OPCODE |
|------------|--------|
| `NOP` | `000` |
| `LW` | `001` |
| `SW` | `010` |
| `ADD` | `011` |
| `SUB` | `011` |
| `BEQ` | `100` |
| `JMP` | `101` |

---

## 🧮 Extras do Projeto
- ✅ Detecção e resolução de **data hazards** (para instruções `LW`)  
- ⚠️ Tratamento de **exceções de overflow**  
- 🔁 Tratamento de **control hazards** (previsão estática — *not taken*)  

---

## 🧱 Estrutura do Projeto
