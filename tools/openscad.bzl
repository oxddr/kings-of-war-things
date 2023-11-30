OpenSCADLibraryInfo = provider()

def _module_file(ctx):
    file = ctx.actions.declare_file("%s.scad" % ctx.label.name)
    ctx.actions.write(
        file,
        "%s\n%s();\n" % (
            "\n".join([
                "use <%s>" % f.path
                for d in ctx.attr.deps
                if OpenSCADLibraryInfo in d
                for f in d[OpenSCADLibraryInfo].includes
            ]),
            ctx.attr.module if ctx.attr.module else ctx.label.name,
        ),
    )
    return file

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
    if ctx.attr.src and ctx.attr.module:
        fail("Cannot specify both src and module at the same time")
    src = ctx.file.src if ctx.attr.src else _module_file(ctx)

    args = ctx.actions.args()
    args.add("--hardwarnings")
    args.add("-o")
    args.add(ctx.outputs.out.path)
    if ctx.attr.type == "png":
        args.add("--render")
    args.add(src.path)
    if ctx.attr.defines:
        args.add_all(["-D %s=%s" % (k, ctx.attr.defines[k]) for k in ctx.attr.defines])
    ctx.actions.run(
        outputs = [ctx.outputs.out],
        inputs = _srcs(ctx, src),
        executable = ctx.executable._openscad,
        arguments = [args],
        mnemonic = "OpenSCAD",
        env = {"OPENSCADPATH": ":".join([".", ctx.bin_dir.path, ctx.genfiles_dir.path])},
    )

openscad_artifact = rule(
    implementation = _artifact_impl,
    attrs = {
        "deps": attr.label_list(providers = [OpenSCADLibraryInfo]),
        "src": attr.label(allow_single_file = [".scad"]),
        "module": attr.string(),
        "type": attr.string(default = "stl", values = ["stl", "off", "dxf", "csg", "svg"]),
        "defines": attr.string_dict(default = {}),
        "_openscad": attr.label(cfg = "exec", executable = True, allow_files = True, default = Label("//tools:openscad")),
    },
    outputs = {
        "out": "%{name}.%{type}",
    },
)
