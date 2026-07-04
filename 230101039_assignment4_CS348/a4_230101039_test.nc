// 1. Declarations & Type Specifiers
void empty_func();
char symbol;
short signal_strength;
int agent_state;
long total_iterations;
float portfolio_value;
double learning_rate;
signed int reward_penalty;
unsigned int time_step;
_Bool is_converged;
static double momentum;

// 2. Initializers and Designation 
int state_space[5] = { [0] = 1, [1] = 2, [4] = -1 };
float weights[3] = { 0.1, 0.5, 0.4 };

// 3. Function with Parameter List and Declarators
int optimize_portfolio(int state, float current_reward) {
    // Block Item List (Declarations mixed with Statements)
    _Bool finrag_active = 1;
    double new_weight;

    // Labeled Statement
    start_optimization:
    
    // 4. Expressions & Operators
    // Unary and Postfix Expressions
    time_step++;
    agent_state--;
    new_weight = +current_reward - -learning_rate;
    _Bool negate_flag = !finrag_active;
    int bit_flip = ~state;

    // Multiplicative, Additive, and Shift Expressions
    portfolio_value = portfolio_value * 1.05 / 1.01 % 100;
    agent_state = agent_state + 2 - 1;
    agent_state = agent_state << 1;
    agent_state = agent_state >> 1;

    // Relational and Equality Expressions
    if (portfolio_value < 1000.0) agent_state = 1;
    if (portfolio_value > 5000.0) agent_state = 2;
    if (time_step <= 10) agent_state = 0;
    if (time_step >= 100) is_converged = 1;
    if (state == 0) return 0;
    if (state != 1) return 1;

    // Bitwise and Logical Expressions
    int bit_mask = state & 1;
    bit_mask = bit_mask ^ 2;
    bit_mask = bit_mask | 4;
    
    if (finrag_active && is_converged) {
        portfolio_value = 0.0;
    }
    if (time_step > 100 || is_converged) {
        return 1;
    }

    // Conditional (Ternary) Expression
    reward_penalty = (agent_state == 2) ? -5 : 10;

    // Assignment Expressions
    portfolio_value = 100.0;
    portfolio_value += 10.0;
    portfolio_value -= 5.0;
    learning_rate *= 0.99;
    learning_rate /= 1.01;
    agent_state %= 3;
    agent_state <<= 1;
    agent_state >>= 1;
    agent_state &= 1;
    agent_state ^= 1;
    agent_state |= 1;

    // Comma Operator
    agent_state = (time_step++, time_step + 1);

    // 5. Iteration and Selection Statements
    // For loop with declaration and optional expressions
    for (int i = 0; i < 10; i++) {
        if (i == 5) {
            continue; // Jump Statement
        } else {
            portfolio_value += weights[0];
        }
    }

    // For loop with missing expressions
    for (;;) {
        break; // Jump Statement
    }

    // While loop
    while (portfolio_value < 500.0) {
        portfolio_value += 10.0;
    }

    // Do-While loop
    do {
        time_step++;
    } while (time_step < 50);

    return agent_state;
}

// 6. Main function to wrap everything up
int main() {
    int final_status;
    
    // Function call with arguments (Argument Expression List)
    final_status = optimize_portfolio(1, 15.5);
    
    // Expression Statement
    final_status; 
    
    return 0;
}