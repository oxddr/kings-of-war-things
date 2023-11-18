OpenSCADLibraryInfo = provider()

def _srcs(ctx, src = None):
    direct = []
    if hasattr(ctx.attr, "srcs"):
        direct.extend(ctx.files.srcs)
    if src:
        direct.append(src)
    transitive = []
    for d in ctx.attr.deps:
        if OpenSCADLibraryInfo in d:
            transitive.append(d[OpenSCADLibraryInfo].srcs)
        else:
            direct.append(d.file)
    return depset(direct = direct, transitive = transitive)

def _lib_impl(ctx):
    return [OpenSCADLibraryInfo(srcs = _srcs(ctx), includes = ctx.files.srcs)]

openscad_library = rule(
    implementation = _lib_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [
            ".scad",
            ".stl",
            ".off",
            ".dxf",
            ".Scad",
            ".Stl",
            ".Off",
            ".Dxf",
            ".SCAD",
            ".STL",
            ".OFF",
            ".DXF",
        ]),
        "deps": attr.label_list(providers = [OpenSCADLibraryInfo]),
    },
)

def _artifact_impl(ctx):
    args = ctx.actions.args()
    args.add("--hardwarnings")
    args.add("-o")
    args.add(ctx.outputs.out.path)
    if ctx.attr.type == "png":
        args.add("--render")
    args.add(ctx.file.src.path)
    ctx.actions.run(
        outputs = [ctx.outputs.out],
        inputs = _srcs(ctx, ctx.file.src),
        executable = ctx.executable._openscad,
        arguments = [args],
        mnemonic = "OpenSCAD",
        env = {"OPENSCADPATH": ":".join([".", ctx.bin_dir.path, ctx.genfiles_dir.path])},
    )

openscad_artifact = rule(
    implementation = _artifact_impl,
    attrs = {
        "deps": attr.label_list(providers = [OpenSCADLibraryInfo]),
        "src": attr.label(allow_single_file = [".scad"], mandatory = True),
        "type": attr.string(default = "stl", values = ["stl", "off", "dxf", "csg"]),
        "_openscad": attr.label(cfg = "exec", executable = True, allow_files = True, default = Label("//tools:openscad")),
    },
    outputs = {
        "out": "%{name}.%{type}",
    },
)
