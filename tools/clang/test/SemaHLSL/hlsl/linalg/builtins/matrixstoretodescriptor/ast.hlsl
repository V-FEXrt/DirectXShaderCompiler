// REQUIRES: dxil-1-10
// RUN: %dxc -T lib_6_10 -E main %s -ast-dump-implicit | FileCheck %s

// CHECK: FunctionDecl {{.*}} <<invalid sloc>> <invalid sloc> implicit used __builtin_LinAlg_MatrixStoreToDescriptor 'void (__builtin_LinAlg_Matrix, RWByteAddressBuffer, unsigned int, unsigned int, unsigned int)' extern
// CHECK-NEXT: ParmVarDecl {{.*}} res '__restrict __builtin_LinAlg_Matrix'
// CHECK-NEXT: ParmVarDecl {{.*}} buf 'RWByteAddressBuffer'
// CHECK-NEXT: ParmVarDecl {{.*}} offset 'unsigned int'
// CHECK-NEXT: ParmVarDecl {{.*}} stride 'unsigned int'
// CHECK-NEXT: ParmVarDecl {{.*}} layout 'unsigned int'
// CHECK-NEXT: HLSLIntrinsicAttr {{.*}} Implicit "op" "" 413
// CHECK-NEXT: AvailabilityAttr {{.*}} Implicit  6.10 0 0 ""

RWByteAddressBuffer outbuf;

[shader("compute")]
[numthreads(1,1,1)]
void main() {
  __builtin_LinAlg_Matrix mat;
  __builtin_LinAlg_MatrixStoreToDescriptor(mat, outbuf, 1, 2, 3);
}
