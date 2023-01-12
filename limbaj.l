
%{
#include <stdio.h>
#include "y.tab.h"
%}
%option noyywrap
%%

"main ()"  {return MAIN;}
"int"|"float"|"char"|"string"  {yylval.string_value=strdup(yytext); return TIP;}
 "bool"  {return BOOL;}
"+"     {return ADD; }
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
"if"    {return IF;}
"else"  {return ELSE;}
"while" {return WHILE;}
"for"   {return FOR;}
"true"  {return TRUE;}
"false" {return FALSE;}
\[[1-9][0-9]*\] {return ARRAY;}
"return" {return RETURN;}
@[_a-zA-Z][_a-zA-Z0-9]* {yylval.string_value=strdup(yytext); return ID;}
":=" {return ASSIGN;}
\"[a-zA-Z]\" {yylval.string_value=strdup(yytext); return CHARACTER;}
\"[a-zA-z]+\" {yylval.string_value=strdup(yytext); return STR;}
[1-9][0-9]*|0 {yylval.string_value=strdup(yytext); return NR;}
([0-9]*[.])?[0-9]+ {yylval.string_value=strdup(yytext); return FLT;}
[ \t] ;
\n {yylineno++;}
. {return yytext[0];}
