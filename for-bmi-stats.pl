% Rules to calculate BMI
calculate_bmi(Weight, Height, BMI) :-
    BMI is Weight / ((Height / 100) * (Height / 100)).

% Rules to interpret BMI
interpret_bmi(BMI, Category) :-
    BMI < 18.5,
    Category = 'Underweight'.
interpret_bmi(BMI, Category) :-
    BMI >= 18.5, BMI < 24.9,
    Category = 'Normal Weight'.
interpret_bmi(BMI, Category) :-
    BMI >= 24.9, BMI < 29.9,
    Category = 'Overweight'.
interpret_bmi(BMI, Category) :-
    BMI >= 30,
    Category = 'Obese'.

% Rules to suggest fitness program based on BMI category
fitness_program('Underweight', 'Strength training and balanced diet').
fitness_program('Normal Weight', 'Cardio and strength training, maintain a balanced diet').
fitness_program('Overweight', 'Cardio, strength training, and calorie deficit diet').
fitness_program('Obese', 'Intensive cardio, strength training, and calorie-restricted diet').

% Rules to suggest nutrition program based on BMI category
nutrition_program('Underweight', 'Increase calorie intake, focus on nutrient-dense foods').
nutrition_program('Normal Weight', 'Maintain a balanced diet with a mix of macronutrients').
nutrition_program('Overweight', 'Reduce calorie intake, focus on whole foods, and portion control').
nutrition_program('Obese', 'High protein, low calorie diet with portion control').

% Example usage:
weight(john, 70). % John's weight in kilograms
height(john, 175). % John's height in centimeters

% Calculate BMI for John
calculate_bmi_for_john(BMI) :-
    weight(john, Weight),
    height(john, Height),
    calculate_bmi(Weight, Height, BMI).

% Interpret John's BMI
interpret_bmi_for_john(Category) :-
    calculate_bmi_for_john(BMI),
    interpret_bmi(BMI, Category).

% Suggest fitness program for John
suggest_fitness_program_for_john(Program) :-
    interpret_bmi_for_john(Category),
    fitness_program(Category, Program).

% Suggest nutrition program for John
suggest_nutrition_program_for_john(Program) :-
    interpret_bmi_for_john(Category),
    nutrition_program(Category, Program).

%calculate_bmi_for_john(BMI).
%interpret_bmi_for_john(Category).
%suggest_fitness_program_for_john(Program).
%suggest_nutrition_program_for_john(Program).
