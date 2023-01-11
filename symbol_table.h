#include <string.h>
#include <stdio.h>
struct symbol_variables 
{
    char id_name[128];
    char data_type[128];

};
struct symbol_functions
{
    char* return_type;
    
};
int search_variable(char* name,struct symbol_variables *table)
{
    int result=0;
    for(int i=0;i<1000;i++)
    {
        if(strcmp(table[i].id_name,name)==0)
        {
            result=1;
        }
    }
    return result;
}
int add_variable(char* name, char* type, struct symbol_variables *table, int index)
{
    if(search_variable(name,table)==1) return 0;
    
    strcpy(table[index].id_name,name);
    strcpy(table[index].data_type,type);

    return 1;
}

void write_variable(FILE* fp,  char* name, struct symbol_variables table[])
{
    fprintf(fp,"variabila nu este initializata");
}