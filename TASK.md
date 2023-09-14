# Step 1 - Run the Web Server

1. Create a local opam switch

```
$ opam switch create . 5.0.0 --no-install
```

2. Install dependencies

```
$ opam install . --deps-only
```

3. Run the web server

```
$ opam exec -- dune exec main
```

```
14.09.23 13:35:33.385                       Running at http://localhost:8080
14.09.23 13:35:33.385                       Type Ctrl+C to stop
```

4. Open http://localhost:8080 in your browser

You should see a page that says "Hello world!"