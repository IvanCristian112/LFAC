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

typedef struct node
{
     int value;
     float value_flt;
     char* type;
     char* root; // pentru ca am pus %token<string_valoare>nr 
     struct node* left;
     struct node* right; 
} node;

node* buildAST(char* root, char* type, node* left, node* right, node* current_node);
int evalAST(node *tree);
char* TypeOf(node* tree);

%}
%union {
     char* string_value;
     struct node* expr;
}
%token <string_value> ID
%token <string_value> TIP 
%token <string_value> CHARACTER
%token <string_value> STR
%token <string_value> NR
%token <string_value> FLT

%token CONSTANT RETURN  ASSIGN CLASS  IF BOOL FOR
%token ELSE WHILE TRUE FALSE   ARRAY MAIN

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
%type<expr>expresie_int

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
                         else yyerror("Variabila exista deja");
                    } 
               
                    | TIP ID ARRAY  
                    {                  
                          if (add_variable($2, $1, symbol_table, nr_variables)==1)
                         {
                              nr_variables++;
                         }
                         else yyerror("Variabila exista deja");
                    } 
                    | TIP ID ASSIGN expresie
                    {
                          if (add_variable($2, $1, symbol_table, nr_variables)==1)
                         {
                              nr_variables++;
                         }
                         else yyerror("Variabila %s exista deja");
                    } 
                    ;

function_declaration : TIP ID '(' ')'
                    {
                         if(add_function($2,$1,NULL,symbol_table_functions,nr_functions)==1)
                         {
                              nr_functions++;
                         } 
                         else yyerror("Functia  exista deja");
                    }
                    | TIP ID '(' lista_param ')'
                    {

                         if(add_function($2,$1, parameters_for_function[nr_functions_with_parameters].result,symbol_table_functions,nr_functions)==1)
                         {
                              nr_functions++;
                              nr_functions_with_parameters++;
                         } 
                         else yyerror("Functia  exista deja");
                    }
                    | TIP ID '(' lista_param ')'  '{'variable_declarations list  RETURN expresie ';' '}'
                    {
                         if(add_function($2,$1,parameters_for_function[nr_functions_with_parameters].result,symbol_table_functions,nr_functions)==1)
                         {
                              nr_functions++;
                              nr_functions_with_parameters++;
                         } 
                         else yyerror("Functia  exista deja");
                    }                    
                    ;

class_declarations : class_declaration ';'
                    | class_declarations  class_declaration ';'
                    ;
class_declaration : CLASS ID 
                    | CLASS ID '{'variable_declarations function_declarations'}'
                    ;
main : MAIN '{' variable_declarations list RETURN NR ';' '}'
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
statement : ID ASSIGN expresie
         {
          if(search_variable_name($1,symbol_table)==0)
          {
               yyerror("Variabila apelata nu exista");
          }
         }
         | ID ARRAY ASSIGN expresie 
         {
          if(search_variable_name($1,symbol_table)==0)
          {
               yyerror("Variabila apelata nu exista");
          }
         }
         | ID ASSIGN ID '.' ID 
         { 
          if(search_variable_name($1,symbol_table)==0)
          {
               yyerror("Variabila apelata nu exista");
          }
         }
         | ID ARRAY ASSIGN ID '.' ID
         { 
          if(search_variable_name($1,symbol_table)==0)
          {
               yyerror("Variabila apelata nu exista");
          }
         }
         | ID '.' ID ASSIGN expresie
         { 
          if(search_variable_name($3,symbol_table)==0)
          {
               yyerror("Variabila apelata nu exista");
          }
         }               
         | ID '.' ID ASSIGN ID '.' ID
         { 
          if(search_variable_name($3,symbol_table)==0)
          {
               yyerror("Variabila apelata nu exista");
          }
         }
         | ID '(' lista_apel ')'
         {
          if(search_function_name($1,symbol_table_functions)==0)
          {
               yyerror("Functia apelata nu exista");
          }
         }
         | IF '(' expresie ')' '{' list '}'
         | IF '(' expresie ')' '{' list '}' ELSE '{' list '}'
         | WHILE '(' expresie ')' '{' list '}'
         | FOR '(' variable_declaration ';'  expresie ';'  list  ')' '{' list '}'
         ;
        
