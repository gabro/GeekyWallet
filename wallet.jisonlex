ALPHA						[a-zA-Z]
DIGIT						[0-9]
NON_ZERO_DIGIT				[1-9]
DATE						{DIGIT}{4}-{DIGIT}{2}-{DIGIT}{2}
ID          				[a-zA-Z0-9_]+
NAME						{ALPHA}+

%%
\n 							return 'NEW_LINE';
"//".*
"->"						return 'RIGHT_ARROW';
"<-"						return 'LEFT_ARROW';
{NON_ZERO_DIGIT}{digit}*	return 'NUMBER';
"0"							return 'NUMBER';
"+"							return 'PLUS';
"-"							return 'MINUS';
"*"							return 'MULTIPLY';
"/"							return 'SLASH';
"$"							return 'DOLLAR';
"@"{ALPHA}+					return 'COMMAND';
"#"{ID}						return 'TAG';
":"							return 'COLON';
"  "						return 'TAB';
"	"						return 'TAB';
"("                         return 'LPAREN';
")"                         return 'RPAREN';
"!"                         return 'EXCLAMATION';
"."                         return 'DOT';
"..."						return 'ELLIPSIS';
\s+							/* ignore whitespaces */
{ID}						return 'ID'
<<EOF>>                     return 'ENDOFFILE';