module: zlib-impl

define class <zlib-error> (<error>) end;
define class <zlib-errno-error> (<zlib-error>) end;
define class <zlib-stream-error> (<zlib-error>) end;
define class <zlib-data-error> (<zlib-error>) end;
define class <zlib-memory-error> (<zlib-error>) end;
define class <zlib-buffer-error> (<zlib-error>) end;
define class <zlib-version-error> (<zlib-error>) end;
define class <zlib-unexpected-error> (<zlib-error>) end;

define function zlib-abort
    (code :: <integer>) => ()
  local method condition-of
	    (code) => (result)
	  select (code)
	    $z-errno
	      => <zlib-errno-error>;
	    $z-stream-error
	      => <zlib-stream-error>;
	    $z-data-error
	      => <zlib-data-error>;
	    $z-mem-error
	      => <zlib-memory-error>;
	    $z-buf-error
	      => <zlib-buffer-error>;
	    $z-version-error
	      => <zlib-version-error>;
	    otherwise
	      => <zlib-unexpected-error>
	  end select
	end method;
  signal(make(condition-of(code)))
end zlib-abort;

define function zlib-compress
    (data, #key level :: <integer> = $z-default-compression)
 => (compressed :: <byte-vector>)
  let estimated-size = z-compress-bound(data.size);
  let buffer = make(<byte-vector>, size: estimated-size);
  let actual-size = make(<C-unsigned-long*>);
  actual-size.pointer-value := estimated-size;
  let destination = byte-storage-address(buffer);
  let source = byte-storage-address(data);

  let status = z-compress-2(destination, actual-size, source, data.size, level);
  unless (status = $z-ok)
    zlib-abort(status)
  end;

  let compressed-size = actual-size.pointer-value;
  let compressed = make(<byte-vector>, size: compressed-size);
  copy-bytes(compressed, 0, buffer, 0, compressed-size);
  compressed
end zlib-compress;

define function zlib-uncompress
    (compressed :: <byte-vector>, length :: <integer>)
 => (uncompressed :: <byte-vector>)
  let uncompressed = make(<byte-vector>, size: length);
  let uncompressed-size = make(<C-unsigned-long*>);
  uncompressed-size.pointer-value := length;
  let destination = byte-storage-address(uncompressed);
  let source = byte-storage-address(compressed);

  let status = z-uncompress(destination, uncompressed-size, source, compressed.size);
  unless (status = $z-ok)
    zlib-abort(status)
  end;

  uncompressed
end zlib-uncompress;
