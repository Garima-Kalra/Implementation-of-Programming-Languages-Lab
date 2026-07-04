%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line_count = 1;
FILE *token_file;
FILE *st_file;

// Symbol Table Structure
#define MAX_IDS 1000
char *symbol_table[MAX_IDS];
int st_count = 0;

void insert_to_st(char *id) {
    for (int i = 0; i < st_count; i++) {
        if (strcmp(symbol_table[i], id) == 0) return;
    }
    if (st_count < MAX_IDS) {
        symbol_table[st_count++] = strdup(id);
    }
}
%}

%option noyywrap

/* Regular Expressions based on nanoC Grammar */
DIGIT              [0-9]
NON_ZERO           [1-9]
LETTER             [a-zA-Z_]
ID                 {LETTER}({LETTER}|{DIGIT})*
INTEGER_CONSTANT   0|({NON_ZERO}{DIGIT}*)
DIGIT_SEQ          {DIGIT}+
FRAC_CONST         ({DIGIT_SEQ}?\.{DIGIT_SEQ})|({DIGIT_SEQ}\.)
ESC_SEQ            \\['"?\\abfnrtv]
C_CHAR             [^'\\\n]|{ESC_SEQ}
S_CHAR             [^"\\\n]|{ESC_SEQ}



%%
    /* --- 1. Whitespace and Line Counting ---*/
[ \t\v\f\r]+    { /* Ignore whitespace */ }
\n              { line_count++; }


    /* --- 2. Comments --- */
"/*" {
    int c;
    while ((c = input()) != 0) {
        if (c == '\n') line_count++;
        else if (c == '*') {
            if ((c = input()) == '/') break;
            else unput(c);
        }
    }
    if (c == 0) {
        fprintf(stderr, "Line %d: Error: Unexpected EOF inside comment\n", line_count);
    }
}

"//".* { /* Ignore single-line comments */ }


    /* --- 3. Keywords (Must be before Identifiers) --- */
"break"|"case"|"char"|"continue"|"default"|"do"|"double"|"else"|"float"|"for"|"if"|"int"|"long"|"return"|"short"|"signed"|"static"|"unsigned"|"void"|"while"|"_Bool" {
    fprintf(token_file, "Line %d: <KEYWORD, %s>\n", line_count, yytext);
}


    /* --- 4. Punctuators (Multi-character first!) --- */
"->"|"++"|"--"|"<<"|">>"|"<="|">="|"=="|"!="|"&&"|"||"|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|=" {
    fprintf(token_file, "Line %d: <PUNCTUATOR, %s>\n", line_count, yytext);
}
"["|"]"|"("|")"|"{"|"}"|"."|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<"|">"|"^"|"|"|"?"|":"|";"|"="|","|"#" {
    fprintf(token_file, "Line %d: <PUNCTUATOR, %s>\n", line_count, yytext);
}


    /* --- 5. Identifiers and Constants --- */
{ID}            { 
                  fprintf(token_file, "Line %d: <IDENTIFIER, %s>\n", line_count, yytext);
                  insert_to_st(yytext); /* Required: create symbol table  */
                }

[0-9]+{LETTER}+ {
    fprintf(token_file, "Line %d: <ERROR, invalid identifier %s>\n", line_count, yytext);
}
"@"{ID} {
    fprintf(token_file, "Line %d: <ERROR, invalid identifier %s>\n", line_count, yytext);
}

{FRAC_CONST}    { fprintf(token_file, "Line %d: <FLOATING_CONSTANT, %s>\n", line_count, yytext); }
{INTEGER_CONSTANT} { fprintf(token_file, "Line %d: <INTEGER_CONSTANT, %s>\n", line_count, yytext); }

'{C_CHAR}'     { fprintf(token_file, "Line %d: <CHARACTER_CONSTANT, %s>\n", line_count, yytext); }

''                                { fprintf(token_file, "Line %d: <ERROR, empty character constant>\n", line_count); }
\'({C_CHAR})({C_CHAR})+\'           { fprintf(token_file, "Line %d: <ERROR, multi-character constant %s>\n", line_count, yytext); }

\"{S_CHAR}*\"   { fprintf(token_file, "Line %d: <STRING_LITERAL, %s>\n", line_count, yytext); }

\"([^\\\"\n]|\\.)*\n {
    fprintf(token_file, "Line %d: <ERROR, unterminated string>\n", line_count);
    line_count++;
}

\"([^\\\"\n]|\\.)*   { fprintf(token_file, "Line %d: <ERROR, unterminated string>\n", line_count); }

    /* --- 6. Catch-all Error --- */
.                                   { fprintf(token_file, "Line %d: <ERROR, %s>\n", line_count, yytext); }
%%


int main(){
    yyin = fopen("a3_230101039_test.nc", "r");
    if(!yyin) { perror("Input file error"); return 1; }

    token_file = fopen("a3_230101039_token.txt", "w");
    st_file = fopen("a3_230101039_st.txt", "w");

    yylex();
    fprintf(st_file, "--- Symbol Table ---\n");
    for (int i = 0; i < st_count; i++) {
        fprintf(st_file, "%d. %s\n", i + 1, symbol_table[i]);
    }

    fclose(yyin); fclose(token_file); fclose(st_file);
    return 0;
}