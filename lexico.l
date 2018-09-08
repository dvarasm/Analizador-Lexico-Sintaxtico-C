%{
	#include <stdio.h>
	#include "sintax.tab.h"
	int yylineno;
	int linea=1;
	int yylex();
%}

%option yylineno

LIBRERIA stdio.h|math.h|stdlib.h|string.h|ctype.h|time.h|assert.h
ARITMETICO "+"|"-"|"/"
LOGICO & | $
COMPARACION "<="|">="|"=="|"!="|"&&"|"||"
BIT "<<"|"<<="|">>"|">>="|"&"|"&="|"|"|"|="|"^"|"^="
BINARIO [0-1]
DIGITO [0-9]
PALABRA (([a-zA-Z]|{DIGITO})+)
NUMERO {DIGITO}({DIGITO})*

%%
[\t];
[\n]  {linea++;}
"int argc, char *argv[]" {return BMAINARGUMENTO;}
{NUMERO} {return BNUMERO;}
"(" {return BPARIZQ;}
")"	{return BPARDER;}
{ARITMETICO} {return BARITMETICO;}
{LIBRERIA} {return BLIBRERIA;}
".h" {return BEXTENSION;}
">" {return BMAYOR;}
"<" {return BMENOR;}
"'" {return BCOMILLAS;}
"{" {return BLLAIZQ;}
"}" {return BLLADER;}
"[" {return BCORIZQ;}
"]" {return BCORDER;}
"=" {return BIGUAL;}
"*" {return BASTERISCO;}
"++" {return BAUMENTO;}
"--" {return BDISMINUCION;}
"void" {return BVOID;}
"int" {return BINT;}
"char" {return BCHAR;}
"double" {return BDOUBLE;}
"float" {return BFLOAT;}
"long" {return BLONG;}
"short" {return BSHORT;}
"return 0" return BRETURN0;
"include" {return BINCLUDE;}
"define" {return BDFN;}
"if" {return BIF;}
"else" {return BELSE;}
"for" {return BFOR;}
"while" {return BWHILE;}
"do" {return BDO;}
"switch" {return BSWITCH;}
"#" {return (BGATO);}
";" {return (BPUNTOCOMA);}
"main" {return (BMAIN);}
{PALABRA} {return BPALABRA;}
{COMPARACION} {return BCOMPARACION;}
{BIT} {return BBIT;}
","  {return BCM;}
{DIGITO}+"."{DIGITO}+ {return BREAL;}

%%

int main(int argc,char *argv[]){
	if ((yyin = fopen(argv[1], "rt")) == NULL){
  		printf("No se puede abrir el archivo: %s\n", argv[1]);
 	}
 	else{
  		yyparse();
 	}
 	
 	fclose(yyin);
 	return 0;
}

