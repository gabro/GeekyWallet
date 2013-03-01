alpha						[a-zA-Z]
digit						[0-9]
non_zero_digit				[1-9]
date						{digit}{4}-{digit}{2}-{digit}{2}

%%
\n 							return 'NEW_LINE';
"//".*
"->"						return 'RIGHT_ARROW';
"<-"						return 'LEFT_ARROW';
{non_zero_digit}{digit}*	return 'NUMBER';
"0"							return 'NUMBER';
"+"							return 'PLUS';
"-"							return 'MINUS';
"*"							return 'MULTIPLY';
"/"							return 'SLASH';
"$"							return 'DOLLAR';
"@"{alpha}+					return 'COMMAND';
"#"{alpha}+					return 'TAG';
":"							return 'COLON';
"  "						return 'TAB';
"	"						return 'TAB';
"("                         return 'LPAREN';
")"                         return 'RPAREN';
"!"                         return 'EXCLAMATION';
"."                         return 'DOT';
\s+							/* ignore whitespaces */
<<EOF>>                     return 'ENDOFFILE';