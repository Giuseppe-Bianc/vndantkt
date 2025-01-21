// $antlr-format alignTrailingComments true, columnLimit 150, maxEmptyLinesToKeep 1, reflowComments false, useTab false
// $antlr-format allowShortRulesOnASingleLine true, allowShortBlocksOnASingleLine true, minEmptyLines 0, alignSemicolons ownLine
// $antlr-format alignColons trailing, singleLineOverrulesHangingColon true, alignLexerCommands true, alignLabels true, alignTrailers true

lexer grammar VandiorLexer;

// LEXER

// §3.10.1 Integer Literals

IntegerLiteral:
    DecimalIntegerLiteral
    | HexIntegerLiteral
    | OctalIntegerLiteral
    | BinaryIntegerLiteral
;

fragment DecimalIntegerLiteral: DecimalNumeral IntegerTypeSuffix?;

fragment HexIntegerLiteral: HexNumeral IntegerTypeSuffix?;

fragment OctalIntegerLiteral: OctalNumeral IntegerTypeSuffix?;

fragment BinaryIntegerLiteral: BinaryNumeral IntegerTypeSuffix?;

fragment IntegerTypeSuffix: [lL];

fragment DecimalNumeral: '0' | NonZeroDigit (Digits? | Underscores Digits);

fragment Digits: Digit (DigitsAndUnderscores? Digit)?;

fragment Digit: '0' | NonZeroDigit;

fragment NonZeroDigit: [1-9];

fragment DigitsAndUnderscores: DigitOrUnderscore+;

fragment DigitOrUnderscore: Digit | '_';

fragment Underscores: '_'+;

fragment HexNumeral: '0' [xX] HexDigits;

fragment HexDigits: HexDigit (HexDigitsAndUnderscores? HexDigit)?;

fragment HexDigit: [0-9a-fA-F];

fragment HexDigitsAndUnderscores: HexDigitOrUnderscore+;

fragment HexDigitOrUnderscore: HexDigit | '_';

fragment OctalNumeral: '0' [oO] Underscores? OctalDigits;

fragment OctalDigits: OctalDigit (OctalDigitsAndUnderscores? OctalDigit)?;

fragment OctalDigit: [0-7];

fragment OctalDigitsAndUnderscores: OctalDigitOrUnderscore+;

fragment OctalDigitOrUnderscore: OctalDigit | '_';

fragment BinaryNumeral: '0' [bB] BinaryDigits;

fragment BinaryDigits: BinaryDigit (BinaryDigitsAndUnderscores? BinaryDigit)?;

fragment BinaryDigit: [01];

fragment BinaryDigitsAndUnderscores: BinaryDigitOrUnderscore+;

fragment BinaryDigitOrUnderscore: BinaryDigit | '_';

// §3.10.2 Floating-Point Literals

FloatingPointLiteral: DecimalFloatingPointLiteral | HexadecimalFloatingPointLiteral;

fragment DecimalFloatingPointLiteral:
    Digits '.' Digits? ExponentPart? FloatTypeSuffix?
    | '.' Digits ExponentPart? FloatTypeSuffix?
    | Digits ExponentPart FloatTypeSuffix?
    | Digits FloatTypeSuffix
;

fragment ExponentPart: ExponentIndicator SignedInteger;

fragment ExponentIndicator: [eE];

fragment SignedInteger: Sign? Digits;

fragment Sign: [+-];

fragment FloatTypeSuffix: [fFdD];

fragment HexadecimalFloatingPointLiteral: HexSignificand BinaryExponent FloatTypeSuffix?;

fragment HexSignificand: HexNumeral '.'? | '0' [xX] HexDigits? '.' HexDigits;

fragment BinaryExponent: BinaryExponentIndicator SignedInteger;

fragment BinaryExponentIndicator: [pP];

// §3.10.3 Boolean Literals

BooleanLiteral: 'true' | 'false';

// §3.10.4 Character Literals

CharacterLiteral: '\'' SingleCharacter '\'' | '\'' EscapeSequence '\'';

fragment SingleCharacter: ~['\\\r\n];

// §3.10.5 String Literals

StringLiteral: '"' StringCharacters? '"';

fragment StringCharacters: StringCharacter+;

fragment StringCharacter: ~["\\\r\n] | EscapeSequence;

TextBlock: '"""' [ \t]* [\n\r] [.\r\b]* '"""';

// §3.10.6 Escape Sequences for Character and String Literals

fragment EscapeSequence:
    '\\' [btnfr"'\\]
    | OctalEscape
    | UnicodeEscape // This is not in the spec but prevents having to preprocess the input
;

fragment OctalEscape:
    '\\' OctalDigit
    | '\\' OctalDigit OctalDigit
    | '\\' ZeroToThree OctalDigit OctalDigit
;

fragment ZeroToThree: [0-3];

// This is not in the spec but prevents having to preprocess the input
fragment UnicodeEscape: '\\' 'u'+ HexDigit HexDigit HexDigit HexDigit;

// §3.10.7 The Null Literal

NullLiteral: 'null';


Identifier: [\p{L}_$] [\p{L}\p{N}_$]*;
//ID : [a-zA-Z_$] [a-zA-Z0-9_]* ; // match usual identifier spec

//UNICODE_ID : [\p{Alpha}\p{General_Category=Other_Letter}_$] [\p{Alnum}\p{General_Category=Other_Letter}_]* ; // match full Unicode alphabetic ids

// Regole per gli operatori logici
AND: '&&';
OR: '||';
NOT: '!';

// Regole per gli operatori bitwise
BITWISE_AND: '&';
BITWISE_OR: '|';
BITWISE_XOR: '^';
SHL: '<<';
SHR: '>>';

// Regole per i simboli matematici
PLUS: '+';
MINUS: '-';
MUL: '*';
DIV: '/';

// Parentesi per raggruppare le espressioni
LPAREN: '(';
RPAREN: ')';

//
// Whitespace and comments
//

WS: [ \t\r\n\u000C]+ -> skip;

COMMENT: '/*' .*? '*/' -> channel(HIDDEN);

LINE_COMMENT: '//' ~[\r\n]* -> channel(HIDDEN);