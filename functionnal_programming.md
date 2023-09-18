# Brief Introduction to Functional Programming

Functional Programming (FP) is a software programming paradigm, a way to write and think about programs.

Other popular paradigms include the famous Object Oriented Programming (OOP), typically used in Java, or Imperative Programming, as used in C.

OCaml supports all of the above: Functional Programming, OOP and Imperative Programming. However, it is still considered a Functional Programming Language as most OCaml developers write in a Functional style.

But what is Functional Programming?

Below, we list some code patterns that you will typically find in FP languages.

## Functional Programming

### Functions as first-class citizens

In OCaml, functions are just like any other value (like `2`, or `["my"; "list"]`). You can use them as arguments to other functions, have them as functions' return values, or assign them to variables.

Consider the example below:

```ocaml
let say_hello name = print_endline ("Hello " ^ name ^ "!")

List.map say_hello ["Sabine"; "Cuihtlauac"; "everyone"];;  
```

`say_hello` is a function with a single parameter `name`.
We use the function `List.map`, which applies the function to every item of a list. In other words, it iterates on the list `["Sabine"; "Cuihtlauac"; "everyone"]`, and for each item, execute the function by passes the list item as an argument. The code is equivalent to:

```ocaml
say_hello "Sabine";;
say_hello "Cuihtlauac";;
say_hello "everyone";;
```

The interesting thing is that the function `List.map` takes a function as a first argument. It is often called a Higher-Order function, and it's a pattern that is used constantly while writing functional code.

### Pure functions

In OCaml, it is encouraged to write pure functions — functions that for the same input will always return the same output and do not have any side effects. Side effects can include modifying a global variable, changing the input variables, or performing I/O operations, etc.

In the example below, the `send_rocket` function has a side effect of printing a message to the console every time it is called. Even though the `add_2` function computes and returns a new number based on the input, it is not considered pure because it involves a side effect caused by calling `send_rocket`.

```ocaml
let send_rocket = print_endline "3... 2... 1... Lift off!"

let add_2 number = 
  (* Scary side effect! *)
  send_rocket ();
  (* But the function just returns the number with 2 added. *)
  number + 2
```

### Declarative Programming

Declarative programming is a style of programming that expresses the logic of a computation without describing its control flow. In functional programming, you focus on what you are doing rather than how you are doing it.

Here, we define a `component` function that takes a `name` as a parameter and returns an HTML div component with a greeting message. This way of structuring the code helps in better readability and understanding of what the code is supposed to do, without getting bogged down by the details of how it's being done.

```ocaml
let component name =
  div [] [
    h2 [] ["Hello " ^ name]
  ]

let page = html
  (head (title (txt "Greeting")))
   (body [
      h1 [] ["I'm a HTML page"];
      component "you"
    ])
```

### Immutability

Immutability is a core principle in functional programming. It means that once a variable is created, it cannot be altered. If you want to make a change, you create a new variable.

In the example below, though it seems like `x` is being changed, a new variable `x` is being created and assigned a new value, leaving the original `x` unaltered. After calling the function `f`, `x` will still hold the value `7`.

```ocaml
let x = 5

(* This is NOT the same x! The x variable is being "shadowed", not mutated. *)
let x = 7

let f () =
  let x = 5 in
  ()

(* As an example, can you tell what `x`'s value is after running the function `f`? *)
f ();;
```

## Imperative Programming

Imperative programming is a programming paradigm that uses statements to change the program’s state. It's more about describing how things should happen, emphasizing the control flow of the program.

OCaml supports writing code using imperative style, but it's more often discouraged in favour of functional style. Still, in some situation, you might want to use an imperative style, for instance when performance is a concern.

### Mutability

In contrast to functional programming, imperative programming often involves mutable data. In the following example, we're using a reference to allow mutation. After calling the function `f`, `my_state` will hold the value `2`.

```ocaml
let my_state = ref 1

let f () =
  my_state := 2; (* updates the value in my_state *)
  ()

(* In contrast to the code above, can you guess the value of `my_state` after executing the function `f`? *)
f ();;
```

### For loops

In imperative programming, it's common to use loops to iterate over a collection of elements. Below, we use a `for` loop to iterate over a list of names and print a message for each name.

```ocaml
let names = ["Sabine"; "Cuihtlauac"; "everyone"]

let () =
  for i = 0 to List.length names - 1 do
    print_endline ("Hello " ^ List.nth names i ^ "!")
  done
```

Compare the above with the first code:

```ocaml
  let say_hello name = print_endline ("Hello " ^ name ^ "!")
  List.map say_hello ["Sabine"; "Cuihtlauac"; "everyone"];;
```

We see that the `for` loop utilizes an imperative style, describing exactly how the iteration should happen, whereas `List.map` utilizes a functional style, focusing on what operation should be applied to each element in the list.

Many functional programmers prefer using functional constructs like `List.map` over loops as it often leads to more readable and maintainable code, especially as the code base grows larger.
