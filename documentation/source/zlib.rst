zlib
====

This module uses :doc:`zlib-binding` to create a more idiomatic Open
Dylan API to zlib.

.. current-library:: zlib
.. current-module:: zlib

Conditions
----------

.. class:: <zlib-error>

   Superclass of all error types signaled by the zlib library.

   :superclasses: :drm:`<error>`

   :seealso:

      - :class:`<zlib-errno-error>`
      - :class:`<zlib-stream-error>`
      - :class:`<zlib-data-error>`
      - :class:`<zlib-data-error>`
      - :class:`<zlib-memory-error>`
      - :class:`<zlib-buffer-error>`
      - :class:`<zlib-version-error>`
      - :class:`<zlib-unexpected-error>`

.. class:: <zlib-errno-error>

   :superclasses: :class:`<zlib-error>`

.. class:: <zlib-stream-error>

   :superclasses: :class:`<zlib-error>`

   :seealso:

      See :const:`$z-stream-error`.

.. class:: <zlib-data-error>

   :superclasses: :class:`<zlib-error>`

   :seealso:

      See :const:`$z-data-error`.

.. class:: <zlib-memory-error>

   :superclasses: :class:`<zlib-error>`

   :seealso:

      See :const:`$z-mem-error`.

.. class:: <zlib-buffer-error>

   :superclasses: :class:`<zlib-error>`

   :seealso:

      See :const:`$z-buf-error`.

.. class:: <zlib-version-error>

   :superclasses: :class:`<zlib-error>`

   :seealso:

      See :const:`$z-version-error`.

.. class:: <zlib-unexpected-error>

   There was an unexpected error compressing or decompressing.

   :superclasses: :class:`<zlib-error>`

Compression / Uncompression
---------------------------

``zlib-compress``
^^^^^^^^^^^^^^^^^

.. function:: zlib-compress

  :signature:

     zlib-compress *string* #key *level* => (*compressed*)

  :parameter string:

     An instance of :drm:`<string>`. String to compress.

  :parameter #key level:

     An instance of :drm:`<integer>`. A number between 0 and 9, from
     no compression to best compression. Use :const:`$z-best-speed`
     for best speed, :const:`$z-best-compression` for best
     compression. :const:`$z-no-compression` gives no compression at
     all. If absent, it uses :const:`$z-default-compression` as a
     compromise between speed and compression.

     :seealso:

        :ref:`Compression levels`

  :example:

     The following code compress a string with a
     :const:`$z-default-compression` level.

     .. code-block:: dylan

	let phrase = "A horse, a horse, my kingdom for a horse";
        let compressed = zlib-compress(phrase);
	format-out("Phrase size: %d Compressed size: %d\n",
	           phrase.size,
		   compressed.size);

     Now we compress the string using the maximum compression level
     (:const:`$z-best-compression`).

     .. code-block:: dylan

	let phrase = "Brevity is the soul of wit";
	let compressed = zlib-compress(phrase, level: $z-best-compression);

``zlib-uncompress``
^^^^^^^^^^^^^^^^^^^

.. function:: zlib-uncompress

   Uncompress a previously compressed string.

   :signature:

      zlib-uncompress *compressed* *length* => (*string*)

   :parameter compressed:

      An instance of :drm:`<string>`. A compressed string.

   :parameter length:

      An instance of :drm:`<integer>`. Length of the uncompressed
      string. The size of the uncompressed data must have been saved
      previously by the compressor.

   :value string:

      An instance of :drm:`<string>`. Uncompressed string.

   :example:

      .. code:: dylan

         let phrase = "A horse, a horse, my kingdom for a horse";
         let compressed = zlib-compress(phrase);
         let uncompressed = zlib-uncompress(compressed, phrase.size);
         format-out("Phrase: %s Uncompressed: %s\n", phrase, uncompressed);
