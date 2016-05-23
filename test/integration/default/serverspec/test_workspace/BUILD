package(
    default_visibility = ["//visibility:public"],
)

cc_binary(
    name = "cc_hello",
    srcs = [
        "hello.cc",
    ],
)

java_binary(
    name = "java_hello",
    srcs = [
        "java/com/gengo/cookbook_bazel/test/JavaHello.java",
    ],
    main_class = "com.gengo.cookbook_bazel.test.JavaHello",
)

py_binary(
    name = "py2_hello",
    srcs = [
        "hello.py",
    ],
    main = "hello.py",
    srcs_version = "PY2AND3",
    default_python_version = "PY2",
)

py_binary(
    name = "py3_hello",
    srcs = [
        "hello.py",
    ],
    main = "hello.py",
    srcs_version = "PY2AND3",
    default_python_version = "PY3",
)
