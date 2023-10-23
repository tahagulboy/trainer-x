person(john, male, 30, 175, 80, weight_loss).
person(susan, female, 35, 160, 65, muscle_building).
person(mike, male, 45, 180, 90, flexibility).
person(lisa, female, 28, 165, 55, weight_loss).

fitness_program(cardio, weight_loss, 30, 60).
fitness_program(weight_training, muscle_building, 60, 90).
fitness_program(yoga, flexibility, 20, 45).

nutrition_program(high_protein, muscle_building).
nutrition_program(low_carb, weight_loss).
nutrition_program(balanced_diet, flexibility).

recommend_programs(Person, FitnessProgram, NutritionProgram) :-
    person(Person, Gender, Age, Height, Weight, Goal),
    fitness_program(FitnessProgram, Goal, MinDuration, MaxDuration),
    nutrition_program(NutritionProgram, Goal),
    (
        (Age >= 18, Weight >= 70, Height >= 170) -> 
            (Gender == male -> FitnessProgram = cardio; FitnessProgram = yoga),
            NutritionProgram = high_protein;
        
        (Age > 30, Weight >= 80, Height >= 160) -> 
            FitnessProgram = weight_training,
            NutritionProgram = low_carb;
        
        (Age > 50, Weight >= 90) -> 
            FitnessProgram = yoga,
            NutritionProgram = balanced_diet;
        
        true -> 
            FitnessProgram = no_recommendation, 
            NutritionProgram = no_recommendation
    ),
    between(MinDuration, MaxDuration, Duration),
    write('Önerilen Fitness Programı: '), write(FitnessProgram), nl,
    write('Önerilen Beslenme Programı: '), write(NutritionProgram), nl,
    write('Günlük Egzersiz Süresi (dakika): '), write(Duration).
