Module: zlib-test-suite

define test compress-test ()
  // stupid test until uncompress is working
  let compressed = compress("A horse, a horse, my kingdom for a horse");
  expect-equal(30, compressed.size);
end test;

// Use `_build/bin/hello-world-test-suite --help` to see options.
run-test-application()
