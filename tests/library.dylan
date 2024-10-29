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

  use zlib;
  use zlib-impl;
  use zlib-binding;
end module;
