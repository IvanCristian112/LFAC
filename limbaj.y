%{
#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
struct symbol_variables symbol_table[1000];
int nr_variabile=0;
%}
%union {
     char* string_value;
}
%token <string_value> ID
%token <string_value> TIP 
%token CONSTANT RETURN  ASSIGN NR CLASS FLT IF BOOL
%token ELSE WHILE TRUE FALSE CHARACTER STR ARRAY MAIN

%right IF ELSE
%left '(' ')'
%left ADD SUBTRACT
%left MULTIPLY DIVIDE
%left AND 
%left OR
%left GT GE LT LE 
%left EQ NEQ
%left NOT


 

%start progr
%%
progr : variable_declarations function_declarations class_declarations main {printf("program corect sintactic\n");}
     ;
variable_declarations : variable_declaration ';'
                    | variable_declarations  variable_declaration ';'
                    ;
function_declarations : function_declaration ';'
                    | function_declarations  function_declaration ';'
                    ;                    
variable_declaration : TIP ID 

                   {
                          if (add_variable($2, $1, symbol_table, nr_variabile)==1)
                         {
                              nr_variabile++;
                         }
                         else printf("Variabila exista deja\n");
                    } 
               
                    | TIP ID ARRAY  
                    {                  
                          if (add_variable($2, $1, symbol_table, nr_variabile)==1)
                         {
                              nr_variabile++;
                         }
                         else printf("Variabila exista deja\n");
                    } 
                    | TIP ID ASSIGN expresie
                    {
                          if (add_variable($2, $1, symbol_table, nr_variabile)==1)
                         {
                              nr_variabile++;
                         }
                         else printf("Variabila %s exista deja. Linia: %d\n", $2,yylineno);
                    } 
                    ;

function_declaration : TIP ID '(' ')'
                    | TIP ID '(' lista_param ')'
                    | TIP ID '(' lista_param ')'  '{'variable_declarations list  RETURN expresie ';' '}'
                    ;

class_declarations : class_declaration ';'
                    | class_declarations  class_declaration ';'
                    ;
class_declaration : CLASS ID 
                    | CLASS ID '{'variable_declarations function_declarations'}'
                    ;
main : MAIN '{'  '}'
     ;

lista_param : lista_param ','  TIP ID
            | TIP ID
            ;            
      

     
/* lista instructiuni */
list :  statement ';' 
     | list statement ';'
     ;

/* instructiune */
statement : 
         | ID ASSIGN expresie
         | ID ARRAY ASSIGN expresie 
         | ID ASSIGN ID '.' ID 
         | ID ARRAY ASSIGN ID '.' ID
         | ID '.' ID ASSIGN expresie
         | ID '.' ID ASSIGN ID '.' ID
         | ID '(' lista_apel ')'
         | IF '(' expresie ')' '{' list '}'
         | IF '(' expresie ')' '{' list '}' ELSE '{' list '}'
         | WHILE '(' expresie ')' '{' list '}'
         ;
        
lista_apel : expresie
           | ID  '(' lista_apel ')'
           | lista_apel ',' expresie
           | lista_apel ',' ID '(' lista_apel ')'
           ;
expresie : NR
          | FLT 
          | STR
          | CHARACTER
          | ID 
          | ID ARRAY
          | expresie ADD expresie 
          | expresie SUBTRACT expresie
          | expresie MULTIPLY expresie
          | expresie DIVIDE expresie
          | expresie EQ expresie
          | expresie NEQ expresie
          | expresie GT expresie
          | expresie GE expresie
          | expresie LT expresie
          | expresie LE expresie
          | expresie OR expresie
          | expresie AND expresie
          | NOT expresie 
          | '(' expresie ')'
          ;

%%
int yyerror(char * s){
printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){

     yyin=fopen(argv[1],"r");
     yyparse();
     FILE* fp=fopen("symbol_table.txt","w");
     for(int i=0; i<nr_variabile;i++)
     {
          fprintf(fp,"Nume: %s\n",symbol_table[i].id_name);
          fprintf(fp,"Tip: %s\n", symbol_table[i].data_type);
          fprintf(fp,"\n");
     }


     
} 
