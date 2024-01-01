:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).

% Sunucu portu
server_port(8080).

% Başlangıç noktası
:- http_handler(root(.), handle_get_request, []). % GET isteği için ayarla
:- http_handler(root(submit), handle_post_request, []). % POST isteği için ayarla

% Sunucu başlatma
start_server :-
    server_port(Port),
    http_server(http_dispatch, [port(Port)]).

% GET isteği işleme
handle_get_request(_Request) :-
    reply_html_page(
        title('TrainerX'),
        [h2('TrainerX - Your Fitness Coach'), \form_content,
        style('
        body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        color: #333;
        }

        h2 {
            color: #0066cc;
        }

        form {
            max-width: 400px;
            margin: 20px auto;
            padding: 15px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #0066cc;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0052a3;
        }

        select {
            background-color: #fff;
            color: #333;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    
        option {
            background-color: #fff;
            color: #333;
        }
         ')]
    ).

% POST isteği işleme
handle_post_request(Request) :-
    http_parameters(Request, [fullname(Fullname, []), age(Age, []), gender(Gender, []), height(Height, []), weight(Weight, []), goal(Goal, []), level(Level, []), type(Type, []), facility(Facility, []), time(Time, [])]),
    generate_fitness_program(Fullname, Age, Gender, Height, Weight, Goal, Level, Type, Facility, Time, Program),
    reply_html_page(
        title('TrainerX'),
        [h2('Fitness Program Created'), 
        style('
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }

            h2 {
                color: #0066cc;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #0066cc;
                color: white;
            }

            tr:hover {
                background-color: #f5f5f5;
            }

            p {
                display: inline-block;
                margin-right: 10px;
            }
        '), 
        p('Full Name: ~w' - [Fullname]),
        p('Age: ~w' - [Age]),
        p('Gender: ~w' - [Gender]),
        p('Height: ~w' - [Height]),
        p('Weight: ~w' - [Weight]),
        p('Goal: ~w' - [Goal]),
        p('Fitness Level: ~w' - [Level]),
        p('Program Type: ~w' - [Type]),
        p('Facility: ~w' - [Facility]),
        p('Time: ~w' - [Time]),
        \fitness_program_table(Program)]
    ).

% Fitness Programları

%Program 0: Tanımsız

generate_fitness_program(Fullname, Age, Gender, Height, Weight, Goal, Level, fullbody, Facility, five, Program) :-
    Program = [
        exercise(error, 'undefined program')
    ].

%Program 00: Tanımsız
generate_fitness_program(Fullname, Age, Gender, Height, Weight, Goal, Level, split, Facility, two, Program) :-
    Program = [
        exercise(error, 'undefined program')
    ].

%Program 00: Tanımsız
generate_fitness_program(Fullname, Age, Gender, Height, Weight, loseweight, Level, Facility, home, Time, Program) :-
    Program = [
        exercise(error, 'undefined program')
    ].

%Program 1: gain weight, full body, at gym, 2 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, fullbody, gym, two, Program) :-
    Program = [
        exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Squats: 3 sets x 6-8 reps'),
    exercise('', 'Bench Press: 3 sets x 6-8 reps'),
    exercise('', 'Seated Cable Rows: 3 sets x 8-10 reps'),
    exercise('', 'Dumbbell Shoulder Press: 3 sets x 8-10 reps'),
    exercise('', 'Lat Pull-Downs: 3 sets x 8-10 reps'),
    exercise('', 'Leg Curls: 3 sets x 8-10 reps'),
    exercise('', 'Triceps Pushdowns: 3 sets x 10-15 reps'),
    exercise('', 'Biceps Curls: 3 sets x 10-15 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
        exercise(day2, 'Off Day'),
        exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Romanian Deadlift: 3 sets x 6-8 reps'),
    exercise('', 'Pull-Ups or Lat Pull-Downs: 3 sets x 6-8 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Butterfly Chest Press: 3 sets x 8-10 reps'),
    exercise('', 'Leg Press: 3 sets x 10-12 reps'),
    exercise('', 'Lateral Raises: 3 sets x 10-15 reps'),
    exercise('', 'Face Pulls: 3 sets x 10-15 reps'),
    exercise('', 'Standing Calf Raises: 4 sets x 6-10 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
        exercise(day4, 'Off Day'),
        exercise(day5, 'Off Day'),
        exercise(day6, 'Off Day'),
        exercise(day7, 'Off Day')
    ].

%Program 2: gain weight, full body, at gym, 3 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, fullbody, gym, three, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Squats: 3 sets x 6-8 reps'),
    exercise('', 'Bench Press: 3 sets x 6-8 reps'),
    exercise('', 'Pull-Ups or Lat Pull-Downs: 3 sets x 8-10 reps'),
    exercise('', 'Shoulder Press: 3 sets x 8-10 reps'),
    exercise('', 'Leg Curls: 3 sets x 8-10 reps'),
    exercise('', 'Biceps Curls: 3 sets x 10-15 reps'),
    exercise('', 'Face Pulls: 3 sets x 10-15 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Romanian Deadlift: 3 sets x 6-8 reps'),
    exercise('', 'Seated Cable Rows: 3 sets x 6-8 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Leg Press or Split Squats: 3 sets x 10-12 reps'),
    exercise('', 'Lateral Raises: 3 sets x 10-15 reps'),
    exercise('', 'Triceps Pushdowns: 3 sets x 10-15 reps'),
    exercise('', 'Standing Calf Raises: 3 sets x 6-10 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Squats: 3 sets x 6-8 reps'),
    exercise('', 'Bench Press: 3 sets x 6-8 reps'),
    exercise('', 'Pull-Ups or Lat Pull-Downs: 3 sets x 8-10 reps'),
    exercise('', 'Shoulder Press: 3 sets x 8-10 reps'),
    exercise('', 'Leg Curls: 3 sets x 8-10 reps'),
    exercise('', 'Biceps Curls: 3 sets x 10-15 reps'),
    exercise('', 'Face Pulls: 3 sets x 10-15 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),        
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'Off Day')
    ].

%Program 3: gain weight full body, at gym, 4 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, fullbody, gym, four, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Bench Press 4 sets x 8-12 reps'),
    exercise('', 'Cable Triceps Pushdown: 3 sets x 10-12 reps'),
    exercise('', 'DB Overhead Press: 4 sets x 8-12 reps'),
    exercise('', 'Cable Seated Rowing: 4 sets x 8-12 reps'),
    exercise('', 'Biceps Curls: 3 sets x 10-12 reps'),
    exercise('', 'Machine Leg Press: 4 sets x 10-15 reps'),
    exercise('', 'Glue Press: 3 sets x 8-12 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Barbell Back Squat: 4 sets x 10-15 reps'),
    exercise('', 'Machine Leg Curl: 3 sets x 8-12 reps'),
    exercise('', 'Lat Pulldown: 4 sets x 8-12 reps'),
    exercise('', 'Chinup/Concentration Curl AMRAP x 3'),
    exercise('', 'Incline DB Bench Press: 4 sets x 8-12 reps'),
    exercise('', 'DB/Cable Kickback: 3 sets x 8-10 reps'),
    exercise('', 'Dumbbell Lateral Raises: 4 sets x 8-12 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Military Press: 4 sets x 8-12 reps'),
    exercise('', 'Seated Machine Fly: 4 sets x 8-12 reps'),
    exercise('', 'Barbell Bent-over Rowing: 4 sets x 8-12 reps'),
    exercise('', 'Barbell Upright Row: 3 sets x 8-10 reps'),
    exercise('', 'Wrist Curl: 3 sets x 8-10 reps'),
    exercise('', 'Hack Squat/DB Lunges: 4 sets x 8-10 reps'),
    exercise('', 'Calf Raises: 3 sets x 8-10 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Conventional Deadlift: 4, 3, 2, 1 reps'),
    exercise('', 'Cable Curl: 4 sets x 8-12 reps'),
    exercise('', 'Single-arm DB Rowing: 3 sets x 8-12 reps'),
    exercise('', 'Incline Barbell Bench Press: 4 sets x 8-12 reps'),
    exercise('', 'Barbell/DB Skull Crusher: 3 sets x 8-12 reps'),
    exercise('', 'Face Pull: 3 sets x 8-12 reps'),
    exercise('', 'Shoulder Shrug: 3 sets x 8-12 reps'),
    exercise('', 'Plank or ABS Machine: 3 sets x 15-20 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching')
    ].

%Program 4: gain weight full body, at Home, 2 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, fullbody, home, two, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: movements without equipment'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Burpee: 6 per minute for 15 minutes'),
    exercise('', 'Pull-up: 3 sets x 6-8 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Inchworm: 3 sets x 4-6 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: movements with dumbells'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying dumbbell fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Biceps curl: 3 sets x 10-15 reps'),
    exercise('', 'Triceps extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'Off Day'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'Off Day')
    ].

%Program 5: gain weight full body, at Home, 3 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, fullbody, home, three, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: you need two dumbbells'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Burpee: 6 per minute for 15 minutes'),
    exercise('', 'Pull-up: 3 sets x 6-8 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps Curl: 3 sets x 10-15 reps'),
    exercise('', 'Inchworm: 3 sets x 4-6 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying dumbbell fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps curl: 3 sets x 10-15 reps'),
    exercise('', 'Pullover: 3 sets x 10–12 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'Off Day')
    ].

