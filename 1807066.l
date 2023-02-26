
%{
	#include<stdio.h>
	#include <string.h>
	#include "1807066.tab.h"
	#include<stdlib.h>
%}


identifiers "argho"[a-zA-Z]([a-zA-Z0-9])*
integer (-|+)?[0-9]+
float [+-]?[0-9]+[.][0-9]+|[+-]?[.][0-9]+|[1-9]+e[+-][0-9]+
double [+-]?[0-9]+[.][0-9]+{6,12}|[+-]?[.][0-9]+|[1-9]+e[+-][0-9]+{6,12}
char [A-Za-z]+
multiple_line_comment [ ]*[#][*a][a-zA-Z0-9!@#*(){}_+-,.:\|?><\n\t ]*[*][#]
single_line_comment [#].*



%%

"asol "[A-Za-z]+	{ return START; }
{single_line_comment} {
	printf("single line comment\n");

}
{multiple_line_comment} {
	printf("multiple_line_comment\n");
}

"++"    return inc;
"--"	return dec;
"!"	    return not;
"{{"	  return LB; 
"}}"	   return RB; 
"("	     return LP; 
")"	     return RP; 
","	     return CM; 
";"	     return SM;
":="		 return ASSIGN; 
">"	     return GT; 
"<"	     return LT; 
":"      return COL;

"integer"	 return INT; 
"float"	 return FLOAT; 
"double"	return DOUBLE;
"character"	 return CHAR; 

"interrupt"       return BREAK;     
"option"       return CASE;      
"Switch"       return SWITCH;	
"default"       return DEFAULT; 	

"forLoop"    return FOR;
"whileLoop"  return WHILE;
"IF"		 return IF;
"else"		 return ELSE;
"esIF"	 return ELIF; 
"function"	{return func;}

"PLUS"	 return PLUS;
"MINUS"	 return MINUS; 
"MUL"	 return MULT; 
"DIV"	 return DIV; 
"power"	 return POW; 
"FACTORIAL"	 return factorial; 

"lcm" return LCM;
"gcd" return GCD;
"max" return MAX;
"min" return MIN;
"sum" return SUM;
"squareRoot" return SQRT;
"isPRIME" return isPRIME;
"sin" return SIN;
"cos" return COS;
"tan" return TAN;
"MOD" return MOD;
[0-9]+	{ 
		yylval.number = atoi(yytext);
		return NUM;
	}
{identifiers} {
	 yylval.string=strdup(yytext);
	 return VAR;
	}




[ \t\n]*	

.	{
		yyerror("Unknown Character.\n");
	}
%%

/* user subroutines */

int main()
{
	yyin = freopen("in.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();
	
}