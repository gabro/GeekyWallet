ALPHA						[a-zA-Z]
DIGIT						[0-9]
NON_ZERO_DIGIT				[1-9]
NUMBER     					{NON_ZERO_DIGIT}{DIGIT}*|"0"
DATE						{DIGIT}{4}"-"{DIGIT}{2}"-"{DIGIT}{2}
ID          				[a-zA-Z0-9_]+

%%

\/\/.*               		return; /* ignore comment */
"/*"(.|\n|\r)*?"*/"  		return; /* ignore multiline comment */

\n+ 						return 'NEW_LINE';
"->"						return 'RIGHT_ARROW';
"<-"						return 'LEFT_ARROW';
{DATE}						return 'DATE';
"+"							return 'PLUS';
"-"							return 'MINUS';
"*"							return 'MULTIPLY';
"/"							return 'SLASH';
"$"							return 'DOLLAR';
"@people"					return 'PEOPLE';
"@"{ALPHA}+					return 'COMMAND';
"#"{ID}						return 'TAG';
":"							return 'COLON';
"\t"						return 'TAB';
"("                         return 'LPAREN';
")"                         return 'RPAREN';
"!"                         return 'EXCLAMATION';
"..."						return 'ELLIPSIS';
"."                         return 'DOT';
\s+							return; /* ignore whitespaces */

{NUMBER}?"."{DIGIT}+		return 'NUMBER';
{NUMBER}					return 'NUMBER';
{ID}						return 'ID';
<<EOF>>                     return 'EOF';