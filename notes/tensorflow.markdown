``` shell
brew uninstall --force bazel
brew install bazel
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
pip install /tmp/tensorflow_pkg/tensorflow-1.10.0-cp36-cp36m-macosx_10_13_x86_64.whl 
cd ..
```

