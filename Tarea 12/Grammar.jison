%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'number'
([a-zA-Z]|_)[a-zA-Z0-9_]*	return 'id';
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"("                   return '('
")"                   return ')'
// EOF means "end of file"
<<EOF>>               return 'EOF'
// any other characters will throw an error
.                     return 'INVALID'

/lex

%{
    const app = require('./Actions').app;
%}

%start S

%% 

S: E EOF { let result = app.traduct($1); return result }
;

E: E '+' T { $$ = app.node('+', $1, $3) }
 | E '-' T { $$ = app.node('-', $1, $3) }
 | T { $$ = $1 }
;

T: T '*' F { $$ = app.node('*', $1, $3) }
 | T '/' F { $$ = app.node('/', $1, $3) }
 | F { $$ = $1 }
;

F: '(' E ')' { $$ = $2; }
 | id { $$ = app.node($1,null, null); }
 | number { $$ = app.node($1,null,null); }
;
