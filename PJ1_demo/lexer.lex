%{
#include "lexer.h"
%}
%option     nounput
%option     noyywrap

DIGIT       [0-9]
INTEGER     \-?{DIGIT}+
REAL        \-?{DIGIT}+\.{DIGIT}* 
LETTER      [A-Za-z]
WS          [ \t\n]+
RESERVED    AND|ELSIF|LOOP|PROGRAM|VAR|ARRAY|END|MOD|READ|WHILE|BEGIN|EXIT|NOT|RECORD|WRITE|BY|FOR|OF|RETURN|DIV|IF|OR|THEN|DO|IN|OUT|TO|ELSE|IS|PROCEDURE
ID          {LETTER}({LETTER}|{DIGIT})*
STRING      \"[^\"]*\"
ERRORSTR    ^\"(.*)([\"]+)(.*)\"$

OPERATOR    \:=|\+|\-|\*|\/|<|<=|>|>=|=|<>
DELIMITER   \:|;|,|'.'|\(|\)|\[|\]|\{|\}|\[<|>\]|\\
ERROR       .
%%
{WS}        return WS; // skip blanks and tabs
<<EOF>>     return T_EOF;
{INTEGER}   return INTEGER;
{REAL}	    return REAL;
{RESERVED}  return RESERVED;
{ID}        return ID;
{STRING}    return STRING;
{ERRORSTR}  return ERROR;
{OPERATOR}  return OPERATOR;
{DELIMITER} return DELIMITER;
{ERROR}     return ERROR;
%%