lista_apel : expresie
           | lista_apel ',' expresie
           ;
expresie : STR
          | CHARACTER
          | expresie_bool
          | expresie_int
          ;
expresie_int : NR   {$$=buildAST($1,"NUMBER",NULL,NULL,$$); $$->value=atoi($1);}
          | expresie_int ADD expresie_int 
          {
               $$=buildAST("+","PLUS",$1, $3,$$);
          }
          |FLT {$$=buildAST($1,"FLOAT",NULL,NULL,$$); $$->value=atoi($1);}
          | expresie_int SUBTRACT expresie_int
          {
               $$=buildAST("-","MINUS",$1,$3,$$);
          }
          | expresie_int MULTIPLY expresie_int
          {
               $$=buildAST("*","PRODUCT",$1,$3,$$);
          }
          | expresie_int DIVIDE expresie_int
          {
               $$=buildAST("*","DIVIDE",$1,$3,$$);
          }
          | '(' expresie_int ')' {$$=$2;}
          | ID 
          {
               $$=buildAST($1, "ID", NULL, NULL, $$);
          }
          | ID ARRAY
          {
               $$=buildAST($1, "ID", NULL, NULL, $$);
          }
          | ID  '(' lista_apel ')'
          {

          }
          ;
expresie_bool : variabila_bool EQ variabila_bool
          | variabila_bool NEQ variabila_bool
          | variabila_bool GT variabila_bool
          | variabila_bool GE variabila_bool
          | variabila_bool LT variabila_bool
          | variabila_bool LE variabila_bool
          | expresie_bool OR expresie_bool
          | expresie_bool AND expresie_bool 
          | NOT expresie_bool
          | '(' expresie_bool ')'
          ;
variabila_bool : expresie_int
%%
int yyerror(char * s){
printf("eroare: %s la linia:%d\n",s,yylineno);
}
node* buildAST(char* root, char* type, node* left, node*right, node* current_node)
{
     node* new_node=(node*)malloc(sizeof(current_node));
     char* new_root=(char*)malloc(strlen(root)+1);
     char* new_type=(char*)malloc(strlen(type+1));
     strcpy(new_root,root);
     strcpy(new_type,type);
     new_node->left=left;
     new_node->right=right;
     new_node->value=current_node->value;
     new_node->type=new_type;
     new_node->root=new_root;
     return(new_node);
}
int evalAST(node* tree)
{
     //cazuri luate din enuntul temei

     //radacina este un numar, il returnam 
     if(strcmp(tree->type,"NUMBER")==0)
     {
          return tree->value;
     }
     if(strcmp(tree->type,"FLOAT")==0)
     {
          return tree->value_flt;
     }
     //radacina este un ID, ii returnam valoarea
     else if(strcmp(tree->type,"ID")==0)
     {
          return tree->value;
     }
     //radacina este + 
     else if(strcmp(tree->type,"PLUS")==0)
     {
          int a=evalAST(tree->left);
          int b=evalAST(tree->right);
          return (a+b);
     }
     //radacina este -
     else if(strcmp(tree->type,"MINUS")==0)
     {
          int a=evalAST(tree->left);
          int b=evalAST(tree->right);
          return (a-b);
     }
     //radacina este *
     else if(strcmp(tree->type,"PRODUCT")==0)
     {
          int a=evalAST(tree->left);
          int b=evalAST(tree->right);
          return (a*b);
     }
     //radacina este /
     else if(strcmp(tree->type,"DIVIDE")==0)
     {
          int a=evalAST(tree->left);
          int b=evalAST(tree->right);
          return(a/b);
     }
     //radacina este orice altceva
     else  return 0;

}
char* TypeOf(node* tree)
{    
     char result[100];
     if (strcmp(tree->type,"NUMBER")==0)
     {
          strcpy(result,"int");
     }     
     else if(strcmp(tree->type,"FLOAT")==0)
     {    
           strcpy(result,"float");
     }

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