%Program 6: gain weight full body, at Home, 4 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, fullbody, home, four, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: you need two dumbbells'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Burpee: 6 per minute for 15 minutes'),
    exercise('', 'Pull-up: 3 sets x 6-8 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps Curl: 3 sets x 10-15 reps'),
    exercise('', 'Inchworm: 3 sets x 4-6 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying dumbbell fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps curl: 3 sets x 10-15 reps'),
    exercise('', 'Pullover: 3 sets x 10–12 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body')
    ].

%Program 7: gain weight split, at gym, 3 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, split, gym, three, Program) :-
    Program = [
    exercise('day1 - chest-backarm', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Bench Press: 5 sets x 6-8 reps'),
    exercise('', 'incline Dumbbell Bench Press: 5 sets x 6-8 reps'),
    exercise('', 'Decline Bench Press: 4 sets x 6-8 reps'),
    exercise('', 'Decline Dumbbell Bench Fly: 3 sets x 10-12 reps'),
    exercise('', 'Squeeze Press: 3 sets x 15-20 reps'),
    exercise('', 'Cable Triceps Push Down: 5 sets x 8-10 reps'),
    exercise('', 'Kickback: 3 sets x 10-12 reps'),
    exercise('', 'Bench Dips: 4 sets x 8-12 reps'),
    exercise('', 'Cable Rope Push Down: 3 sets x 10-12 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise('day3 - back forearm', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Lat Pull Down-Front: 5 sets x 8-10 reps'),
    exercise('', 'Bent Over Barbell Row: 5 sets x 6-8 reps'),
    exercise('', 'Long Row: 4 sets x 8-10 reps'),
    exercise('', 'Dumbbell Row: 3 sets x 8-10 reps'),
    exercise('', 'Romain Deadlift: 4 sets x 8-10 reps'),
    exercise('', 'Barbell Biceps Curl: 4 sets x 10-12 reps'),
    exercise('', 'Consantiration Curl: 3 sets x 10-12 reps'),
    exercise('', 'Dumbbell Hummer Curl: 3 sets x 8-10 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise('day5 - shoulder leg abdomen', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Smith Machine Front Shoulder Press: 5 sets x 10-12 reps'),
    exercise('', 'Dumbbell Lateral Raise: 5 sets x 8-10 reps'),
    exercise('', 'Dumbbell Front Raise: 4 sets x 8-10 reps'),
    exercise('', 'Bent Over Cable Lateral Raise: 3 sets x 8-10 reps'),
    exercise('', 'Leg Press: 5 sets x 8-10 reps'),
    exercise('', 'Leg Extension: 4 sets x 10-12 reps'),
    exercise('', 'Leg Curl: 4 sets x 10-12 reps'),
    exercise('', 'Calf Machine: 4 sets x 15-20 reps'),
    exercise('', 'Crunch: 5 sets x 12-15 reps'),   
    exercise('', 'Leg Raise: 4 sets x 12-15 reps'),        
    exercise('', 'Plank: 3 sets x 60-90 sec'),             
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'Off Day')
    ].

