Reference
=========

.. current-library:: zlib
.. current-module:: zlib		     

Utility functions
-----------------

These functions are implemented on top of the basic zlib
stream-oriented functions. To simplify the interface, some default
options are assumed (compression level and memory usage).


.. function:: compress

   Compress a string.

   :signature: compress *string* => (compressed-string)

   :parameter string: String to compress. An instance of :drm:`<string>`
   :value compressed-string: An instance of :drm:`<string>`

   :description:

   Compress the source string into a new string. If there is a problem
   in the compression process it raises an error.

   :example:

   .. code-block:: dylan

      let compressed = compress("Hello");
