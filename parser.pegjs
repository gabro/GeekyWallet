{
   var depth = 0;
   var indent;
}

start
	= h:header newline+ tt:transactions EOF { 
		return {header: h, transactions:tt};
	}

header
	= people

people
        = "@people" people_list

people_list
        = pp:(_ p:name {return p;})+ { return {people: pp}; }

name
	= name:[a-zA-Z]+ { return name.join(""); }

transactions
		=	t:(transaction_element) newline+ tt:transactions {return t.concat(tt);} /
			t:(transaction_element) { return t; }/
			"" { return []; }

transaction_element
		= d:INDENT t:(l:transaction_line {return [l];} /
		  			  b:block { return b; }) {
			return t;
		}

block
		= block_header newline+ transactions

block_header
        = command ("," _ command)*

command
        = group_command /
          date_command  /
          tag_command   /
          currency_command

group_command
        = "@group" people_list

date_command
        = "@date" _ date

tag_command
        = "@tag" tag_list

tag_list
        = (_ tag)+

currency_command
        = "@currency" _ number

transaction_line
	= date:(d:date _ {return d;})? desc:(d:description ":" _ { return d; })? p:payers " -> " b:beneficiaries opt:(_ o:option {return o;})? {
            return {
                date   : date,
                desc   : desc,
                payers : p,
                beneficiaries : b,
                options : opt,  
                
            }
        }

date
	= year:([0-9][0-9][0-9][0-9])"-"month:([0-9][0-9])"-"day:([0-9][0-9]) {
            return new Date(year.join(""), month.join(""), day.join(""));
        }

description
	= w:(word / tag) others:(_ w_n:(word / tag) { return w_n; } )* {
            var desc = w;
            if(others.length > 0) {
                desc = w + " " + others.join(" ");
            }
            return desc;
        } 

word
	= word:[a-zA-Z-_]+ { return word.join(""); }

tag
        = t:("#" word) { return t.join(""); }

payers
        = p:payer others:(_ p_n:payer { return p_n; })* {
            return [p].concat(others);
        }

payer
	= n:name _ e:expr { return {name : n, payed: e}; }

beneficiaries
        = b:beneficiary others:(_ b_n:beneficiary { return b_n; })* {
            return [b].concat(others);
        } /
        "" { return []; }

beneficiary
	=  n:name _ m:modifier a:expr {
              return {
                     name : n,
                     amount : a,
                     modifier : m
              };
          } /
          n:name _ a:expr {
              return {
                     name : n,
                     amount : a,
              };
          } /
          n:name {
              return {
                  name : n
              };
          }          
          

modifier
        = "+" / "-" / "*"

option
	= "..." { return "group"; } /
          "$"+ { return "split"; }

expr
	= res:sum { return res; }

sum
	= t:term others:(t_n:(("+"/"-") term) { return parseFloat(t_n.join("")); })* {
            var sum = t;
            var length = others.length;
            for (var i = 0; i < length; i++) {
                sum += others[i];
            }
            return sum;
          }



term
	= f:factor others:("*" f_n:factor { return f_n; })* {
            var prod = f;
            var length = others.length;
            if (length > 0) {
                for (var i = 0; i < length; i++) {
                    prod *= others[i];
                }
            }
            return prod;
        }

factor 
	= number /
          "(" e:expr ")" { return e; }

float
        = n:((integer)? "." integer) { return parseFloat(n.join("")); }

integer
        = n:[0-9]+ { return parseInt(n.join("")); }

number
        = float / integer 

_ = whitespace+

whitespace
        = " " / "\t"

INDENT
        = t:(" "* / "\t"*) {
        	if (t.length == 0) {
        		depth = 0;
        		return depth;
        	}
        	if (indent === undefined) {
        		indent = t.join("");
        	} else {
        		valid = new RegExp("^"+indent+"*$");
        		if(!valid.test(t.join("")))
	     			throw new Error ("Wrong indentation at line "+line);
        	}
         	depth = t.length / indent.length;
        	return depth;
        }

newline
        = "\n" { return "newline"; }

EOF =
   !.