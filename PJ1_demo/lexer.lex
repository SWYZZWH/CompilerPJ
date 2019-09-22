%{
#include "lexer.h"
%}
%option     nounput
%option     noyywrap

DIGIT       [0-9]
INTEGER     {DIGIT}+
REAL        {DIGIT}+\.{DIGIT}* 
BOOLEAN     TRUE|FALSE
LETTER      [A-Za-z]
WS          [ \t\n]+
RESERVED    AND|ELSIF|LOOP|PROGRAM|VAR|ARRAY|END|MOD|READ|WHILE|BEGIN|EXIT|NOT|RECORD|WRITE|BY|FOR|OF|RETURN|DIV|IF|OR|THEN|DO|IN|OUT|TO|ELSE|IS|PROCEDURE|TYPE
ID          {LETTER}({LETTER}|{DIGIT})*
STRING      \"[^\n\"]*\"
OPERATOR    \:=|\+|\-|\*|\/|<|<=|>|>=|=|<>
DELIMITER   \:|;|,|'.'|\(|\)|\[|\]|\{|\}|\[<|>\]|\\
COMMENT     \(\*[^\*]*[\*]+([^\*\)][^\*]*[\*]+)*\)
TAB         \t
ENTER       \n
ERRORSTR    ^\"(.*)([\"]+)(.*)\"$
HALFSTR     \"([^\n\"]*)
HALFCOMMENT (\(\*)|(\*\))
ERROR       .

%%
{WS}        return WS; // skip blanks and tabs //  //
<<EOF>>     return T_EOF;
{INTEGER}   return INTEGER;
{REAL}	    return REAL;
{BOOLEAN}   return BOOLEAN;
{RESERVED}  return RESERVED;
{ID}        return ID;
{STRING}    return STRING;
{ERRORSTR}  return ERROR;
{OPERATOR}  return OPERATOR;
{DELIMITER} return DELIMITER;
{HALFSTR}   return HALFSTR;
{COMMENT}   return COMMENT;
{HALFCOMMENT} return HALFCOMMENT;
{TAB}       return TAB;
{ENTER}     return ENTER;
{ERROR}     return ERROR;
%%
