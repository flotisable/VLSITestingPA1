srcDir        := src
binDir        := bin
testDir       := Test
cktDir        := sample_circuits
reportDir     := reports
PROG          := atpg
goldenProgram := golden_atpg

circuits := $(patsubst ${cktDir}/%.ckt, %, $(wildcard ${cktDir}/*.ckt) )

reportProgram := reportStatistic.perl

-include reportCircuits.txt

.PHONY: all ${srcDir}/${PROG} clean test tags report

all: ${srcDir}/${PROG}

${srcDir}/${PROG}:
	${MAKE} -C ${srcDir}

test: ${testDir} ${srcDir}/${PROG}
	@for circuit in ${circuits}; do \
		echo "test $${circuit}"; \
		circuitFull=${cktDir}/$${circuit}.ckt; \
		report=${reportDir}/golden_$${circuit}.report; \
		goldenLog=${testDir}/golden_$${circuit}.log; \
		log=${testDir}/$${circuit}.log; \
		./${binDir}/${goldenProgram} -fsim $${report} $${circuitFull} >& $${goldenLog}; \
		./${srcDir}/${PROG} -fsim $${report} $${circuitFull} >& $${log}; \
		diff $${goldenLog} $${log} >& /dev/null; \
		if [ !$$? ]; then \
			echo "$${circuit} is not the same as golden result!"; \
		fi \
	done

${testDir}:
	mkdir $@

tags:
	ctags ${srcDir}/*.{h,cpp}

report: reportCircuits.txt
	@for circuit in ${reportCircuits}; do \
		circuitFull=${cktDir}/$${circuit}.ckt; \
		report=${reportDir}/golden_$${circuit}.report; \
		./${binDir}/${goldenProgram} -fsim $${report} $${circuitFull} | ./${reportProgram}; \
	done

clean:
	rm ${srcDir}/*.o ${srcDir}/${PROG}
