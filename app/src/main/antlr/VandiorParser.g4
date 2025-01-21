// $antlr-format alignTrailingComments true, columnLimit 150, minEmptyLines 1, maxEmptyLinesToKeep 1, reflowComments false, useTab false
// $antlr-format allowShortRulesOnASingleLine false, allowShortBlocksOnASingleLine true, alignSemicolons hanging, alignColons hanging

parser grammar VandiorParser;

options {
    tokenVocab = VandiorLexer;
}

program: expr* EOF;


expr
    : left=expr op=(MUL|DIV) right=expr           #MultDiv
    | left=expr op=(PLUS|MINUS) right=expr        #AddSub
    | <assoc=right>  left=expr op='^' right=expr  #powerExp
    | primaryExpr                                 #PriExpression
    | LPAREN expr RPAREN                          #Paren;

primaryExpr
    : identifier
    | literal
    ;

identifier: Identifier;

literal
    : IntegerLiteral
    | FloatingPointLiteral
    | BooleanLiteral
    | CharacterLiteral
    | StringLiteral
    | NullLiteral
    ;

