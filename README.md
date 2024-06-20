# Personal PrismLauncher Patches

-   [List of patches](list-of-patches)
-   [Downloads](#downloads)
-   [Building](#building)
    -   [From source](#from-source)
    -   [Flatpak](#flatpak)
    -   [Other build systems](#other-build-systems)

## List of patches

-   curseforge.patch: bypass thir party download blocking
-   offline.patch: don't require a valid account to play

## Downloads

You have to build yourself, there will be no prebuilt binaries available,
because these patches bypass restrictions and I am not willing to risk legal
issues (however unlikely).

## Building

### From source

To build from source follow the [official build
instructions](https://prismlauncher.org/wiki/development/build-instructions/)
and just apply these two patches to the git repository after cloning.

### Flatpak

Make sure you have the following dependencies installed:

-   flatpak-builder
-   yq
-   xz

The commands below will clone this repo, repo of the official PrismLauncher
flatpak, apply a patch to it and then build the flatpak. This might pull in
additinal flatpak dependencies according to the manifest file.

```bash
git clone https://git.ash.fail/prismlauncher-offline
git clone https://github.com/flathub/org.prismlauncher.PrismLauncher
cd org.prismlauncher.PrismLauncher
git submodule update --init --recursive
../prismlauncher-offline/flatpak.sh
```

_NOTE: flatpak.sh modifies the manifest file, `git resest` it on consecutive
rebuilds._

Afterwards you can then install the flatpak with:

```bash
flatpak install prismlauncher.flatpak
```

NOTE: add `--user` for non-system installation

### Other build systems

I personally use flatpak, so there is a script for that, you are free to submit
build steps for other build systems and I will add them here.
