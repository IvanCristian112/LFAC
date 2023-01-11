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
    CONSTANT = 260,
    RETURN = 261,
    ASSIGN = 262,
    NR = 263,
    CLASS = 264,
    FLT = 265,
    IF = 266,
    BOOL = 267,
    ELSE = 268,
    WHILE = 269,
    TRUE = 270,
    FALSE = 271,
    CHARACTER = 272,
    STR = 273,
    ARRAY = 274,
    MAIN = 275,
    ADD = 276,
    SUBTRACT = 277,
    MULTIPLY = 278,
    DIVIDE = 279,
    AND = 280,
    OR = 281,
    GT = 282,
    GE = 283,
    LT = 284,
    LE = 285,
    EQ = 286,
    NEQ = 287,
    NOT = 288
  };
#endif
/* Tokens.  */
#define ID 258
#define TIP 259
#define CONSTANT 260
#define RETURN 261
#define ASSIGN 262
#define NR 263
#define CLASS 264
#define FLT 265
#define IF 266
#define BOOL 267
#define ELSE 268
#define WHILE 269
#define TRUE 270
#define FALSE 271
#define CHARACTER 272
#define STR 273
#define ARRAY 274
#define MAIN 275
#define ADD 276
#define SUBTRACT 277
#define MULTIPLY 278
#define DIVIDE 279
#define AND 280
#define OR 281
#define GT 282
#define GE 283
#define LT 284
#define LE 285
#define EQ 286
#define NEQ 287
#define NOT 288

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "limbaj.y"

     char* string_value;

#line 127 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
