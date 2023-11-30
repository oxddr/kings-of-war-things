load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_dependencies():
    go_repository(
        name = "com_github_hschendel_stl",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/hschendel/stl",
        sum = "h1:DXT5rkiXMUkbKw4Ndi1OYZ/a5SLR35TzxGj46p5Qyf8=",
        version = "v1.0.4",
    )