%Program 8: gain weight split, at gym, 4 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, split, gym, four, Program) :-
    Program = [
    exercise('day1 - chest-backarm', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'İncline Bench Press: 5 sets x 6-8 reps'),
    exercise('', 'incline Dumbbell Bench Press: 4 sets x 8-10 reps'),
    exercise('', 'Decline Bench Press: 4 sets x 8-10 reps'),
    exercise('', 'Decline Dumbbell Bench Fly: 4 sets x 8-10 reps'),
    exercise('', 'Cable Decline Fly: 3 sets x 12-15 reps'),
    exercise('', 'Cable Triceps Push Down: 5 sets x 8-10 reps'),
    exercise('', 'Dumbbell Triceps Extension: 4 sets x 8-10 reps'),
    exercise('', 'Bench Dips: 4 sets x 10-12 reps'),
    exercise('', 'Close Push Up: 3 sets x AMRAP'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise('day3 - back forearm', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Lat Pull Down-Back: 5 sets x 8-10 reps'),
    exercise('', 'Bent Over Barbell Row: 5 sets x 6-8 reps'),
    exercise('', 'Long Row: 4 sets x 8-10 reps'),
    exercise('', 'Bent Over Dumbbell Row: 3 sets x 10-12 reps'),
    exercise('', 'Dumbbell Romain Deadlift: 4 sets x 8-10 reps'),
    exercise('', 'Z-Bar Biceps Curl: 4 sets x 8-10 reps'),
    exercise('', 'Cable Reverse Curl: 4 sets x 8-10 reps'),
    exercise('', 'Dumbbell Hummer Curl: 3 sets x 8-10 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise('day5 - shoulder abdomen', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Dumbbell Shoulder Press: 5 sets x 8-10 reps'),
    exercise('', 'Dumbbell Lateral Raise: 5 sets x 8-10 reps'),
    exercise('', 'Plaka Front Raise: 4 sets x 8-10 reps'),
    exercise('', 'Bent Over Cable Lateral Raise: 3 sets x 8-10 reps'),
    exercise('', 'Arnould Shoulder Press: 3 sets x 8-10 reps'),
    exercise('', 'Barbell Shurg: 3 sets x 8-10 reps'),
    exercise('', 'Decline Crunch - weighted: 5 sets x 10-12 reps'),
    exercise('', 'Leg Raise - weighted: 4 sets x 10-12 reps'),
    exercise('', 'Side Plank: 3 sets x 25-35 sec'),   
    exercise('', 'Plank: 3 sets x 60-90 sec'),             
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise('day7 - leg', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Back Squat: 5 sets x 8-10 reps'),
    exercise('', 'Leg Extension: 4 sets x 10-12 reps'),
    exercise('', 'Leg Curl: 4 sets x 10-12 reps'),
    exercise('', 'Walking Lunge: 4 sets x 10 steps'),
    exercise('', 'Hip Thrust: 4 sets x 10-12 reps'),
    exercise('', 'Standing Calf - one leg: 3 sets x 15-20 reps'),          
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching')
    ].

%Program 9: gain weight split, at gym, 5 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, split, gym, five, Program) :-
    Program = [
    exercise('day1 - chest', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Bench Press: 5 sets x 6-8 reps'),
    exercise('', 'Dumbbell Bench Press: 5 sets x 6-8 reps'),
    exercise('', 'İncline Bench Press: 4 sets x 8-10 reps'),
    exercise('', 'İncline Dumbbell Bench Press: 4 sets x 8-10 reps'),
    exercise('', 'Cable Chest Fly: 4 sets x 12-15 reps'),
    exercise('', 'Dumbbell Curcle Fly: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise('day2 - back', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Pull Up: 4 sets x 8-10 reps'),
    exercise('', 'Bent Over Reverse Barbell Row: 5 sets x 8-10 reps'),
    exercise('', 'Close Grip Pull Down: 4 sets x 8-10 reps'),
    exercise('', 'Dumbbell Row: 3 sets x 8-10 reps'),
    exercise('', 'High Row: 4 sets x 8-10 reps'),
    exercise('', 'Dumbbell Romain Deadlift: 4 sets x 8-10 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day3, 'Off Day'),
    exercise('day4 - shoulder', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Dumbbell Shoulder Press: 5 sets x 6-8 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 8-10 reps'),
    exercise('', 'Dumbbell Front Raise: 4 sets x 8-10 reps'),
    exercise('', 'Bent Over Dumbbell Lateral Raise: 4 sets x 8-10 reps'),
    exercise('', 'Dumbbell Lateral & Front Raise: 3 sets x 10-12 reps'),
    exercise('', 'Dumbbell Shurg: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise('day5 - forearm backarm', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Barbell Biceps Curl: 4 sets x 8-10 reps'),
    exercise('', 'Cable Reverse Curl: 4 sets x 8-10 reps'),
    exercise('', 'Cable Hummer Curl: 4 sets x 8-10 reps'),
    exercise('', 'Cable Triceps Push Down: 4 sets x 8-10 reps'),
    exercise('', 'One Arm Dumbbell Triceps Extension: 4 sets x 8-10 reps'),
    exercise('', 'Skull Crusher: 4 sets x 8-10 reps'),
    exercise('', 'Close Push Up: 3 sets x AMRAP'),
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise('day7 - leg', 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Back Squat: 5 sets x 6-8 reps'),
    exercise('', 'Leg Extension: 4 sets x 8-10 reps'),
    exercise('', 'Leg Curl: 4 sets x 8-10 reps'),
    exercise('', 'Stabil Lunge: 4 sets x 10 steps'),
    exercise('', 'Hip Thrust: 4 sets x 10-12 reps'),
    exercise('', 'Deadlift: 4 sets x 10-12 reps'),   
    exercise('', 'Calf: 4 sets x 12-15 reps'),                 
    exercise('', 'COOL DOWN: 5-10 minutes of light stretching')
    ].

%Program 11: gain weight split, at Home, 3 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, split, home, three, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: you need two dumbbells'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Burpee: 6 per minute for 15 minutes'),
    exercise('', 'Pull-up: 3 sets x 6-8 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps Curl: 3 sets x 10-15 reps'),
    exercise('', 'Inchworm: 3 sets x 4-6 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'Off Day'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'Off Day')
    ].

%Program 12: gain weight split, at Home, 4 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, split, home, four, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: you need two dumbbells'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Burpee: 6 per minute for 15 minutes'),
    exercise('', 'Pull-up: 3 sets x 6-8 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps Curl: 3 sets x 10-15 reps'),
    exercise('', 'Inchworm: 3 sets x 4-6 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying dumbbell fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps curl: 3 sets x 10-15 reps'),
    exercise('', 'Pullover: 3 sets x 10–12 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body')
    ].

%Program 13: gain weight split, at Home, 5 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, gainweight, Level, split, home, five, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: you need two dumbbells'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Burpee: 6 per minute for 15 minutes'),
    exercise('', 'Pull-up: 3 sets x 6-8 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps Curl: 3 sets x 10-15 reps'),
    exercise('', 'Inchworm: 3 sets x 4-6 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'note: you need two dumbbells'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Burpee: 6 per minute for 15 minutes'),
    exercise('', 'Pull-up: 3 sets x 6-8 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps Curl: 3 sets x 10-15 reps'),
    exercise('', 'Inchworm: 3 sets x 4-6 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Push-up: 3-6 sets x 10-12 reps'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying dumbbell fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Plank-up: 3 sets x 5-10 reps'),
    exercise('', 'Biceps curl: 3 sets x 10-15 reps'),
    exercise('', 'Pullover: 3 sets x 10–12 reps'),
    exercise('', 'Step-up: 3 sets x 15 reps'),
    exercise('', 'Lunge: 3 sets x 15 reps'),
    exercise('', 'Squat: 3-5 sets x 8-12 reps'),
    exercise('', 'Sit Up: 3 sets x 15-20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3-6 sets x 6-10 reps'),
    exercise('', 'Lying Dumbbell Fly: 3-6 sets x 6-10 reps'),
    exercise('', 'Incline Dumbbell Press: 3 sets x 8-10 reps'),
    exercise('', 'Pullover: 3 sets of 10–12 reps'),
    exercise('', 'Triceps dip: 2 sets x 10-12 reps'),
    exercise('', 'Triceps Extension: 3 sets x 8-12 reps'),
    exercise('', 'Wrist curl: 3 sets x 12 reps'),
    exercise('', 'Dumbbell squat: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell walking lunge: 3 sets x 10 reps'),
    exercise('', 'Calf raise: 3 sets x 15–20 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching focusing on the lower body')
    ].

%Program 15: lose weight full body, at gym, 2 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, loseweight, Level, fullbody, gym, two, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
        exercise(day4, 'Off Day'),
        exercise(day5, 'Off Day'),
        exercise(day6, 'Off Day'),
        exercise(day7, 'Off Day')
    ].

%Program 15: lose weight full body, at gym, 3 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, loseweight, Level, fullbody, gym, three, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'Off Day')
    ].

