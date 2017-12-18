grammar CPP_Grammar;

@header{

}

@parsser::members{
	/*var obfuscation mechanisms*/
	Map<String, String> var_obf = new HashMap<String,String>();

	int new_name_symbols_count = 4;
	Set<String> names_set = new HashSet<String>();
	String gen_unique_name (){};


	String obfus_var(String var){};
	String gen_var(){};
	String get_gen_var(){};

	String get_random_str(){};

}

pure_code returns [String str]	: frst = include_part scnd = (pure_code)?	
									{$str = $frst.str + $scnd.str;}
								| frst = function_part scnd = (pure_code)?	
									{$str = $frst.str + $scnd.str;}
								;


include_part returns [String str]	: i=INCLUDE  LTPAREN id=STABLENAME RTPAREN	
										{$str = $i.text + + "<" + $id.text + ">";}
									;

function_part returns [String str] @init{$argsStr = "";}	:  typeName=STABLENAME funName=STABLENAME LPAREN (type=STABLENAME var=UNSTABLENAME c=(COMMA)?{$argsStr+=$type.text + " " + $var.str + c.text;})* RPAREN  LFPAREN fb=function_body RFPAREN 
																{$str = $typeName.str + " " + $funName.str + "("+$argsStr+")" + "{"+$fb.str+"}";}
															;

function_body returns [String str] @init{$str="";}	: (op = operation{$str += get_random_str() + $op.str + '\n';})*
													;

operation returns [String str]	: vd=var_declaraion SEMICOLON
									{$str = $vd.str + ";";}
								| va=var_assignment SEMICOLON
									{$str = $va.str + ";";}
								| fi=function_invoking SEMICOLON
									{$str = $fi.str + ";";}
								| is=if_statement
									{$str = $is.str;}
								| fs=for_statement
									{$str = $fs.str;}
								| ws=while_statement
									{$str = $ws.str;}
								;

var_declaraion returns [String str] @init{$argsStr = ""}	: typeName=STABLENAME (varName=UNSTABLENAME {$argsStr+=$varName.str;} | varAssig=var_assignment {$argsStr+=$varAssig;}) 
															(COMMA varName=UNSTABLENAME {$argsStr+=(" ," + $varName.str);} | varAssig=var_assignment {$argsStr+=(" ,"+$varAssig);})* SEMICOLON
																{$str = $typeName.str + " " + $argsStr + ";";}
															;

var_assignment returns [String str]	: varName=UNSTABLENAME ASSIGMENT dc=data_container {$str = $varName.str + " = " + $dc.str;}
									;

data_container returns [String str]	: fi=function_invoking 
										{$str+=fi.str;} 
									| varName=UNSTABLENAME
										{$str+=$varName.str;}
									| val=VALUE
										{$str+=$val.text;}

function_invoking returns [String str] @init{$argsStr = "";}	: funName=STABLENAME LPAREN (dc=data_container {$argsStr+=$dc.str;} /*varName=UNSTABLENAME c=(COMMA)?{$argsStr+=$varName.str+ " "+c.text;}|val=value c=(COMMA)?{$argsStr+=$val.str+ " "+c.text;}*/)* RPAREN
																	{$str=$funName.str + " (" + $argsStr + ")"; }
																| dc1=data_container ARITH_SIGN dc2=data_container
																	{$str=$dc1.str + ARITH_SIGN.text + $dc2.str}
																;

if_statement returns [String str]	: IF LPAREN condition RPAREN LFPAREN function_body RFPAREN{$str="if (" + condition.str + "){" + function_body.str + "}";} (ELSE LFPAREN function_body RFPAREN {$str+="else {"+condition.str+"}";})?
									;

for_statement returns [String str] @init{$argsStr=""}	: FOR LPAREN (vd=var_declaraion{$argsStr+=vd.str;}|vs=var_assignment{$argsStr+=vs.str;}) SEMICOLON con=condition SEMICOLON vs1=var_assignment RPAREN LFPAREN fb=function_body RFPAREN
															{$str = "for (" + argsStr + "; " + con.str + "; " + vs1.str + "){" + fb.str+ "}"}
														;

while_statement returns [String str]	: WHILE LPAREN con=condition RPAREN LFPAREN fb=function_body RFPAREN 
											{$str= "while (" + $con.str + "){" + $fb.str + "}";}
										;


condition returns [String str]	: LPAREN c=condition RPAREN
									{$str= "("+ $c.str + ")";}
								| c1=condition cs=COND_SIGN c2=condition
									{$str= $c1.str + $cs.text + $c2.str}
								| fi=function_invoking
									{$str= $fi.str}
								| dc1=data_container CHECK_SIGN dc2=data_container
									{$str = $dc1.str + CHECK_SIGN.text + $dc2.str;}
								;

UNSTABLENAME returns [String str] 	: name = STABLENAME
										{$str = obfus_var(name.text);}
									;


CHECK_SIGN	: "<"|">"|"<="|">="|"=="|"!="
			;

ARITH_SIGN	: "+"|"-"|"*"|"/"|"%"
			;

COND_SIGN	: "&&"|"||"
			;

VALUE 	: "\"" .*? "\""
		| "\'" .? "\'"
		| [0-9]+
		;

STABLENAME	: [a-zA-Z][a-zA-Z0-9]*
			;

LPAREN 	: "("
		;

RPAREN 	: ")"
		;

LFPAREN	: "{"
		;

RFPAREN	: "}"
		;

LTPAREN : "<"
		;

RTPAREN : ">"
		;

INCLUDE : "include"
		;

COMMA	: ","
		;

SEMICOLON	: ";"
			;

IF 	: "if"
	;

FOR : "for"
	;

WHILE 	: "while"
		;

ASSIGMENT 	: "="
			;
"