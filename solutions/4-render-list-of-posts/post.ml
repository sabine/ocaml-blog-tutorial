type t = { title : string; slug : string; html_body : string }

let all =
  [
    {
      title = "Hello I am the first post!";
      slug = "hello";
      html_body = "<p>I just wanted to say hi!</p>";
    };
    {
      title = "It's a nice day";
      slug = "nice-day";
      html_body = "<p>Don't you think so, too?</p>";
    };
    {
      title = "Hello I am the third post!";
      slug = "third-post";
      html_body = "<p>See you later!</p>";
    };
  ]
