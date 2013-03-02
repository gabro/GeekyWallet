%%

start
	: header transactions;

header 
	:
	; //TODO

transactions
	: transactions transaction
	|
	;

transaction
	: date cause payers RIGHT_ARROW beneficiaries options
	;

date
	: DATE
	|
	;

cause
	: description COLON
	| 
	;

description
	: description ID
	| description TAG
	| ID
	| TAG
	;

payers
	: payers payer
	| payer
	;

payer
	: NAME NUMBER
	;

beneficiaries
	: beneficiaries beneficiary
	|  
	;

beneficiary
	: NAME amount

amount
	: modifier NUMBER
	| NUMBER
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