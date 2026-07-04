%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h" /*Links Flex to Bison's token definitions */

extern int yylineno; 
%}

%option noyywrap
%option yylineno 

/* Regular Expressions based on nanoC Grammar */
DIGIT              [0-9]
NON_ZERO           [1-9]
LETTER             [a-zA-Z_]
ID                 {LETTER}({LETTER}|{DIGIT})*
INTEGER_CONSTANT   0|({NON_ZERO}{DIGIT}*)
DIGIT_SEQ          {DIGIT}+
FRAC_CONST         ({DIGIT_SEQ}?\.{DIGIT_SEQ})|({DIGIT_SEQ}\.)
ESC_SEQ            \\[\'\"?\\abfnrtv]
C_CHAR             [^'\\\n]|{ESC_SEQ}
S_CHAR             [^"\\\n]|{ESC_SEQ}

%%
    /* --- 1. Whitespace ---*/
[ \t\v\f\r]+    { /* Ignore whitespace */ }
\n              { /* yylineno handles counting automatically now */ }

    /* --- 2. Comments --- */
"/*" {
    int c;
    while ((c = input()) != 0) {
        if (c == '*') {
            if ((c = input()) == '/') break;
            else unput(c);
        }
    }
}
"//".* { /* Ignore single-line comments */ }

    /* --- 3. Keywords --- */
"break"         { return BREAK; }
"char"          { return CHAR; }
"continue"      { return CONTINUE; }
"do"            { return DO; }
"double"        { return DOUBLE; }
"else"          { return ELSE; }
"float"         { return FLOAT; }
"for"           { return FOR; }
"if"            { return IF; }
"int"           { return INT; }
"long"          { return LONG; }
"return"        { return RETURN; }
"short"         { return SHORT; }
"signed"        { return SIGNED; }
"static"        { return STATIC; }
"unsigned"      { return UNSIGNED; }
"void"          { return VOID; }
"while"         { return WHILE; }
"_Bool"         { return BOOL; }

    /* --- 4. Multi-character Punctuators --- */
"++"            { return INC_OP; }
"--"            { return DEC_OP; }
"<="            { return LE_OP; }
">="            { return GE_OP; }
"=="            { return EQ_OP; }
"!="            { return NE_OP; }
"&&"            { return AND_OP; }
"||"            { return OR_OP; }
"*="            { return MUL_ASSIGN; }
"/="            { return DIV_ASSIGN; }
"%="            { return MOD_ASSIGN; }
"+="            { return ADD_ASSIGN; }
"-="            { return SUB_ASSIGN; }
"<<="           { return LEFT_ASSIGN; }
">>="           { return RIGHT_ASSIGN; }
"&="            { return AND_ASSIGN; }
"^="            { return XOR_ASSIGN; }
"|="            { return OR_ASSIGN; }
"<<"            { return LEFT_OP; }
">>"            { return RIGHT_OP; }

    /* --- 5. Single-character Punctuators --- */
    /* Bison handles single characters by returning their ASCII value */
"["|"]"|"("|")"|"{"|"}"|"."|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<"|">"|"^"|"|"|"?"|":"|";"|"="|","|"#" {
    return yytext[0]; 
}

    /* --- 6. Identifiers and Constants --- */
{ID}                { return IDENTIFIER; }

    /* nanoC grammar groups all these under 'constant' */
{INTEGER_CONSTANT}  { return CONSTANT; }
{FRAC_CONST}        { return CONSTANT; }
'{C_CHAR}'          { return CONSTANT; }

\"{S_CHAR}*\"       { return STRING_LITERAL; }

    /* --- 7. Catch-all Error --- */
.                   { printf("Lexical Error on line %d: Unrecognized character %s\n", yylineno, yytext); }
%%