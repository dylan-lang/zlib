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
    (string :: <string>, #key level :: <integer> = 6)
 => (compressed :: <string>)
  let string-size    = string.size;
  let estimated-size = z-compress-bound(string-size);
  let compressed     = make(<string>, size: estimated-size);
  let actual-size    = make(<C-unsigned-long*>);
  actual-size.pointer-value := estimated-size;

  let status-code = z-compress-2(compressed,
				 actual-size,
				 string,
				 string-size,
				 level);

  unless (status-code = $z-ok)
    zlib-abort(status-code)
  end;

  copy-sequence(compressed, end: actual-size.pointer-value);
end zlib-compress;

define function zlib-uncompress
    (compressed :: <string>, length :: <integer>)
 => (string :: <string>)
  // allocate uncompressed string of expected 'length'
  let string      = make(<string>, size: length);
  let string-size = make(<C-unsigned-long*>);
  string-size.pointer-value := length;

  let status-code = z-uncompress(string,
				 string-size,
				 compressed,
				 compressed.size);

  unless (status-code = $z-ok)
    zlib-abort(status-code)
  end;

  string
end zlib-uncompress;
