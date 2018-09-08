bison -d sintax.y
flex lexico.l
gcc lex.yy.c sintax.tab.c -o analizador -lfl