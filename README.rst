Zlib
====

Opendylan binding around Zlib library.

Building
--------

Install development libraries

.. code-block:: console

   $ sudo apt install zlib1g-dev

Download dependencies:

.. code-block:: console

   $ dylan update

Build:

.. code-block:: console

   $ dylan build --all

Run tests:

.. code-block:: console

   $ _build/bin/zlib-test-suite
