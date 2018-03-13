%{	
	/*****************************************************************
	* This file will create the tokens for the language zoomjoystrong
	* and then set the rules for the language.
	*
	* @author Cody Chinn
	* @version March 2018
	*****************************************************************/
	#include <stdio.h>
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start drawing

%union { int i; char* str; }

// Define each token
%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT


//Define the types of each token
%type<i> INT
%type<str> POINT
%type<str> LINE
%type<str> CIRCLE
%type<str> RECTANGLE
%type<str> SET_COLOR
%type<str> FLOAT
%type<str> END

// Create all of the rules for the shapes in the language
%%
line: LINE INT INT INT INT END_STATEMENT
		{
			printf("%s %d %d %d %d\n", $1, $2, $3, $4, $5);

			// Error Checking for all four variables
			//(x and y coordinates for each corresponding point)
			if($2 < 0 || $2 > 1024)
				yyerror("Please provide a valid first x coordinate");

			if($3 < 0 || $3 > 768)
				yyerror("Please enter a valid first y coordinate");

			if($4 < 0 || $4 > 1024)
				yyerror("Please enter a valid second x coordinate");

			if($5 < 0 || $5 > 768)
				yyerror("Please enter a valid second y coordinate");

			// Once the variables are checked, run the line command
			line($2, $3, $4, $5);
		}
;

circle: CIRCLE INT INT INT END_STATEMENT
		{
			printf("%s %d %d %d\n", $1, $2, $3, $4);

			// Error checking for the circle coordinates and radius
			if($2 < 0 || $2 > 1024)
				yyerror("Please provide a proper x coordinate for the circle");

			if($3 < 0 || $3 > 768)
				yyerror("Please provide a proper y coordinate for the circle");

			if($4 < 0 || $4 > 768)
				yyerror("Please provide a proper radius for the circle");

			// Draw the circle once the checks are done
			circle($2, $3, $4);
		}
;

point: POINT INT INT END_STATEMENT
		{
			printf("%s %d %d", $1, $2, $3);

			// Check the coordinates to for a valid point
			if($2 < 0 || $2 > 1024)
				yyerror("Please provide a proper x coordinate for the point");

			if($3 < 0 || $3 > 768)
				yyerror("Please provide a proper y coordinate for the point");

			// Put the point on the grid once the variable are checked
			point($2, $3);
		}
;

rectangle: RECTANGLE INT INT INT INT END_STATEMENT
		{
			printf("%s %d %d %d %d\n", $1, $2, $3, $4, $5);

			// Error Checking for all four variables
			//(x and y coordinates for each corresponding point)
			if($2 < 0 || $2 > 1024)
				yyerror("Please provide a valid x coordinate for the rectangle");

			if($3 < 0 || $3 > 768)
				yyerror("Please provide a valid y coordinate for the rectangle");

			if($4 < 0 || $4 > 1024)
				yyerror("Please provide a valid height for the rectangle");

			if($5 < 0 || $5 > 768)
				yyerror("Please provide a valid width for the rectangle");

			// Once the variables are checked, run the line command
			rectangle($2, $3, $4, $5);
		}
;

set_color: SET_COLOR INT INT INT END_STATEMENT
		{
			printf("%s %d %d %d\n", $1, $2, $3, $4);

			// Error Checking for all four variables
			//(x and y coordinates for each corresponding point)
			if($2 < 0 || $2 > 255)
				yyerror("Please provide a valid R value under 255");

			if($3 < 0 || $3 > 255)
				yyerror("Please provide a valid G value under 255");

			if($4 < 0 || $4 > 255)
				yyerror("Please provide a valid B value under 255");

			// Once the variables are checked, run the set_color command
			set_color($2, $3, $4);
		}

;

drawing: line drawing
	| circle drawing
	| point drawing
	| rectangle drawing
	| set_color drawing
	| end
;

end: END END_STATEMENT
	{
		printf("%s\n", $1);
		finish();
	}
;
%%

// Create the drawing and parse the input file
int main(int argc, char** argv){
	printf("\n--------\n");
	setup();
	yyparse();
	return 0;
}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
