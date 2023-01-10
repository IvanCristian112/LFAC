%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%token ID INT FLOAT CHAR STRING BOOL CONSTANT RETURN  ASSIGN NR CLASS FLT IF ELSE WHILE TRUE FALSE CHARACTER STR ARRAY MAIN
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
                    | TIP ID ARRAY 
                    | TIP ID ASSIGN expresie
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
TIP : INT | FLOAT | BOOL | CHAR | STRING 
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
          | BOOL
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
} 