%Program 16: lose weight full body, at gym, 4 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, loseweight, Level, fullbody, gym, four, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 15-20 reps'),
    exercise('', 'Lat Pull Down: 3 sets x 15-20 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching')
    ].

%Program 21: lose weight split, at gym, 3 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, loseweight, Level, split, gym, three, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 4 sets x 8-10 reps'),
    exercise('', 'Dumbbell Bench Press: 4 sets x 10-12 reps'),
    exercise('', 'Cable Fly: 3 sets x 12-15 reps'),
    exercise('', 'incline Bench Press: 3 sets x 10-12 reps'),
    exercise('', 'incline Dumbbell Bench Press: 3 sets x 10-12 reps'),
    exercise('', 'Pullover: 3 sets x 8-10 reps'),
    exercise('', 'Cable Triceps Push Down: 3 sets x 12-15 reps'),
    exercise('', 'Bench Dips: 3 sets x 15-20 reps'),
    exercise('', 'Cable Rope Push Down: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Squat: 3 sets x 12-15 reps'),
    exercise('', 'Lat Pull Down - front: 4 sets x 10-12 reps'),
    exercise('', 'Seated Long Row: 3 sets x 8-10 reps'),
    exercise('', 'Dumbbell Row: 3 sets x 10-12 reps'),
    exercise('', 'T-Bar Row: 3 sets x 10-12 reps'),
    exercise('', 'Hyper Extension: 3 sets x 12-15 reps'),
    exercise('', 'Barbell Curl: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 10-12 reps'),
    exercise('', 'Cable Rope Hummer Curl: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Back Squat: 4 sets x 8-10 reps'),
    exercise('', 'Leg Extension: 4 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 4 sets x 12-15 reps'),
    exercise('', 'Walking Lunge: 3 sets x 20 reps'),
    exercise('', 'Dumbbell Deadlift: 3 sets x 10-12 reps'),
    exercise('', 'Dunky Calf: 3 sets x 15-20 reps'),
    exercise('', 'Cable Crunch: 4 sets x 10-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'Plank: 3 sets x 60-90 sec'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'Off Day')
    ].

