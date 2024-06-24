module: dylan-user

define library zlib
  use common-dylan;
  use c-ffi;

  export
    zlib-binding,
    zlib,
    zlib-impl;
end library;

define module zlib-binding
  use common-dylan;
  use c-ffi;

  // Allowed flush values

  export
    $z-no-flush,
    $z-partial-flush,
    $z-sync-flush,
    $z-full-flush,
    $z-finish,
    $z-block,
    $z-trees;

  // Return codes for compression/decompression functions

  export
    $z-ok,
    $z-stream-end,
    $z-need-dict,
    $z-errno,
    $z-stream-error,
    $z-data-error,
    $z-mem-error,
    $z-buf-error,
    $z-version-error;

  // Compression levels

  export
    $z-no-compression,
    $z-best-speed,
    $z-best-compression,
    $z-default-compression;

  // Compression strategy — see deflateInit2() for details.

  export
    $z-filtered,
    $z-huffman-only,
    $z-rle,
    $z-fixed,
    $z-default-strategy;

  // Possible values of the data_type field for deflate().

  export
    $z-binary,
    $z-text,
    $z-ascii,
    $z-unknown;

  // The deflate compression method (the only one supported in this version).

  export
    $z-deflated;

  // For initializing zalloc, zfree, opaque.
  export
    $z-null;

  // Utility functions

  export
    z-compress,
    z-compress-2,
    z-compress-bound,
    z-uncompress;
end module;

define module zlib
  create
    $z-no-compression,
    $z-best-speed,
    $z-best-compression,
    $z-default-compression;
  
  create
    <zlib-error>,
    <zlib-errno-error>,
    <zlib-stream-error>,
    <zlib-data-error>,
    <zlib-memory-error>,
    <zlib-buffer-error>,
    <zlib-version-error>;

  create
    zlib-compress,
    zlib-uncompress;
end module;

define module zlib-impl
  use common-dylan;
  use c-ffi;
  use zlib;
  use zlib-binding;

  export
    zlib-abort;
end module;

