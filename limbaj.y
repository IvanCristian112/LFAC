%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%token ID INT FLOAT CHAR STRING BOOL CONSTANT BGIN END ASSIGN NR CLASS FLT IF ELSE WHILE TRUE FALSE
%left OR
%left AND
%left EQ NEQ
%left GT GE LT LE
%left NOT
%left ADD SUBTRACT
%left MULTIPLY DIVIDE
 
%start progr
%%
progr: declaratii bloc {printf("program corect sintactic\n");}
     ;

declaratii :  declaratie ';'
	   | declaratii declaratie ';'
	   ;
declaratie : TIP ID 
           | TIP ID ASSIGN EXPRESIE          
           | TIP ID ASSIGN ID '.' ID  
           | TIP ID '(' ')'
           | TIP ID '(' lista_param ')'
           | TIP ID '(' lista_param ')' '{' declaratii '}'
           | CLASS ID '{''}'
           | CLASS ID '{' declaratii '}'


           ;
lista_param : param
            | lista_param ','  param 
            ;
TIP: INT | FLOAT | BOOL | CHAR | STRING
param : TIP ID
      ; 
      
/* bloc */
bloc : BGIN list END  
     ;
     
/* lista instructiuni */
list :  statement ';' 
     | list statement ';'
     ;

/* instructiune */
statement: 
         | ID ASSIGN EXPRESIE
         | ID ASSIGN ID '.' ID 
         | ID '.' ID ASSIGN EXPRESIE
         | ID '.' ID ASSIGN ID '.' ID
         | ID '(' lista_apel ')'
         | IF '(' EXPRESIE ')' '{' list '}'
         | IF '(' EXPRESIE ')' '{' list '}' ELSE '{' list '}'
         | WHILE '(' EXPRESIE ')' '{' list '}'
         ;
        
lista_apel : EXPRESIE
           | ID  '(' lista_apel ')'
           | lista_apel ',' EXPRESIE
           | lista_apel ',' ID '(' lista_apel ')'
           ;
EXPRESIE : NR
          | FLT 
          | ID 
          | EXPRESIE ADD EXPRESIE 
          | EXPRESIE SUBTRACT EXPRESIE
          | EXPRESIE MULTIPLY EXPRESIE
          | EXPRESIE DIVIDE EXPRESIE
          | EXPRESIE EQ EXPRESIE
          | EXPRESIE NEQ EXPRESIE
          | EXPRESIE GT EXPRESIE
          | EXPRESIE GE EXPRESIE
          | EXPRESIE LT EXPRESIE
          | EXPRESIE LE EXPRESIE
          | EXPRESIE OR EXPRESIE
          | EXPRESIE AND EXPRESIE
          | NOT EXPRESIE 
          | '(' EXPRESIE ')'
          ;

%%
int yyerror(char * s){
printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
yyin=fopen(argv[1],"r");
yyparse();
} 
