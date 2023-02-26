%{
	#include<stdio.h>
	#include <math.h>
	typedef struct st {
    	char *str;
    	int n;
	}child;
	child var_name[1000],var_value[1000];
	void add(child *p, char *s, int n);
    int val;
    int flag=0;
	int cnt=1,cnt2=1,cnt3=0; 	
%}
%union 
{
        int number;
        char *string;
}
%token <number> NUM
%token <string> VAR 
%token <string> IF ELIF ELSE START INT FLOAT DOUBLE CHAR MOD LP RP LB RB CM SM PLUS MINUS MULT DIV POW FACT LCM GCD MAX MIN SQRT isPRIME factorial SIN COS TAN SUM ASSIGN FOR COL WHILE BREAK COLON DEFAULT CASE SWITCH inc dec not func LOGIC
%type <string> statement
%type <number> expression 
%type <number> Svalue
%nonassoc IFX
%nonassoc ELIFX
%nonassoc ELSE
%left LT GT
%left PLUS MINUS
%left MULT DIV
%left FACT
%left POW

%%

program: START LP RP LB body RB { printf("\n  ..................Compiler Project Done........... :D\n"); }
	 ;

body:

	| body statement
	
	| declare
	;

declare:	TYPE ID1 SM	{ printf("\nVariable  declaration Successful\n"); }
   
			;
			
TYPE : INT

     | FLOAT

     | CHAR
     ;

ID1  : ID1 CM VAR	{
						if(find($3))
						{
							printf("\nYour given %s is already declared\n", $3 );
						}
						else
						{
							add(&var_name[cnt],$3, cnt);
							cnt++;
							
						}
			}

     |VAR	{
				if(find($1))
				{
					printf("\nYour given %s is already declared\n", $1 );
				}
				else
				{
					add(&var_name[cnt],$1, cnt);
							cnt++;
				}
			}
     ;

