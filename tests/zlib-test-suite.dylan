Module: zlib-test-suite

define test error-code-signal-condition-test ()
  expect-condition(<zlib-errno-error>, zlib-abort($z-errno));
  expect-condition(<zlib-stream-error>, zlib-abort($z-stream-error));
  expect-condition(<zlib-data-error>, zlib-abort($z-data-error));
  expect-condition(<zlib-memory-error>, zlib-abort($z-mem-error));
  expect-condition(<zlib-buffer-error>, zlib-abort($z-buf-error));
  expect-condition(<zlib-version-error>, zlib-abort($z-version-error));
end test;

define test compress-uncompress-idempotence-test ()
  let phrase       = "A horse, a horse, my kingdom for a horse";
  let compressed   = zlib-compress(phrase);
  let uncompressed = zlib-uncompress(compressed, phrase.size);
  assert-equal(phrase, uncompressed)
end test;

define test compression-level-test ()
  let quote
    = """
          My liege, and madam, to expostulate
          What majesty should be, what duty is,
          What day is day, night night, and time is time,
          Were nothing but to waste night, day, and time;
          Therefore, since brevity is the soul of wit,
          And tediousness the limbs and outward flourishes,
          I will be brief. Your noble son is mad…
          """;

  let no-compression  = zlib-compress(quote, level: $z-no-compression);
  let def-compression = zlib-compress(quote);
  let max-compression = zlib-compress(quote, level: $z-best-compression);

  expect-true(no-compression.size >= quote.size,
	      "No compression can be bigger than original");

  expect-true(def-compression.size < no-compression.size,
	      "Default compression is better than no compression");

  expect-true(max-compression.size < no-compression.size,
	      "Max compression is better than no compression");

  expect-true(def-compression.size <= max-compression.size,
	      "Default compression can be similar to max compression");

end test;

// Use `_build/bin/hello-world-test-suite --help` to see options.
run-test-application()
