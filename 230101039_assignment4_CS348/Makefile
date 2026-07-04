CC = gcc
LEX = flex
YACC = yacc

# Variables for your specific filenames
ROLL = 230101039
LEX_FILE = a4_$(ROLL).l
YACC_FILE = a4_$(ROLL).y
TEST_FILE = a4_$(ROLL)_test.nc
ERROR_TEST_FILE = a4_$(ROLL)_error_test.nc

all: a.out

a.out: lex.yy.c y.tab.c
	$(CC) lex.yy.c y.tab.c -o a.out

y.tab.c y.tab.h: $(YACC_FILE)
	$(YACC) -d $(YACC_FILE)

lex.yy.c: $(LEX_FILE) y.tab.h
	$(LEX) $(LEX_FILE)

test: a.out
	./a.out < $(TEST_FILE)

error-test: a.out
	./a.out < $(ERROR_TEST_FILE)

clean:
	rm -f lex.yy.c y.tab.c y.tab.h a.out

.PHONY: all test error-test clean
