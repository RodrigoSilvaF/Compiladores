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
HEX      [a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]
TEXTO    [A-Za-z0-9][A-Za-z0-9]*
ARQUIVO  [A-Za-z0-9]*.[A-Za-z0-9]*



%%

{DIGITO}+ {
    if(comment == 0){
        printf( "Valor inteiro: ,%s, Tamanho: %zu, (%d) Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),atoi( yytext ),row,col);
    }
    col += strlen(yytext);
}

{DIGITO}+"."{DIGITO}* {
    if(comment == 0){
        printf( "Valor real: ,%s, Tamanho: %zu, (%g) Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),atof( yytext ),row,col );
    }
    col += strlen(yytext);
}


"\""({TEXTO}|.)*"\"" {
    if(comment == 0){
        printf( "Uma String: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}



"(" {
    if(comment == 0){
        printf( "Abertura de Parenteses: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

")" {
    if(comment == 0){
        printf( "Fechando Parenteses: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"{" {
    if(comment == 0){
        printf( "Abertura de chaves para listas: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"}" {
    if(comment == 0){
        printf( "Fechamento de chaves para listas: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"[" {
    if(comment == 0){
        printf( "Abertura de colchetes para listas: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"]" {
    if(comment == 0){
        printf( "Fechamento de colchetes para listas: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"=="|"!=" {
    if(comment == 0){
        printf( "Operadores comparativos: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}



"="|"/="|"%="|"+="|"-=" {
    if(comment == 0){
        printf( "Sinais de Atribuição: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"," {
    if(comment == 0){
        printf( "Simbolo para separar argumentos: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}


":" {
    if(comment == 0){
        printf( "Simbolo dar início a uma função: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

"+"|"-"|"*"|"/"|"%" {
    if(comment == 0){
        printf( "Operador Lógico: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}


"#"({TEXTO}|.)* {
    if(comment == 0){
        printf( "Linha de Comentario: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}


return|def|true|false|print|break {
    if(comment == 0){
        printf( "Palavra reservada: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

for|while {
    if(comment == 0){
        printf( "Laço de repetiçao: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

in|notin {
    if(comment == 0){
        printf( "Operador de Sequencia: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

if|else|elif {
    if(comment == 0){
        printf( "Operador condicional: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
    }
    col += strlen(yytext);
}

{ID} {
    if(comment == 0){
        printf( "Um identificador: ,%s, Tamanho: %zu, Linha/Coluna: ( %d / %d )\n", yytext,strlen(yytext),row,col );
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
