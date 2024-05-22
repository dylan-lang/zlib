Module: dylan-user

define library zlib-test-suite
  use common-dylan;
  use testworks;
  use io;
  use zlib;
end library;

define module zlib-test-suite
  use common-dylan;
  use testworks;
  use format-out;
  use zlib;
  use zlib-impl;
end module;
