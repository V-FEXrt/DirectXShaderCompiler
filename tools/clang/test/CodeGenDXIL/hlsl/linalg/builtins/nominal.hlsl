// REQUIRES: dxil-1-10
// RUN: %dxc -T cs_6_10 -E main %s | FileCheck %s

RWByteAddressBuffer outbuf;

[numthreads(1,1,1)]
void main() {
  // CHECK-LABEL: define void @main()

  // CHECK: %{{.*}} = call %dx.types.LinAlgMatrixA0B1C2D3 @dx.op.fillMatrix.mA0B1C2D3.i32(i32 -2147483636, i32 {{.*}})  ; FillMatrix(value)
  __builtin_LinAlg_Matrix mat1;
  __builtin_LinAlg_FillMatrix(mat1, 5);
  // CHECK: %{{.*}} = call %dx.types.LinAlgMatrixA0B1C2D3 @dx.op.fillMatrix.mA0B1C2D3.f32(i32 -2147483636, float {{.*}})  ; FillMatrix(value)
  __builtin_LinAlg_Matrix mat2;
  __builtin_LinAlg_FillMatrix(mat2, 3.14);

  // CHECK: call void @dx.op.matrixStoreToDescriptor.mA0B1C2D3(i32 -2147483628, %dx.types.LinAlgMatrixA0B1C2D3 {{.*}}, %dx.types.Handle %4, i32 1, i32 1, i32 0)  ; MatrixStoreToDescriptor(matrix,handle,offset,stride,layout)

  __builtin_LinAlg_MatrixStoreToDescriptor(mat1, outbuf, 1, 1, 0);
}
