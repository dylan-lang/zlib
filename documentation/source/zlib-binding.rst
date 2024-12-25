zlib-binding
============

This module creates Dylan bindings that directly reflect the zlib C library.


.. current-library:: zlib
.. current-module:: zlib-binding

Constants
---------

Flush values
^^^^^^^^^^^^

.. constant:: $z-no-flush

   :type: :drm:`<integer>`

.. constant:: $z-partial-flush

   :type: :drm:`<integer>`

.. constant:: $z-sync-flush

   :type: :drm:`<integer>`

.. constant:: $z-full-flush

   :type: :drm:`<integer>`

.. constant:: $z-finish

   :type: :drm:`<integer>`

.. constant:: $z-block

   :type: :drm:`<integer>`

.. constant:: $z-trees

   :type: :drm:`<integer>`

Return codes for (de)compression
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Positive values are used for special but normal events:

- :const:`$z-ok`
- :const:`$z-stream-end`
- :const:`$z-need-dict`

.. constant:: $z-ok

   The operation was a success.

   :type: :drm:`<integer>`

.. constant:: $z-stream-end

   The end of the compressed data has been reached and all
   uncompressed output has been produced.

   :type: :drm:`<integer>`

.. constant:: $z-need-dict

   A preset dictionary is needed.

   :type: :drm:`<integer>`

Negative values are errors:

- :const:`$z-errno`
- :const:`$z-stream-error`
- :const:`$z-data-error`
- :const:`$z-mem-error`
- :const:`$z-buf-error`
- :const:`$z-version-error`

.. constant:: $z-errno

   :type: :drm:`<integer>`

.. constant:: $z-stream-error

   The compression level is not valid.

   :type: :drm:`<integer>`

.. constant:: $z-data-error

   :type: :drm:`<integer>`

.. constant:: $z-mem-error

   There was not enough memory.

   :type: :drm:`<integer>`

.. constant:: $z-buf-error

   No progress was possible or there was not enough room in the
   output buffer when ``$z-finish`` was used.

   :type: :drm:`<integer>`

.. constant:: $z-version-error

   The z library version is incompatible with the version
   assumed by the caller.

   :type: :drm:`<integer>`

.. _Compression levels:

Compression levels
^^^^^^^^^^^^^^^^^^

The compression levels are a number between 0 and 9. 1 gives best
speed, 9 gives best compression, 0 gives no compression at all (all
the input is simply copied a block at a time).

.. constant:: $z-no-compression

   Uses no compression at all (all the input is simply copied a block
   at a time).

   :type: :drm:`<integer>`

.. constant:: $z-best-speed

   Gives better speed at the cost of less compression.

   :type: :drm:`<integer>`

.. constant:: $z-best-compression

   Best compression but less speed.

   :type: :drm:`<integer>`

.. constant:: $z-default-compression

   A compromise between speed and compression
   (currently equivalent to level 6).

   :type: :drm:`<integer>`

Compression strategy
^^^^^^^^^^^^^^^^^^^^

.. constant:: $z-filtered

   :type: :drm:`<integer>`

.. constant:: $z-huffman-only

   :type: :drm:`<integer>`

.. constant:: $z-rle

   :type: :drm:`<integer>`

.. constant:: $z-fixed

   :type: :drm:`<integer>`

.. constant:: $z-default-strategy

   :type: :drm:`<integer>`

Deflate data-type field values
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. constant:: $z-binary

   :type: :drm:`<integer>`

.. constant:: $z-text

   :type: :drm:`<integer>`

.. constant:: $z-ascii

   Default to :const:`$z-text` for compatibility with 1.2.2 and
   earlier.

   :type: :drm:`<integer>`

.. constant:: $z-unknown

   :type: :drm:`<integer>`

Others
^^^^^^

.. constant:: $z-deflated

   The deflate compression method (the only one supported in 
   this version).

   :type: :drm:`<integer>`

.. constant:: $z-null

   For initialization, null pointer.

Utility functions
-----------------

These functions are implemented on top of the basic zlib
stream-oriented functions. To simplify the interface, some default
options are assumed (compression level and memory usage).

``z-compress``
^^^^^^^^^^^^^^

.. function:: z-compress

   Compress a string.

   :signature:

      z-compress *string* *destination-length* *source* *source-length* => (return-code)

   :parameter destination:

      Destination buffer of the compressed string.
      An instance of :class:`<C-buffer-offset>`

   :parameter destination-length:

      Byte length of the destination buffer, which must be at least
      the value returned by :func:`z-compress-bound`. At exit it
      contains the actual size of compressed data. An instance of
      :class:`<C-unsigned-long*>`

   :parameter source:

      String to compress. An instance of :drm:`<string>`

   :parameter source-length:

      Byte length of the source buffer.
      An instance of :class:`<C-unsigned-long>`

   :value return-code:

      An instance of :drm:`<integer>`. Returns :const:`$z-ok` if
      success, :const:`$z-mem-error` if there was not enough memory,
      :const:`$z-buf-error` if there was not enough room in the output
      buffer.

   :discussion:

      It's equivalent to :func:`z-compress-2` with a *level* parameter
      :const:`$z-default-compression`.

