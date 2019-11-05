%{
#include <iostream>
#include "lex.c"
// #include "tree.h"
using namespace std;

// node_t* root;
%}

%union {
    double val;
}

%token <val> INTEGER REAL
%token ADD SUB MUL DIV LPAREN RPAREN EOL

%type <val> exp
%type <val> factor
%type <val> term

%%
calc:
  calc exp EOL { cout << "= " << $2 << endl; }
  ;
exp:
  factor
  | exp ADD factor { $$ = $1 + $3; }
  | exp SUB factor { $$ = $1 - $3; }
  ;
factor:
  term
  | factor MUL term { $$ = $1 * $3; }
  | factor DIV term { $$ = $1 / $3; }
  ;
term:
  number
  | LPAREN number RPAREN { $$ = $2; }
  ;
number:
  INTEGER
  | REAL
  ;
%%
