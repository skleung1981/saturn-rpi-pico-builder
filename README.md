# saturn-rpi-pico-builder

It is a project that builds docker image 'saturn-rpi-pico-builder' for RPI pico/pico2 project using Pico SDK.

## Scope
The docker image is using the following version
- Ubuntu 24.04
- Python 3 (3.13)
- Pico SDK (2.3.1)
- Pico Tool (2.3.1)

## Usage

```
cmake -S . -B build -DPICO_BOARD=[pico_w | pico2_w]
cmake --build build

```
