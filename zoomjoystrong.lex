%{	
	/*****************************************************************
	* This file will will check the syntax of the language return the
	* correct tokens
	*
	* @author Cody Chinn
	* @version March 2018
	*****************************************************************/
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

%%

(end)								{yylval.str = strdup(yytext); return END;}
\;									{return END_STATEMENT;}
(point)							{yylval.str = strdup(yytext); return POINT;}
(line)							{yylval.str = strdup(yytext); return LINE;}
(circle)						{yylval.str = strdup(yytext); return CIRCLE;}
(rectangle)					{yylval.str = strdup(yytext); return RECTANGLE;}
(set_color)					{yylval.str = strdup(yytext); return SET_COLOR;}
[0-9]+						{yylval.i = atoi(yytext); return INT;}
[0-9]+\.[0-9]+		{return FLOAT;}
[ \t\n]						;
.									;

%%
