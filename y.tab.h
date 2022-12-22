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
    INT = 259,
    FLOAT = 260,
    CHAR = 261,
    STRING = 262,
    BOOL = 263,
    CONSTANT = 264,
    BGIN = 265,
    END = 266,
    ASSIGN = 267,
    NR = 268,
    CLASS = 269,
    FLT = 270,
    IF = 271,
    ELSE = 272,
    WHILE = 273,
    TRUE = 274,
    FALSE = 275,
    OR = 276,
    AND = 277,
    EQ = 278,
    NEQ = 279,
    GT = 280,
    GE = 281,
    LT = 282,
    LE = 283,
    NOT = 284,
    ADD = 285,
    SUBTRACT = 286,
    MULTIPLY = 287,
    DIVIDE = 288
  };
#endif
/* Tokens.  */
#define ID 258
#define INT 259
#define FLOAT 260
#define CHAR 261
#define STRING 262
#define BOOL 263
#define CONSTANT 264
#define BGIN 265
#define END 266
#define ASSIGN 267
#define NR 268
#define CLASS 269
#define FLT 270
#define IF 271
#define ELSE 272
#define WHILE 273
#define TRUE 274
#define FALSE 275
#define OR 276
#define AND 277
#define EQ 278
#define NEQ 279
#define GT 280
#define GE 281
#define LT 282
#define LE 283
#define NOT 284
#define ADD 285
#define SUBTRACT 286
#define MULTIPLY 287
#define DIVIDE 288

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
