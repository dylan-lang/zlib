Module: zlib-test-suite

define test compress-test ()
  let compressed = compress("Hello");
end test;

// Use `_build/bin/hello-world-test-suite --help` to see options.
run-test-application()
