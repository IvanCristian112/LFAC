/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    TIP = 259,
    CHARACTER = 260,
    STR = 261,
    NR = 262,
    FLT = 263,
    CONSTANT = 264,
    RETURN = 265,
    ASSIGN = 266,
    CLASS = 267,
    IF = 268,
    BOOL = 269,
    FOR = 270,
    ELSE = 271,
    WHILE = 272,
    TRUE = 273,
    FALSE = 274,
    ARRAY = 275,
    MAIN = 276,
    ADD = 277,
    SUBTRACT = 278,
    MULTIPLY = 279,
    DIVIDE = 280,
    AND = 281,
    OR = 282,
    GT = 283,
    GE = 284,
    LT = 285,
    LE = 286,
    EQ = 287,
    NEQ = 288,
    NOT = 289
  };
#endif
/* Tokens.  */
#define ID 258
#define TIP 259
#define CHARACTER 260
#define STR 261
#define NR 262
#define FLT 263
#define CONSTANT 264
#define RETURN 265
#define ASSIGN 266
#define CLASS 267
#define IF 268
#define BOOL 269
#define FOR 270
#define ELSE 271
#define WHILE 272
#define TRUE 273
#define FALSE 274
#define ARRAY 275
#define MAIN 276
#define ADD 277
#define SUBTRACT 278
#define MULTIPLY 279
#define DIVIDE 280
#define AND 281
#define OR 282
#define GT 283
#define GE 284
#define LT 285
#define LE 286
#define EQ 287
#define NEQ 288
#define NOT 289

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 30 "limbaj.y"

     char* string_value;
     struct node* expr;

#line 130 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
