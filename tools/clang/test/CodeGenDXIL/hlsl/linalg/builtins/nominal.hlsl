// REQUIRES: dxil-1-10
// RUN: %dxc -T cs_6_10 -E main %s | FileCheck %s

ByteAddressBuffer inbuf;
RWByteAddressBuffer outbuf;

[numthreads(1,1,1)]
void main() {
  // CHECK-LABEL: define void @main()

  // CHECK: %{{.*}} = call %dx.types.LinAlgMatrixA0B1C2D3 @dx.op.linAlgFillMatrix.mA0B1C2D3.i32(i32 -2147483636, i32 5)  ; LinAlgFillMatrix(value)
  __builtin_LinAlg_Matrix mat1;
  __builtin_LinAlg_FillMatrix(mat1, 5);
  // CHECK: %{{.*}} = call %dx.types.LinAlgMatrixA0B1C2D3 @dx.op.linAlgFillMatrix.mA0B1C2D3.f32(i32 -2147483636, float {{.*}})  ; LinAlgFillMatrix(value)
  __builtin_LinAlg_Matrix mat2;
  __builtin_LinAlg_FillMatrix(mat2, 3.14);

  // CHECK: call void @dx.op.linAlgMatrixStoreToDescriptor.mA0B1C2D3(i32 -2147483628, %dx.types.LinAlgMatrixA0B1C2D3 {{.*}}, %dx.types.Handle %{{.*}}, i32 1, i32 1, i32 0)  ; LinAlgMatrixStoreToDescriptor(matrix,handle,offset,stride,layout)
  __builtin_LinAlg_MatrixStoreToDescriptor(mat1, outbuf, 1, 1, 0);

  // CHECK: %{{.*}} = call %dx.types.LinAlgMatrixA0B1C2D3 @dx.op.linAlgMatrixLoadFromDescriptor.mA0B1C2D3(i32 -2147483634, %dx.types.Handle %{{.*}}, i32 0, i32 0, i32 0)  ; LinAlgMatrixLoadFromDescriptor(handle,offset,stride,layout)
  __builtin_LinAlg_Matrix mat3;
  __builtin_LinAlg_MatrixLoadFromDescriptor(mat3, inbuf, 0, 0, 0);


  // CHECK: call <4 x float> @dx.op.linAlgMatVecMul.v4f32.mA0B1C2D3.v4f32(i32 -2147483623, %dx.types.LinAlgMatrixA0B1C2D3 %{{.*}}, <4 x float> <float 1.000000e+00, float 2.000000e+00, float 3.000000e+00, float 4.000000e+00>, i32 1)  ; LinAlgMatVecMul(matrix,inputVector,interpretation)
  float4 vec = {1,2,3,4};
  float4 result;
  __builtin_LinAlg_MatrixVectorMultiply(result, mat1, vec, 1);

  // CHECK: call <4 x float> @dx.op.linAlgMatVecMulAdd.v4f32.mA0B1C2D3.v4f32.v4f32(i32 -2147483622, %dx.types.LinAlgMatrixA0B1C2D3 %{{.*}}, <4 x float> <float 1.000000e+00, float 2.000000e+00, float 3.000000e+00, float 4.000000e+00>, i32 1, <4 x float> %{{.*}}, i32 0)  ; LinAlgMatVecMulAdd(matrix,inputVector,inputInterpretation,biasVector,biasInterpretation)
  __builtin_LinAlg_MatrixVectorMultiplyAdd(result, mat2, vec, 1, result, 0);
}
