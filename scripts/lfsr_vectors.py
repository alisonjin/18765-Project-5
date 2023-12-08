#!/usr/bin/python

def main():
    q = '0000001'
    repeat = False
    test_vectors = dict()
    test_vectors['chain1'] = list()
    test_vectors['chain2'] = list()
    test_vectors['chain3'] = list()
    test_vectors['chain4'] = list()
    test_vectors['chain5'] = list()
    test_vectors['chain6'] = list()
    test_vectors['chain7'] = list()

    while not repeat:
        chain1 = ''
        chain2 = ''
        chain3 = ''
        chain4 = ''
        chain5 = ''
        chain6 = ''
        chain7 = ''

        for i in range(31):
            # print(q, end='\t')
            chain1 += q[6]
            chain2 += q[5]
            chain3 += q[4]
            chain4 += q[3]
            chain5 += q[2]
            chain6 += q[1]
            chain7 += q[0]

            q = str(int(q[0]) ^ int(q[1])) + q[2:] + q[0]
            
            
    
        if chain1 in test_vectors['chain1']:
            repeat = True
        
        if chain2 in test_vectors['chain2']:
            repeat = True

        if chain3 in test_vectors['chain3']:
            repeat = True

        if chain4 in test_vectors['chain4']:
            repeat = True

        if chain5 in test_vectors['chain5']:
            repeat = True

        if chain6 in test_vectors['chain6']:
            repeat = True

        if chain7 in test_vectors['chain7']:
            repeat = True

        if not repeat:
            test_vectors['chain1'].append(chain1)
            test_vectors['chain2'].append(chain2)
            test_vectors['chain3'].append(chain3)
            test_vectors['chain4'].append(chain4)
            test_vectors['chain5'].append(chain5)
            test_vectors['chain6'].append(chain6)
            test_vectors['chain7'].append(chain7)

    print("num vectors: " + str(len(test_vectors['chain1'])))

    with open("LFSR_vectors.txt", "w") as f:
        f.write("%-40s%-40s%-40s%-40s%-40s%-40s%-40s\n" % ('chain1', 'chain2', 'chain3', 'chain4', 'chain5', 'chain6', 'chain7'))
        
        for i in range(len(test_vectors['chain1'])):
            f.write("%-40s%-40s%-40s%-40s%-40s%-40s%-40s\n" % (test_vectors['chain1'][i], test_vectors['chain2'][i], test_vectors['chain3'][i], test_vectors['chain4'][i], test_vectors['chain5'][i], test_vectors['chain6'][i], test_vectors['chain7'][i]))

    inputs = []

    with open("lfsr_verilog.txt", "w") as f:
        for i in range(len(test_vectors['chain1'])):
            binary = ''

            for j in range(7):
                key = 'chain%d' % (j + 1)

                if key != 'chain7':
                    binary += test_vectors[key][i][1:]
                else:
                    binary += test_vectors[key][i]

            inputs.append(binary)

            f.write("#5 CK=0;\n")
            f.write("#5 LFSR=211'b%s;\n" % (binary))
            f.write("#5 CK=1;\n")
            f.write('$fwrite(f, "%b\\n", TEST_OUT);\n\n')


    outputs = []

    with open("../vcs/output.txt", "r") as f:
        for line in f.readlines():
            if line:
                outputs.append(line.strip())

    dont_care_input = ''

    for i in range(247):
        dont_care_input += '0'

    with open("lfsr_etr.txt", "w") as f:
        for i, output in enumerate(outputs):
            f.write("%-3d: %s %s\n" % (i + 1 + 201, dont_care_input[:36] + inputs[i], output))
        

if __name__ == "__main__":
    main()