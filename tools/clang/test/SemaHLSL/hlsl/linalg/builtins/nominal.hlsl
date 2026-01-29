// REQUIRES: dxil-1-10
// RUN: %dxc -T cs_6_10 -E main %s -verify

// expected-no-diagnostics

ByteAddressBuffer inbuf;
RWByteAddressBuffer outbuf;

[numthreads(1,1,1)]
void main() {
  __builtin_LinAlg_Matrix mat1;
  __builtin_LinAlg_FillMatrix(mat1, 5);
  __builtin_LinAlg_MatrixStoreToDescriptor(mat1, outbuf, 3, 2, 1);

  __builtin_LinAlg_Matrix mat2; 
  __builtin_LinAlg_MatrixLoadFromDescriptor(mat2, inbuf, 1, 2, 3);
}
