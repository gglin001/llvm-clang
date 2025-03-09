#!/bin/bash

LLVM_SHA="release/20.x"
LLVM_REPO="https://github.com/llvm/llvm-project.git"

git clone -n --depth=1 --filter=tree:0 $LLVM_REPO llvm-project
pushd llvm-project
git sparse-checkout set --no-cone \
  /clang /cmake /libunwind /lld /llvm \
  '!/clang/test' '!/clang/unittests' '!/clang/docs' '!/clang/www' \
  '!/llvm/test' '!/llvm/unittests' '!/llvm/docs' \
  '!/lld/test' \
  '/*.*'
git sparse-checkout add \
  '!/llvm/lib/Target' '/llvm/lib/Target/*.*' \
  '/llvm/lib/Target/RISCV' '/llvm/lib/Target/ARM' '/llvm/lib/Target/AArch64' \
  '/llvm/lib/Target/X86'
git fetch --depth 1 origin $LLVM_SHA
git checkout
popd
