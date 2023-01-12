#include <string.h>
#include <stdio.h>
struct symbol_variables 
{
    char id_name[128];
    char data_type[128];

};
struct symbol_functions
{
    char return_type[25];
    char id_name [128];
    char parameters[1024];
    
};
struct auxiliar
{
    char result[1000];
};
int search_variable(char* name,char* type, struct symbol_variables *table)
{
    int result=0;
    for(int i=0;i<1000;i++)
    {
        if(strcmp(table[i].id_name,name)==0 && strcmp(table[i].data_type,type)==0)
        {
            result=1;
        }
    }
    return result;
}
int search_variable_name(char* name, struct symbol_variables *table)
{
    int result=0;
    for(int i=0;i<1000;i++)
    {
        if(strcmp(table[i].id_name,name)==0 )
        {
            result=1;
        }
    }
    return result;
}
int search_function_name(char* name, struct symbol_functions *table)
{
    int result=0;
    for(int i=0;i<1000;i++)
    {
        if(strcmp(table[i].id_name,name)==0 )
        {
            result=1;
        }
    }
    return result;
}

int search_function(char* name, char* type, char* function_parameters, struct symbol_functions * table)
/* ca doua functii sa fie identice trebuie ca signatura lor sa fie aceeasi*/

{
    int result=0;
    for(int i=0;i<1000;i++)
    {
        if(strcmp(table[i].id_name,name)==0 && strcmp(table[i].return_type,type)==0 
        && strcmp(table[i].parameters,function_parameters)==0)
        {
            result=1;
        }
    }
    return result;
}
int add_variable(char* name, char* type, struct symbol_variables *table, int index)
{
    if(search_variable(name,type,table)==1) return 0;
    
    strcpy(table[index].id_name,name);
    strcpy(table[index].data_type,type);

    return 1;
}

int add_function(char* name, char* return_type, char* function_parameters, struct symbol_functions *table, int index)
{
    if(search_function(name,return_type,function_parameters,table)==1) return 0;
    strcpy(table[index].id_name,name);
    strcpy(table[index].return_type,return_type);
    if(function_parameters) 
    {
        strcpy(table[index].parameters, function_parameters);
    }
    else strcpy(table[index].parameters,"Functia nu are parametri");
    
    return 1;

}