type t = { title : string; slug : string; html_body : string; image : string }

let all =
  [
    {
      title = "Hello I am the first post!";
      slug = "hello";
      html_body = "<p>I just wanted to say hi!</p>";
      image = "computer-4484282_1280.jpg";
    };
    {
      title = "It's a nice day";
      slug = "nice-day";
      html_body = "<p>Don't you think so, too?</p>";
      image = "man-791049_1280.jpg";
    };
    {
      title = "Hello I am the third post!";
      slug = "third-post";
      html_body = "<p>See you later!</p>";
      image = "work-3938876_1280.jpg";
    };
  ]
