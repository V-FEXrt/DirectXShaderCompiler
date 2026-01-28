// RUN: %dxc -T cs_6_9 -E main %s -verify

[numthreads(4,1,1)]
void main() {
  // expected-error@+1{{potential misuse of built-in type '__builtin_LinAlg_Matrix' in shader model cs_6_9; introduced in shader model 6.10}}
  __builtin_LinAlg_Matrix mat;

  // expected-error@+1{{intrinsic __builtin_LinAlg_FillMatrix potentially used by ''main'' requires shader model 6.10 or greater}}
  __builtin_LinAlg_FillMatrix(mat, 1);
}
