module: dylan-user

define library zlib
  use common-dylan;
  use c-ffi;

  export
    zlib,
    zlib-impl;
end library;

define module zlib
  create
    compress;
end module;

define module zlib-impl
  use common-dylan;
  use c-ffi;

  use zlib;

  export
    zlib-compress,
    zlib-compress-bound;
end module;
