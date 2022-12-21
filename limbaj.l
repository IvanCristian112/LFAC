%{
#include <stdio.h>
#include "y.tab.h"
%}
%option noyywrap
%%
"int" {return INT;}
"float" {return FLOAT;}
"char" {return CHAR;}
"string" {return STRING;}
"bool" {return BOOL;}
"+"    {return ADD; }
"-"     {return SUBTRACT;}
"*"     {return MULTIPLY;}
"/"     {return DIVIDE;}
">"     {return GT;  }
"<"     {return LT;}
">="    {return GE;}
"<="    {return LE;}
"=="    {return EQ;}
"!="    {return NEQ;}
"OR"    {return OR;}
"AND"   {return AND;}
"const" {return CONSTANT;}
"!"     {return NOT;}
"class" {return CLASS;}
"begin_progr" {return BGIN;}
"end_progr" {return END;}
@[_a-zA-Z][_a-zA-Z0-9]* {return ID;}
":=" {return ASSIGN;}
[1-9][0-9]*|0 {return NR;}
[1-9][0-9]*|0.[0-9]+ {return FLT;}
[ \t] ;
\n {yylineno++;}
. {return yytext[0];}

 