``z-compress-2``
^^^^^^^^^^^^^^^^

.. function:: z-compress-2

   Compress a string.

   :signature:

      z-compress-2 *string* *destination-length* *source* *source-length* *level* => (*return-code*)

   :parameter destination:

      Destination buffer of the compressed string.
      An instance of :class:`<C-buffer-offset>`

   :parameter destination-length:

      Byte length of the destination buffer, which must be at least
      the value returned by :func:`z-compress-bound`. At exit it
      contains the actual size of compressed data. An instance of
      :drm:`<integer>`

   :parameter source:

      String to compress. An instance of :drm:`<string>`

   :parameter source-length:

      Byte length of the source buffer.
      An instance of :class:`<C-unsigned-long>`

   :parameter level:

      An instance of :drm:`<integer>`. The compression level must be
      :const:`$z-default-compression`, or a number between 0 and 9.

      :seealso:

	 See :ref:`Compression levels`.

   :value return-code:

      An instance of :drm:`<integer>`. Returns :const:`$z-ok` if
      success, :const:`$z-mem-error` if there was not enough memory,
      :const:`$z-buf-error` if there was not enough room in the output
      buffer.

``z-compress-bound``
^^^^^^^^^^^^^^^^^^^^

.. function:: z-compress-bound

   Returns an upper bound on the compressed size after
   :func:`z-compress` or :func:`z-compress-2` on *source-length*
   bytes. It would be used before a :func:`z-compress` or
   :func:`z-compress-2` call to allocate the destination buffer.

   :signature:

      z-compress-bound *source-length* => (*return-code*)

   :parameter source-length:

      An instance of :drm:`<integer>`. Is the length in bytes of the
      source buffer.

   :value return-code:

      An instance of :drm:`<integer>`. Number of bytes of the upper
      bound.

``z-uncompress``
^^^^^^^^^^^^^^^^

.. function:: z-uncompress

   Uncompress a previously compressed string.

   :signature:

      z-uncompress *destination* *destination-length* *source* *source-length* => (*return-code*)

   :parameter destination:

      An instance of :drm:`<string>`. Destination of uncompressed *source*.

   :parameter destination-length:

      An instance of :drm:`<integer>`. Upon entry is the total size of
      the destination buffer, which must be large enough to hold the
      entire uncompressed data. The size of the uncompressed data must
      have been saved previously by the compressor and transmitted to
      the decompressor by some mechanism outside the scope of this
      compression library. Upon exit, *destination-length* is the
      actual size of the compressed data.

   :parameter source:

      An instance of :drm:`<string>`. Compressed string.

   :parameter source-length:

      An instance of :drm:`<integer>`. Byte length of the source
      buffer.

   :value return-code:

      An instance of :drm:`<integer>`. Returns :const:`$z-ok` if
      success, :const:`$z-mem-error` if there was not enough memory,
      :const:`$z-buf-error` if there was not enough room in the output
      buffer, or :const:`$z-data-error` if the input data was corrupted or
      incomplete. In the case where there is not enough room, this
      function will fill the output buffer with the uncompressed data
      up to that point.

``z-uncompress-2``
^^^^^^^^^^^^^^^^^^

.. function:: z-uncompress-2

   Uncompress a previously compressed string. Same as
   :func:`z-uncompress`, except that *source-length* is a pointer,
   where the length of the source is *source-length*. On return
   *source-length* is the number of source bytes consumed.

   :signature:

      z-uncompress-2 *destination* *destination-length* *source* *source-length* => (*return-code*)

   :parameter destination:

      An instance of :drm:`<string>`. Destination of uncompressed *source*.

   :parameter destination-length:

      An instance of :drm:`<integer>`. Upon entry is the total size of
      the destination buffer, which must be large enough to hold the
      entire uncompressed data. The size of the uncompressed data must
      have been saved previously by the compressor and transmitted to
      the decompressor by some mechanism outside the scope of this
      compression library. Upon exit, *destination-length* is the
      actual size of the compressed data.

   :parameter source:

      An instance of :drm:`<string>`. Compressed string.

   :parameter source-length:

      An instance of :drm:`<integer>`. On return is the number of
      source bytes consumed.

   :value return-code:

      An instance of :drm:`<integer>`. Returns :const:`$z-ok` if
      success, :const:`$z-mem-error` if there was not enough memory,
      :const:`$z-buf-error` if there was not enough room in the output
      buffer, or :const:`$z-data-error` if the input data was
      corrupted or incomplete. In the case where there is not enough
      room, this function will fill the output buffer with the
      uncompressed data up to that point.
