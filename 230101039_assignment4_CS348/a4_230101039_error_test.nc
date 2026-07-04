// ERROR TEST FILE - a4_230101039_error_test.nc
// This file contains various syntax errors to test error handling

// ERROR 1: Missing semicolon in declaration
int missing_semicolon

// ERROR 2: Invalid type specifier
invalid_type x;

// ERROR 3: Missing closing parenthesis in expression
int result = (5 + 3;

// ERROR 4: Missing opening brace in if statement
if (x > 0) 
    y = 1
else
    y = 2;

// ERROR 5: Incomplete array declaration
int array[];

// ERROR 6: Missing expression in assignment
int uninitialized = ;

// ERROR 7: Invalid postfix operation
x+++++;

// ERROR 8: Missing closing parenthesis in function parameter
int func(int a, float b;

// ERROR 9: Invalid declaration specifier order
const int restricted_var;

// ERROR 10: Missing semicolon after expression statement
y = 5

// ERROR 11: Invalid operator usage
int invalid_op = 5 $$ 3;

// ERROR 12: Missing closing brace in block
if (x > 0) {
    y = 1;
    z = 2;

// ERROR 13: Double assignment operators
int x == 5;

// ERROR 14: Missing semicolon after return
return x

// ERROR 15: Invalid label syntax
label x: int y;

// ERROR 16: Missing expression after comma operator
int a, , b;

// ERROR 17: Incomplete ternary operator
int result = (x > 0) ? 1 ;

// ERROR 18: Missing parentheses in while loop
while x > 0
    y++;

// ERROR 19: Invalid designator syntax
int arr[5] = { 0 1, 2 };

// ERROR 20: Missing colon after case
switch (x) {
    case 1
        break;
}
