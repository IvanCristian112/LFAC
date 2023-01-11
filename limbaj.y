%{
#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
struct symbol_variables symbol_table[1000];
int nr_variables=0;
struct symbol_functions symbol_table_functions[1000];
int nr_functions=0;
int nr_functions_with_parameters=0;
struct auxiliar parameters_for_function [20];
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

%type<string_value>lista_param
 

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
                          if (add_variable($2, $1, symbol_table, nr_variables)==1)
                         {
                              nr_variables++;
                         }
                         else printf("Variabila exista deja\n");
                    } 
               
                    | TIP ID ARRAY  
                    {                  
                          if (add_variable($2, $1, symbol_table, nr_variables)==1)
                         {
                              nr_variables++;
                         }
                         else printf("Variabila exista deja\n");
                    } 
                    | TIP ID ASSIGN expresie
                    {
                          if (add_variable($2, $1, symbol_table, nr_variables)==1)
                         {
                              nr_variables++;
                         }
                         else printf("Variabila %s exista deja. Linia: %d\n", $2,yylineno);
                    } 
                    ;

function_declaration : TIP ID '(' ')'
                    {
                         if(add_function($2,$1,NULL,symbol_table_functions,nr_functions)==1)
                         {
                              nr_functions++;
                         } 
                         else printf("Functia %s exista deja. Linia: %d\n", $2,yylineno);
                    }
                    | TIP ID '(' lista_param ')'
                    {

                         if(add_function($2,$1, parameters_for_function[nr_functions_with_parameters].result,symbol_table_functions,nr_functions)==1)
                         {
                              nr_functions++;
                              nr_functions_with_parameters++;
                         } 
                         else printf("Functia %s exista deja. Linia: %d\n", $2,yylineno);
                    }
                    | TIP ID '(' lista_param ')'  '{'variable_declarations list  RETURN expresie ';' '}'
                    {
                         if(add_function($2,$1,parameters_for_function[nr_functions_with_parameters].result,symbol_table_functions,nr_functions)==1)
                         {
                              nr_functions++;
                              nr_functions_with_parameters++;
                         } 
                         else printf("Functia %s exista deja. Linia: %d\n", $2,yylineno);
                    }                    
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
               {
                    strcat(parameters_for_function[nr_functions_with_parameters].result,$3);
                    strcat(parameters_for_function[nr_functions_with_parameters].result," ");
                    strcat(parameters_for_function[nr_functions_with_parameters].result,$4);
                    strcat(parameters_for_function[nr_functions_with_parameters].result," ");
               }
            | TIP ID
            {
               strcat(parameters_for_function[nr_functions_with_parameters].result,$1);
               strcat(parameters_for_function[nr_functions_with_parameters].result," ");
               strcat(parameters_for_function[nr_functions_with_parameters].result,$2);
               strcat(parameters_for_function[nr_functions_with_parameters].result," ");
            }
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
     for(int i=0; i<nr_variables;i++)
     {
          fprintf(fp,"Nume: %s\n",symbol_table[i].id_name);
          fprintf(fp,"Tip: %s\n", symbol_table[i].data_type);
          fprintf(fp,"\n");
     }
     fclose(fp);
     fp=fopen("symbol_table_functions.txt","w");
     for(int i=0;i<nr_functions_with_parameters;i++)
     {    
          fprintf(fp,"%s\t",symbol_table_functions[i].return_type);
          fprintf(fp,"%s\n",symbol_table_functions[i].id_name);    
          fprintf(fp,"Parametrii: %s\t",parameters_for_function[i].result);
          fprintf(fp,"\n");
     }
     
} 
