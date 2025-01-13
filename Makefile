include .env

export:
	./export.sh bazel-bin exported

export-drive:
	./export.sh bazel-bin $(DRIVE)
