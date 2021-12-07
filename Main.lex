/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>
#include <string.h>

unsigned int col=1;
unsigned int row=1;
int comment=0;



%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */


DIGITO   [0-9]
ID       [A-Za-z_][_A-Za-z0-9]*
TEXTO    [A-Za-z0-9][A-Za-z0-9]*


%%

{DIGITO}+ {
    if(comment == 0){
        printf( "Valor inteiro: ,%s, ,%zu, (%d) Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),atoi( yytext ),row,col);
    }
    col += strlen(yytext);
}

{DIGITO}+"."{DIGITO}* {
    if(comment == 0){
        printf( "Valor real: ,%s, ,%zu, (%g) Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),atof( yytext ),row,col );
    }
    col += strlen(yytext);
}


"\""({TEXTO}|.)*"\"" {
    if(comment == 0){
        printf( "Uma String: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}



"(" {
    if(comment == 0){
        printf( "Abertura de Parenteses: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

")" {
    if(comment == 0){
        printf( "Fechando Parenteses: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"{" {
    if(comment == 0){
        printf( "Abertura de chaves para listas: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"}" {
    if(comment == 0){
        printf( "Fechamento de chaves para listas: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"[" {
    if(comment == 0){
        printf( "Abertura de colchetes para listas: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"]" {
    if(comment == 0){
        printf( "Fechamento de colchetes para listas: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"=="|"!=" {
    if(comment == 0){
        printf( "Operadores comparativos: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}



"="|"/="|"%="|"+="|"-=" {
    if(comment == 0){
        printf( "Sinais de Atribuição: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"," {
    if(comment == 0){
        printf( "Simbolo para separar argumentos: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}


":" {
    if(comment == 0){
        printf( "Simbolo dar início a uma função ou loop: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"+"|"-"|"*"|"/"|"%" {
    if(comment == 0){
        printf( "Operador Lógico: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}


"#"({TEXTO}|.)* {
    if(comment == 0){
        printf( "Linha de Comentario: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}



return|True|False|print|def|break{
    if(comment == 0){
        printf( "Palavra reservada: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

for|while {
    if(comment == 0){
        printf( "Laço de repetiçao: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

in|not in {
    if(comment == 0){
        printf( "Operador de Sequencia: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

if|else|elif {
    if(comment == 0){
        printf( "Operador condicional: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

{ID} {
    if(comment == 0){
        printf( "Um identificador: ,%s, ,%zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

" " {
    col+=1;
}

\t {
    col+=4;
}

[\n]+ {
    if(comment == 0){
        printf("Quebra de linha\n");
    }
    row+=1;
}

. {
    if(comment == 0){
        printf( "Caracter não reconhecido: %s, len: %zu Linha/Coluna: ( %d / %d )\n",yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

%%



int main( argc, argv )
int argc;
char **argv;
{
	++argv, --argc;
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;

	yylex();
    
	return 0;
}
