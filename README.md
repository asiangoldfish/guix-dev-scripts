# guix-dev-scripts

A collection of scripts for developing [SystoleOS](https://github.com/SystoleOS/guix-systole).

## Usage
Include the scripts to your Guix development environment:

1. Clone the repository:
    ```cmd
    git clone https://github.com/asiangoldfis/guix-dev-scripts.git
    ```
2. Add the repository to your PATH. Example for Bash:
    ```cmd
    echo 'PATH=$PATH:/path/to/guix-dev-scripts' >> "$HOME/.bashrc"
    ```

The following scripts are now available:
- systole-dev
- log
- delpkg

Please read the help page before using the scripts. Some of them, like [`delpkg`](./delpkg), will take effect without confirmation unless the `delpkg help` is used.

## Guix Shell
Enabling the Guix shell is part of the [`systole-dev`](./systole-dev) script.
The following packages are currently supported.

- [slicer-5.8](#slicer-58)

Before using the script, the script comes with a configuration file. It is expected to be in `$XDG_CONFIG_HOME`. Currently, the implementations will use `$HOME/.config`. Future patches will enforce the usage of `$XDG_CONFIG_HOME` with fallback options.

Generate the configuration files in `$XDG_CONFIG_HOME`:
```
systole-dev generate-config
```

### slicer-5.8
Enable a guix shell for building `slicer-5.8` from source with the following steps:

1. Clone [SystoleOS/guix-systole](https://github.com/SystoleOS/guix-systole.git)
  ```
  git clone https://github.com/SystoleOS/guix-systole
  ```
2. Edit `$XDG_CONFIG_HOME/guix-dev-scripts/systole-dev.cfg` and add the new *guix-systole* to `GUIX_SYSTOLE_DIR`. Also have a look at other variables and change them to your own preferences.
3. Change directory to a location where you will clone SystoleOS' fork of [3D Slicer](https://github.com/Slicer/Slicer.git). Both the source and build directories will reside here.
  ```
  cd path/to/location
  git clone https://github.com/SystoleOS/Slicer.git
  mkdir build
  ```
4. Create the Guix shell:
  ```
  systole-dev shell slicer-5.8
  ```
  This creates and builds `slicer-5.8` and its dependencies. If the build fails, please create an [issue](https://github.com/SystoleOS/guix-systole/issues) to report the error.
5. Build 3D Slicer from source:
  ```sh
  args="-DCMAKE_BUILD_TYPE=Release
      -DCMAKE_CXX_COMPILER=g++
      -DCMAKE_C_COMPILER=gcc
      -DCMAKE_CXX_STANDARD=17
      -DCMAKE_EXE_LINKER_FLAGS=-pthread
      -DSlicer_SUPERBUILD=OFF
      -DBUILD_TESTING=OFF
      -DBUILD_SHARED_LIBS=ON
      -DSlicer_BUILD_EXTENSIONMANAGER_SUPPORT=OFF
      -DSlicer_DONT_USE_EXTENSION=ON
      -DSlicer_REQUIRED_QT_VERSION=5
      -DSlicer_BUILD_ITKPython=OFF
      -DSlicer_BUILD_CLI=OFF
      -DSlicer_BUILD_CLI_SUPPORT=OFF
      -DSlicer_BUILD_QTLOADABLEMODULES=ON
      -DSlicer_BUILD_QTSCRIPTEDMODULES=OFF
      -DSlicer_BUILD_QT_DESIGNER_PLUGINS=OFF
      -DSlicer_USE_QtTesting=OFF
      -DSlicer_USE_SlicerITK=ON
      -DSlicer_USE_CTKAPPLAUNCHER=ON
      -DSlicer_BUILD_WEBENGINE_SUPPORT=OFF
      -DSlicer_VTK_VERSION_MAJOR=9
      -DSlicer_BUILD_vtkAddon=OFF
      -DSlicer_INSTALL_DEVELOPMENT=ON
      -DSlicer_INSTALL_DEVELOPMENT=ON
      -DSlicer_USE_TBB=ON
      -DSlicer_BUILD_DICOM_SUPPORT=OFF
      -DVTK_WRAP_PYTHON=OFF
      -DSlicer_USE_PYTHONQT=OFF
      -DSlicer_USE_SYSTEM_python=OFF
      -DSlicer_USE_SYSTEM_bzip2=ON
      -DSlicer_USE_SYSTEM_CTK=ON
      -DSlicer_USE_SYSTEM_TBB=ON
      -DSlicer_USE_SYSTEM_teem=ON
      -DSlicer_USE_SYSTEM_QT=ON
      -DSlicer_USE_SYSTEM_curl=ON
      -DSlicer_USE_SYSTEM_DCMTK=ON
      -DSlicer_USE_SYSTEM_ITK=ON
      -DSlicer_USE_SYSTEM_LibArchive=ON
      -DSlicer_USE_SYSTEM_LibFFI=ON
      -DSlicer_USE_SYSTEM_LZMA=ON
      -DSlicer_USE_SYSTEM_RapidJSON=ON
      -DSlicer_USE_SYSTEM_sqlite=ON
      -DSlicer_USE_SYSTEM_VTK=ON
      -DSlicer_USE_SYSTEM_zlib=ON"
  
  cmake -S ./Slicer -B ./build $args
  ```