statement: SM

	| expression SM 			{ printf("\nExpression Output = %d\n", ($1)); }

    | VAR ASSIGN expression SM{
							if(find($1)){
								int i = find2($1);
								if (!i){
									add(&var_value[cnt3], $1, $3);
									cnt3++;
								}
								var_value[i].n = $3;
								printf("\n%s := %d\t\n",$1,$3);
							}
							else {
								printf("\nYour given %s is NOT declared before\n",$1);
							}
							
						}

    | LCM LP NUM CM NUM RP {
                            int a=$3;
                            int b=$5;
                            int c=a;
                            int d=b;
                            while(b)
                            {
                                a=a%b;
                                int t=a;
                                a=b;
                                b=t;
                            }
                            printf("\nLCM = %d\n",((c*d)/a));
    }
    
    | GCD LP NUM CM NUM RP {
                            int a=$3;
                            int b=$5;
                            while(b){
                                a=a%b;
                                int t=a;
                                a=b;
                                b=t;
                            }
                            printf("GCD = %d\n",a);

    }

    |MAX LP NUM CM NUM RP {
                            int a=$3;
                            int b=$5;
                            int t;
                            if(a>b)
                                t=a;
                            else
                                t=b;
                            printf("MAX = %d\n",t);
    }
    | MIN LP NUM CM NUM RP {
                            int a=$3;
                            int b=$5;
                            int t;
                            if(a<b)
                                t=a;
                            else
                                t=b;
                            printf("MIN = %d\n",t);
    }
    | SQRT LP NUM RP {
                    int a=$3;
                    double i=sqrt(a);
                    printf("SQUAREROOT of %d = %lf\n",$3,i)
    }
    |isPRIME LP NUM RP{
                    int n=$3, i, BOOL = 0;
                    if (n == 0 || n == 1)
                        BOOL = 1;

                    for (i = 2; i <= n / 2; ++i) 
                    {
                        if (n % i == 0) 
                        {
                            BOOL = 1;
                            break;
                        }
                    }
                    if (BOOL == 0)
                        printf("'%d' is a Prime number\n", n);
                    else
                        printf("'%d' is not a Prime number\n", n);
    }

	|factorial LP NUM RP{
					int tmp=1 ,i;
						for(i=$3;i>0;i--)
						{
							tmp*=i;
						}
						printf("Factorial of %d = %d",$3,tmp);
	}
	| SIN LP NUM RP{
		double x, ret, val;
			x = $3;
   		val = 3.1416 / 180.0;
   		ret = sin(x*val);
   		printf("\n\nsine of %lf is %lf", x, ret);

	}
	| COS LP NUM RP{
		double x, ret, val;
			x = $3;
   		val = 3.1416 / 180.0;
   		ret = cos(x*val);
   		printf("\ncosine of %lf is %lf", x, ret);

	}
	| TAN LP NUM RP{
		double x, ret, val;
			x = $3;
   		val = 3.1416 / 180.0;
   		ret = tan(x*val);
   		printf("\ntangent of %lf is %lf\n\n", x, ret);

	}

	|SUM LP NUM CM NUM RP{
		int number1=$3, number2=$5, sum;
        sum = number1 + number2;      
    	printf("sum of (%d + %d) = %d\n\n", number1, number2, sum);
	}
	| MOD LP NUM CM NUM RP{
		int a=$3,b=$5;
		int ans=a%b;
		printf("\nmod (%d,%d) = %d\n",a,b,ans);
	}

    | NUM inc         { $$=$1+1; printf("Incement result: %d\n",$$);}

	| NUM dec         { $$=$1-1; printf("Decement result: %d\n",$$);}

	| NUM not {
						if($2 != 0)
						{
							$$ = 0; printf("Not result: %d\n",$$);
						}
						else{
							$$ = 1 ; printf("Not result: %d\n",$$);
						}
					}
    

	| IF COL LP expression RP LB expression SM RB %prec IFX {
								if($4)
								{
									printf("\nIF segment output: %d\n",($7));
								}
								else
								{
									printf("\nIF segment Not executed\n");
								}
							}

	| IF COL LP expression RP LB expression SM RB ELSE COL LB expression SM RB {
								 	if($4)
									{
										printf("\nIF segment output: %d\n",$7);
									}
									else
									{
										printf("\nELSE segment output: %d\n",$13);
									}
								   }
	| IF COL LP expression RP LB IF COL LP expression RP LB expression SM RB ELSE COL LB expression SM RB expression SM RB ELSE COL LB expression SM RB %prec IFX {
								 	if($4)
									{
										if($10)
											printf("\ninnerIF segment output: %d\n",$13);
										else
											printf("\ninnerELSE segment output: %d\n",$19);
										printf("\nouterIF segment output: %d\n",$22);
									}
									else
									{
										printf("\nouterELSE segment output: %d\n",$28);
									}
								   }
	| IF COL LP expression RP LB expression SM RB ELIF COL LP expression RP LB expression SM RB ELSE COL LB expression SM RB {
								 	if($4)
									{
										printf("\nIF segment output: %d\n",$7);
									}
									else if($13)
									{
										printf("\nelseIF segment output: %d\n",$16);
									}
									else
									{
										printf("\nELSE segment output: %d\n",$22);
									}
								   }							   
	| FOR COL LP NUM SM NUM SM NUM RP LB expression RB     {
        printf("\n\nforLoop index: ");
	   int i=0;
	   for(i=$4;i<$6;i=i+$8)
       {
	        printf("%d ",i);
	   }
       printf("\n");
       printf("output of FORLoop = %d\n",$11);
       printf("For Loop DONE\n");
	}
	| WHILE COL LP NUM GT NUM RP LB expression RB   {
										int i;
										printf("\nwhileLoop index: ");
										for(i=$4;i<$6;i++)
										{
											printf("%d ",i);
										}
										printf("\n");
                                        printf("output of whileLoop = %d\n",$9);
										printf("While Loop DONE\n\n\n");

	}
	|func COL TYPE LP RP LB statement RB{
								printf("\n\nFunction Declared\n\n");
							}

    | SWITCH COL LP Svalue RP LB switch_body RB    {printf("Switch DONE\n\n");} 
	;

	switch_body : opt   
				| opt default 
				;

	opt:
		| opt case     
		;

	case: CASE NUM COL expression SM   {
						if(val==$2){
							  flag=1;
							  printf("\nResult =  %d\n",$4);
						}
					}
				 ;

	default: DEFAULT COL expression SM    {
						if(flag!=1){
							printf("\nResult =  %d\n",$3);
						}
						flag=0;
					}
    
	;    
Svalue: NUM				{ $$ = $1; val = $$;	}
	
expression: NUM				{ $$ = $1; 	}

	| VAR				{ 
                            $$ = find2($1); 
                            printf("Variable value: %d",$$);
                        }

	| expression PLUS expression	{$$=$1+$3;}
	| expression MINUS expression	{$$=$1-$3;}
	| expression MULT expression	{$$=$1*$3;}
	| expression DIV expression	{ 	
                        if($3) 
				  		{
				     		$$=$1/$3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by ZERO is not possible\t");
				  		} 	
				    	}
	| expression POW expression { $$ = pow($1,$3); }	
	| expression LT expression	{ $$ = $1 < $3; }
	| expression GT expression	{ $$ = $1 > $3; }
	| LP expression RP		{ $$ = $2;	}
	
	

    
	;


%%

void add(child *c, char *s, int n)
{
  c->str = s;
  c->n = n;
}
int find(char *c)
{
    int i = 1;
    char *tmp = var_name[i].str;
    while(tmp) 
    {
        if (strcmp(tmp, c) == 0)
        {
            return var_name[i].n;
        }
        tmp = var_name[++i].str;
    }
    return 0;
}
int find2(char *c)
{
    int i = 1;
    char *tmp = var_value[i].str;
    while (tmp) 
    {
        if (strcmp(tmp, c) == 0)
        {
            return i;
        }   
        tmp = var_value[++i].str;
    }
    return 0;
}


int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}