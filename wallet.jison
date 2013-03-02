%%

start
	: header NEW_LINE transactions EOF;

header 
	: people NEW_LINE
	;

people
	: PEOPLE people_list
	;

people_list
	: people_list ID
	| ID
	;

transactions
	: transaction NEW_LINE transactions
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
	;

payers
	: payers payer
	| payer
	;

payer
	: ID expr
	;

beneficiaries
	: beneficiaries beneficiary
	|  
	;

beneficiary
	: ID amount
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