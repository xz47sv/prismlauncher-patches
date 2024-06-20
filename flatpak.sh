#!/bin/sh

set -ex

# optionally take directory as argument
src="$(readlink -f "$(dirname "${0}")")"
dest="$(readlink -f "${1:-.}")"
if [ "${src}" != "${dest}" ]; then
    cp -f "${src}/"{curseforge,offline}.patch "${dest}"
    cd "${dest}"
fi

yq -iy "$(
    cat << EOF
.modules[] |= (
    select((type == "object") and (.name == "prismlauncher")).sources += [
        {
            "type": "patch",
            "path": "offline.patch"
        },
        {
            "type": "patch",
            "path": "curseforge.patch"
        }
    ]
)
EOF
)" org.prismlauncher.PrismLauncher.yml

flatpak-builder \
    --force-clean \
    --sandbox \
    --install-deps-from=flathub \
    --user \
    --assumeyes \
    build \
    org.prismlauncher.PrismLauncher.yml

flatpak build-export -v export build
flatpak \
    build-bundle \
    -v \
    export \
    prismlauncher.flatpak \
    org.prismlauncher.PrismLauncher
