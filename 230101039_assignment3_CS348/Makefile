all: lexer

lexer: a3_230101039.l
	flex a3_230101039.l
	gcc lex.yy.c -o lexer

run: lexer
	./lexer

clean:
	rm -f lex.yy.c lexer a3_230101039_token.txt a3_230101039_st.txt