/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    CONSTANT = 259,                /* CONSTANT  */
    STRING_LITERAL = 260,          /* STRING_LITERAL  */
    INC_OP = 261,                  /* INC_OP  */
    DEC_OP = 262,                  /* DEC_OP  */
    LEFT_OP = 263,                 /* LEFT_OP  */
    RIGHT_OP = 264,                /* RIGHT_OP  */
    LE_OP = 265,                   /* LE_OP  */
    GE_OP = 266,                   /* GE_OP  */
    EQ_OP = 267,                   /* EQ_OP  */
    NE_OP = 268,                   /* NE_OP  */
    AND_OP = 269,                  /* AND_OP  */
    OR_OP = 270,                   /* OR_OP  */
    MUL_ASSIGN = 271,              /* MUL_ASSIGN  */
    DIV_ASSIGN = 272,              /* DIV_ASSIGN  */
    MOD_ASSIGN = 273,              /* MOD_ASSIGN  */
    ADD_ASSIGN = 274,              /* ADD_ASSIGN  */
    SUB_ASSIGN = 275,              /* SUB_ASSIGN  */
    LEFT_ASSIGN = 276,             /* LEFT_ASSIGN  */
    RIGHT_ASSIGN = 277,            /* RIGHT_ASSIGN  */
    AND_ASSIGN = 278,              /* AND_ASSIGN  */
    XOR_ASSIGN = 279,              /* XOR_ASSIGN  */
    OR_ASSIGN = 280,               /* OR_ASSIGN  */
    VOID = 281,                    /* VOID  */
    CHAR = 282,                    /* CHAR  */
    SHORT = 283,                   /* SHORT  */
    INT = 284,                     /* INT  */
    LONG = 285,                    /* LONG  */
    FLOAT = 286,                   /* FLOAT  */
    DOUBLE = 287,                  /* DOUBLE  */
    SIGNED = 288,                  /* SIGNED  */
    UNSIGNED = 289,                /* UNSIGNED  */
    BOOL = 290,                    /* BOOL  */
    STATIC = 291,                  /* STATIC  */
    IF = 292,                      /* IF  */
    ELSE = 293,                    /* ELSE  */
    WHILE = 294,                   /* WHILE  */
    DO = 295,                      /* DO  */
    FOR = 296,                     /* FOR  */
    CONTINUE = 297,                /* CONTINUE  */
    BREAK = 298,                   /* BREAK  */
    RETURN = 299                   /* RETURN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define IDENTIFIER 258
#define CONSTANT 259
#define STRING_LITERAL 260
#define INC_OP 261
#define DEC_OP 262
#define LEFT_OP 263
#define RIGHT_OP 264
#define LE_OP 265
#define GE_OP 266
#define EQ_OP 267
#define NE_OP 268
#define AND_OP 269
#define OR_OP 270
#define MUL_ASSIGN 271
#define DIV_ASSIGN 272
#define MOD_ASSIGN 273
#define ADD_ASSIGN 274
#define SUB_ASSIGN 275
#define LEFT_ASSIGN 276
#define RIGHT_ASSIGN 277
#define AND_ASSIGN 278
#define XOR_ASSIGN 279
#define OR_ASSIGN 280
#define VOID 281
#define CHAR 282
#define SHORT 283
#define INT 284
#define LONG 285
#define FLOAT 286
#define DOUBLE 287
#define SIGNED 288
#define UNSIGNED 289
#define BOOL 290
#define STATIC 291
#define IF 292
#define ELSE 293
#define WHILE 294
#define DO 295
#define FOR 296
#define CONTINUE 297
#define BREAK 298
#define RETURN 299

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
