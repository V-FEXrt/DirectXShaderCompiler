// REQUIRES: dxil-1-10
// RUN: %dxc -T lib_6_10 -E main %s -ast-dump-implicit | FileCheck %s

// CHECK: FunctionDecl {{.*}} implicit used __builtin_LinAlg_FillMatrix 'void (__builtin_LinAlg_Matrix, unsigned int)' extern
// CHECK-NEXT: ParmVarDecl {{.*}} ret '__restrict __builtin_LinAlg_Matrix'
// CHECK-NEXT: ParmVarDecl {{.*}} value 'unsigned int'
// CHECK-NEXT: HLSLIntrinsicAttr {{.*}} Implicit "op" "" 406
// CHECK-NEXT: AvailabilityAttr {{.*}} Implicit  6.10 0 0 ""

[shader("compute")]
[numthreads(1,1,1)]
void main() {
  __builtin_LinAlg_Matrix mat;
  __builtin_LinAlg_FillMatrix(mat, 15);
}