%Program 21: lose weight split, at gym, 4 Days
generate_fitness_program(Fullname, Age, Gender, Height, Weight, loseweight, Level, split, gym, four, Program) :-
    Program = [
    exercise(day1, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 12 reps'),
    exercise('', 'Dumbbell Bench Press: 3 sets x 10-12 reps'),
    exercise('', 'İncline Dumbbell Bench Fly: 3 sets x 10-12 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Shoulder Press: 3 sets x 10-12 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Shurg: 3 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Hummer Curl: 3 sets x 12-15 reps'),
    exercise('', 'Cable Ropee Push Down: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day2, 'Off Day'),
    exercise(day3, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Squat: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Stabil Lunge: 3 sets x 12-15 reps'),
    exercise('', 'Calf: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'Plank: 3 sets x 30-45 sec'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day4, 'Off Day'),
    exercise(day5, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Chest Press: 3 sets x 12 reps'),
    exercise('', 'Dumbbell Bench Press: 3 sets x 10-12 reps'),
    exercise('', 'İncline Dumbbell Bench Fly: 3 sets x 10-12 reps'),
    exercise('', 'Seated Row: 3 sets x 12-15 reps'),
    exercise('', 'Shoulder Press: 3 sets x 10-12 reps'),
    exercise('', 'Dumbbell Lateral Raise: 4 sets x 10-12 reps'),
    exercise('', 'Dumbbell Shurg: 3 sets x 10-12 reps'),
    exercise('', 'Dumbbell Alternate Curl: 3 sets x 12-15 reps'),
    exercise('', 'One Arm Dumbbell Triecps Press: 3 sets x 12-15 reps'),
    exercise('', 'Dumbbell Hummer Curl: 3 sets x 12-15 reps'),
    exercise('', 'Cable Ropee Push Down: 3 sets x 12-15 reps'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching'),
    exercise(day6, 'Off Day'),
    exercise(day7, 'WARM UP - 5-10 minutes of light cardio and dynamic stretches'),
    exercise('', 'Squat: 3 sets x 12-15 reps'),
    exercise('', 'Leg Extension: 3 sets x 12-15 reps'),
    exercise('', 'Leg Curl: 3 sets x 12-15 reps'),
    exercise('', 'Stabil Lunge: 3 sets x 12-15 reps'),
    exercise('', 'Calf: 3 sets x 12-15 reps'),
    exercise('', 'Crunch: 3 sets x 12-15 reps'),
    exercise('', 'Leg Raise: 3 sets x 12-15 reps'),
    exercise('', 'Plank: 3 sets x 30-45 sec'),
    exercise('', 'COOL DOWN - 5-10 minutes of light stretching')
    ].

% Fitness programını tablo olarak gösterme
fitness_program_table(Program) -->
    html(table([class('fitness-program')],
        [caption('Your Weekly Fitness Program'),
         \fitness_program_header,
         \fitness_program_rows(Program)]
    )).

% Fitness programı tablosu başlıkları
fitness_program_header -->
    html(tr([th('Day'), th('Workout')])).

% Fitness programı tablosu satırları
fitness_program_rows([]) --> [].
fitness_program_rows([exercise(Day, Workout) | Rest]) -->
    html(tr([td(Day), td(Workout)])),
    fitness_program_rows(Rest).

% HTML form içeriği
form_content -->
    html(form([action('/submit'), method('post')],
        [label([for('fullname')], 'Fullname'),
         input([type('text'), id('fullname'), name('fullname'), required]),
         br([]),
         label([for('age')], 'Age'),
         input([type('text'), id('age'), name('age'), required]),
         br([]),
         label([for('gender')], 'Gender'),
         select([name('gender'), id('gender')],
            [option([value('he')], 'He'),
             option([value('she')], 'She')]),
         br([]),
         label([for('height')], 'Height - cm'),
         input([type('text'), id('height'), name('height'), required]),
         br([]),
         label([for('weight')], 'Weight - kg'),
         input([type('text'), id('weight'), name('weight'), required]),
         br([]),
         label([for('goal')], 'Goal'),
         select([name('goal'), id('goal')],
            [option([value('gainweight')], 'Gain Weight'),
             option([value('loseweight')], 'Lose Weight')]),
         br([]),
         label([for('level')], 'Fitness Level'),
         select([name('level'), id('level')],
            [option([value('rookie')], 'Rookie - New to Fitness'),
             option([value('average')], 'Average - in Fitness for Months'),
             option([value('veteran')], 'Veteran - in Fitness for Years')]),
         br([]),
         label([for('type')], 'Program Type'),
         select([name('type'), id('type')],
            [option([value('fullbody')], 'Full Body - recommmended for beginners, it is a program in which you work every muscle group of the body in one day.'),
             option([value('split')], 'Split - recommmended for average or veterans, it is a program in which you work a specific muscle group in one day.')]),
         br([]),
         label([for('facility')], 'Facility'),
         select([name('facility'), id('facility')],
            [option([value('gym')], 'at gym - working out with fitness equipment'),
             option([value('home')], 'at Home - working out with body weight')]),
         br([]),
         label([for('time')], 'Time'),
         select([name('time'), id('time')],
            [option([value('two')], '2 days in a week - just for beginners with full body program'),
             option([value('three')], '3 days in a week - full body or split programs'),
             option([value('four')], '4 days in a week - full body or split programs'),
             option([value('five')], '5 days in a week - just for split program')]),
         br([]),
         input([type('submit'), value('Create My Fitness Program')])
        ]
    )).

% Ana çalışma
:- start_server.