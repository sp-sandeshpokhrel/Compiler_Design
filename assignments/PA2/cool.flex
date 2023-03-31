/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* This is a hack to
 * a) satisfy the cool compiler which expects yylex to be named cool_yylex (see below)
 * b) satisfy libfl > 2.5.39 which expects a yylex symbol
 * c) fix mangling errors of yylex when compiled with a c++ compiler
 * d) be as non-invasive as possible to the existing assignment code
 */
extern int cool_yylex();
extern "C" {
  int (&yylex) (void) = cool_yylex;
}

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */


%}


/*
 * Define names for regular expressions here.
 */

DIGIT         [0-9]
LOWER_LETTER  [a-z]
UPPER_LETTER  [A-Z]
TYPEID        {UPPER_LETTER}({DIGIT}|{LOWER_LETTER}|{UPPER_LETTER}|_)*
OBJID         {LOWER_LETTER}({DIGIT}|{LOWER_LETTER}|{UPPER_LETTER}|_)*
SPECIAL       (self|SELF_TYPE)
INTEGERS      ?(-|+){DIGIT}+
CLASS         (?i:class)


%%
{CLASS}       return (CLASS);
 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */


 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


%%
