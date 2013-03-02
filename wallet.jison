%%

start
	: header new_line transactions EOF;

new_line
	: new_line NEW_LINE
	| NEW_LINE
	;

header 
	: people
	;

people
	: PEOPLE people_list
	;

people_list
	: people_list NAME
	| NAME
	;

transactions
	: transaction new_line transactions
	| transaction
	| 
	;

transaction
	: DATE description COLON payers RIGHT_ARROW beneficiaries options
	| description COLON payers RIGHT_ARROW beneficiaries options
	| DATE payers RIGHT_ARROW beneficiaries options
	| payers RIGHT_ARROW beneficiaries options
	;

description
	: description word
	| word
	;

word
	: ID
	| TAG
	| NAME
	;

payers
	: payers payer
	| payer
	;

payer
	: NAME expr
	;

beneficiaries
	: beneficiaries beneficiary
	|  
	;

beneficiary
	: NAME amount
	;

amount
	: modifier expr
	| expr
	| 
	;

modifiers
	: PLUS
	| MINUS
	| MULTIPLY
	;

options
	: ELLIPSIS
	| DOLLAR DOLLAR
	;

expr
	: term PLUS expr
	| term
	;

term
	: factor MULTIPLY term
	| factor
	;

factor
	: LPAREN expr RPAREN
	| NUMBER
	;