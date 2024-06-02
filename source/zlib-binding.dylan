module: zlib-binding

// Utility functions

define C-function z-compress
  parameter destination :: <C-string>;
  parameter destination-length :: <C-unsigned-long*>;
  parameter source :: <C-string>;
  parameter source-length :: <C-unsigned-long>;
  result return-code :: <C-int>;
  c-name: "compress"
end;

define C-function z-compress-2
  parameter destination :: <C-string>;
  parameter destination-length :: <C-unsigned-long*>;
  parameter source :: <C-string>;
  parameter source-length :: <C-unsigned-long>;
  parameter level :: <C-int>;
  result return-code :: <C-int>;  
  c-name: "compress2"
end;

define C-function z-compress-bound
  parameter source-length :: <C-int>;
  result return-code :: <C-int>;
  c-name: "compressBound"
end;

define C-function z-uncompress
  parameter destination :: <C-string>;
  parameter destination-length :: <C-unsigned-long*>;
  parameter source :: <C-string>;
  parameter source-length :: <C-unsigned-long>;
  result return-code :: <C-int>;
  c-name: "uncompress"
end;
