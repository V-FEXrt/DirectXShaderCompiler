// REQUIRES: dxil-1-10
// RUN: %dxc -T lib_6_10 -E main %s -ast-dump-implicit | FileCheck %s

// CHECK: FunctionDecl {{[^ ]+}} <<invalid sloc>> <invalid sloc> implicit used __builtin_LinAlg_MatrixStoreToDescriptor 'void (__builtin_LinAlg_Matrix, RWByteAddressBuffer, unsigned int, unsigned int, unsigned int)' extern
// CHECK-NEXT: ParmVarDecl {{[^ ]+}} <<invalid sloc>> <invalid sloc> res '__restrict __builtin_LinAlg_Matrix'
// CHECK-NEXT: ParmVarDecl {{[^ ]+}} <<invalid sloc>> <invalid sloc> buf 'RWByteAddressBuffer'
// CHECK-NEXT: ParmVarDecl {{[^ ]+}} <<invalid sloc>> <invalid sloc> offset 'unsigned int'
// CHECK-NEXT: ParmVarDecl {{[^ ]+}} <<invalid sloc>> <invalid sloc> stride 'unsigned int'
// CHECK-NEXT: ParmVarDecl {{[^ ]+}} <<invalid sloc>> <invalid sloc> layout 'unsigned int'
// CHECK-NEXT: HLSLIntrinsicAttr {{[^ ]+}} <<invalid sloc>> Implicit "op" "" 413
// CHECK-NEXT: AvailabilityAttr {{[^ ]+}} <<invalid sloc>> Implicit  6.10 0 0 ""

RWByteAddressBuffer outbuf;

[shader("compute")]
[numthreads(1,1,1)]
void main() {
  __builtin_LinAlg_Matrix mat;
  __builtin_LinAlg_MatrixStoreToDescriptor(mat, outbuf, 1, 2, 3);
}
