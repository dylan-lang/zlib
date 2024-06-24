module: zlib-binding

// Allowed flush values; see deflate() and inflate() below for details.

define constant $z-no-flush = 0;
define constant $z-partial-flush = 1;
define constant $z-sync-flush = 2;
define constant $z-full-flush = 3;
define constant $z-finish = 4;
define constant $z-block = 5;
define constant $z-trees = 6;

// Return codes for the compression/decompression functions.

define constant $z-ok = 0;
define constant $z-stream-end = 1;
define constant $z-need-dict = 2;
define constant $z-errno = -1;
define constant $z-stream-error = -2;
define constant $z-data-error = -3;
define constant $z-mem-error = -4;
define constant $z-buf-error = -5;
define constant $z-version-error = -6;

// Compression levels

define constant $z-no-compression = 0;
define constant $z-best-speed = 1;
define constant $z-best-compression = 9;
define constant $z-default-compression = -1;

// Compression strategy — see deflateInit2() below for details.

define constant $z-filtered = 1;
define constant $z-huffman-only = 2;
define constant $z-rle = 3;
define constant $z-fixed = 4;
define constant $z-default-strategy = 0;

// Possible values of the data_type field for deflate().

define constant $z-binary = 0;
define constant $z-text = 1;
define constant $z-ascii = $z-text;   // for compatibility with 1.2.2 and earlier 
define constant $z-unknown = 2;

// The deflate compression method (the only one supported in this version).

define constant $z-deflated = 8;

// For initializing zalloc, zfree, opaque.

define constant $z-null = null-pointer(<C-function-pointer>);
