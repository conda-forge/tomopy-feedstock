#!/usr/bin/env python3

"""Download and run the cudatoolkit installer for Linux."""

import argparse
import os
import stat
import subprocess

import conda.exports

# URLs for the cuda installer
urls = {
    "9.0": "https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run",
    "9.2": "https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux",
    "10.0": "https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux",
    "10.1": "https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.168_418.67_linux.run",
}


def install_cudatoolkit(version):

    if version not in urls:
        raise ValueError(
            "The URL for cuda version {} is missing".format(version)
        )

    print("Download the CUDA toolkit installer and fix permissions.")
    cuda_installer = "cuda_" + version + "_installer.run"
    if not os.path.exists(cuda_installer):
        conda.exports.download(urls[version], cuda_installer)
    os.chmod(cuda_installer, stat.S_IXUSR | stat.S_IRUSR)

    # Grab the toolkit install location from the environment
    if "CUDA_TOOLKIT_ROOT_DIR" in os.environ:
        CUDA_TOOLKIT_ROOT_DIR = os.environ["CUDA_TOOLKIT_ROOT_DIR"]
    else:
        CUDA_TOOLKIT_ROOT_DIR = os.path.join(os.environ["HOME"],
                                             "cuda-" + version)

    print("Link the conda compilers to a place that CUDA will find them.")
    print(os.environ["CC"] +
          " links to " +
          os.path.join(CUDA_TOOLKIT_ROOT_DIR, "bin", "gcc"))
    os.makedirs(os.path.join(CUDA_TOOLKIT_ROOT_DIR, "bin"), exist_ok=True)
    try:
        os.symlink(
            os.environ["CC"],
            os.path.join(CUDA_TOOLKIT_ROOT_DIR, "bin", "gcc")
        )
        os.symlink(
            os.environ["CXX"],
            os.path.join(CUDA_TOOLKIT_ROOT_DIR, "bin", "g++")
        )
    except FileExistsError:
        # The links already exist
        pass

    # Set parameters for the cuda installer
    parameters = {
        "9.0": [
            "--silent", "--toolkit", "--no-opengl-libs", "--no-man-page",
            "--no-drm", "--toolkitpath=" + CUDA_TOOLKIT_ROOT_DIR,
        ],
        "9.2": [
            "--silent", "--toolkit", "--no-opengl-libs", "--no-man-page",
            "--no-drm", "--toolkitpath=" + CUDA_TOOLKIT_ROOT_DIR,
        ],
        "10.0": [
            "--silent", "--toolkit", "--no-opengl-libs", "--no-man-page",
            "--no-drm", "--toolkitpath=" + CUDA_TOOLKIT_ROOT_DIR,
        ],
        "10.1": [
            "--silent", "--toolkit", "--no-opengl-libs", "--no-man-page",
            "--no-drm", "--toolkitpath=" + CUDA_TOOLKIT_ROOT_DIR,
            "--defaultroot=" + CUDA_TOOLKIT_ROOT_DIR,
        ],
    }
    print(" ".join(["./" + cuda_installer] + parameters[version]))
    subprocess.run(["./" + cuda_installer] + parameters[version], check=True)
    # with open("install_cuda.sh", "w") as f:
    #     f.write(" ".join([cuda_installer] + parameters[version]))
    # os.chmod("install_cuda.sh", stat.S_IXUSR | stat.S_IRUSR | stat.S_IWUSR)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("version", action="store", type=str)
    results = parser.parse_args()
    args = vars(results)
    install_cudatoolkit(**args)
