#!/usr/bin/python

import argparse
import re

def write_lists(f, keyword, items):
    if "module" in keyword:
        keyword += "_comb("
    else:
        keyword += " "

    f.write("%s" % (keyword))

    items = list(items)
    items.sort()

    for i in range(len(items)):
        f.write(items[i])

        if i != len(items) - 1:
            f.write(",")

            if (i + 1) % 15 == 0:
                f.write("\n")
        else:
            if "module" in keyword:
                f.write(");\n")
            else:
                f.write(";\n")
    

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("sequential", help="Sequential Verilog file")
    parser.add_argument("combinational", help="Output combinational Verilog file name")

    args = parser.parse_args()

    seq = open(args.sequential, "r")
    pos = set()
    pis = set()
    wires = set()
    INPUT = 3
    OUTPUT = 1

    # inputs to dff become PO
    # outputs of dff become PI

    reading_inputs = False
    reading_outputs = False
    reading_wires = False

    for line in seq.readlines():
        if "//" in line[:3]:
            continue

        if "primitive" in line:
            break

        line = line.strip()

        if "input" in line:
            reading_inputs = True
            line = line[len("input"):]

            if line[-1] == ";":
                reading_inputs = False

            line = line.strip().strip(";").split(",")

            for input in line:
                if "CK" == input or not input:
                    continue
                
                pis.add(input.strip())

        elif reading_inputs:
            if line[-1] == ";":
                reading_inputs = False

            line = line.strip().strip(";").split(",")

            for input in line:
                if "CK" == input or not input:
                    continue
                
                pis.add(input.strip())


        elif "output" in line:
            reading_outputs = True
            line = line[len("output"):]

            if line[-1] == ";":
                reading_outputs = False

            line = line.strip().strip(";").split(",")

            for output in line:   
                if not output:
                    continue

                pos.add(output.strip())
            
        elif reading_outputs:
            if line[-1] == ";":
                reading_outputs = False

            line = line.strip().strip(";").split(",")

            for output in line: 
                if not output:
                    continue

                pos.add(output.strip())

        elif "wire" in line:
            reading_wires = True
            line = line[len("wire"):]

            if line[-1] == ";":
                reading_wires = False

            line = line.strip().strip(";").split(",")

            for wire in line:      
                if not wire:
                    continue

                wires.add(wire.strip())

        elif reading_wires:
            if line[-1] == ";":
                reading_wires = False

            line = line.strip().strip(";").split(",")

            for wire in line:      
                if not wire:
                    continue

                wires.add(wire.strip())

        elif "dff" in line:   
            elements = re.split('[(|,|)]', line)
            pos.add(elements[INPUT].strip())
            pis.add(elements[OUTPUT].strip())


    print("wires %d" % (len(wires)))
    print("POs %d" % len(pos))
    print("PIs %d " % len(pis))
    wires = wires - pis - pos
    print("wires %d" % (len(wires)))


    seq.close()

    seq = open(args.sequential, "r")
    comb = open(args.combinational, "w")
    
    reading_list = False

    for line in seq.readlines():
        if "//" in line[:3]:
            comb.write(line)
        elif reading_list:    
            if ";" in line:
                reading_list = False
        elif "endmodule" in line:
            comb.write(line)
            break
        elif "module" in line:
            reading_list = True
            write_lists(comb, line[:line.index("(")], pis | pos)
        elif "input" in line:
            reading_list = True
            write_lists(comb, "input", pis)
        elif "output" in line:
            reading_list = True
            write_lists(comb, "output", pos)
        elif "wire" in line:
            reading_list = True
            write_lists(comb, "wire", wires)
        elif "CK" not in line and "dff" not in line:
            comb.write(line)            


    seq.close()
    comb.close()
    

if __name__ == "__main__":
    main()