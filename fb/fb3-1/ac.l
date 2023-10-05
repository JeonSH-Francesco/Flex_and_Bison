/* recognize tokens for the calculator */
%option noyywrap nodefault yylineno
%{
# include "fb3-1.h"
# include "ac.tab.h"
%}
/* float exponent */
EXP ([Ee][-+]?[0-9]+) //E,e 지수부분의 시작
//[-+]? : 지수 부분의 부호 : -, + 기호가 있을 수도 있고 없을 수도 있고,
//[0-9]+ : 지수 부분의 실제 숫자를 나타냄. 하나 이상의 숫자가 이어진다.
//예)1.2E+3 3.14e-2와 같은 형식의 문자열 인식 가능
%%
"+" |
"-" |
"*" |
"/" |
"|" |
"(" |
")" { return yytext[0]; }
[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER; }

\n { return EOL; }
"//".*
[ \t] { /* ignore whitespace */ }
. { yyerror("Mystery character %c\n", *yytext); }
%%
/* ingnore white space의 의미는 No ACtion하겠다는 의미*/
