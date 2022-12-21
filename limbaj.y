%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%token ID INT FLOAT CHAR STRING BOOL CONSTANT BGIN END ASSIGN NR CLASS FLT  
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
           | TIP ID '(' lista_param ')'
           | TIP ID '(' ')'
           | CLASS ID '{''}'

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
statement: ID ASSIGN ID
         | ID ASSIGN NR  		 
         | ID '(' lista_apel ')'
         ;
        
lista_apel : NR
           | lista_apel ',' NR
           ;
EXPRESIE : NR
          | ID 
          | EXPRESIE ADD EXPRESIE 
          | EXPRESIE SUBTRACT EXPRESIE
          | EXPRESIE MULTIPLY EXPRESIE
          | EXPRESIE DIVIDE EXPRESIE
          | '(' EXPRESIE ')'
%%
int yyerror(char * s){
printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
yyin=fopen(argv[1],"r");
yyparse();
} 
