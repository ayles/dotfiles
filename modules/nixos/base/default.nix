{ mylib, ... }:
{
  imports = (mylib.scanPaths ./.);
}