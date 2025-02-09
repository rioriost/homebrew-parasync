# parasync

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Overview

parasync is a parallelized rsync tool written in Python.
It is designed to be used in a situation where you have a large number of files to transfer and you want to utilize multiple CPU cores to speed up the transfer.
It can also suspend/resume rsync processes based on the CPU usage to avoid overloading the system.

It's inspired by [parsync](https://github.com/hjmangalam/parsync) but written in Python.
I've been using the original parsync for a long time, but it's no longer maintained and has some issues. So I decided to rewrite it in Python.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Comparison with the original rsync](#comparison-with-the-original-rsync)
- [Limitations](#limitations)
- [License](#license)

## Installation

Just add tap and install homebrew package.

```bash
brew tap rioriost/parasync
brew install parasync
```

You can also install it on Linux with homebrew or install it from the source code.

## Usage

Execute parasync command.

```bash
parasync --help
usage: parasync [-h] [--max-procs MAX_PROCS] [--suspend-threshold SUSPEND_THRESHOLD] [--resume-threshold RESUME_THRESHOLD] [--compress] [--progress]
               local_dir remote_path

A tool to transfer all files under a specified directory to a remote location using rsync.

positional arguments:
  local_dir             The root source directory (all files underneath will be transferred).
  remote_path           Transfer destination (e.g. "rsync://host/path/").

optional arguments:
  -h, --help            show this help message and exit
  --max-procs MAX_PROCS
                        Number of rsync processes to run in parallel (if not specified, the number of CPU cores is used).
  --suspend-threshold SUSPEND_THRESHOLD
                        Pause rsync if CPU usage is above this threshold (default: 80.0).
  --resume-threshold RESUME_THRESHOLD
                        Resume rsync if CPU usage is below this threshold (default: 60.0).
  --compress, -z        Compress file data during transfer.
  --progress            Display overall transfer progress (total bytes, transfer rate, CPU usage, etc.) every second.
```

## Comparison with the original rsync

![Comparison](https://github.com/rioriost/homebrew-parasync/raw/main/rsync_parasync.png)

* Environment
  * Local: macOS Sequoia 15.3, MacStudio 2022, Apple M1 Max (10-Core), 64GB Mem, 512GB SSD
  * Remote: Red Hat Enterprise Linux 8.10, AMD Ryzen 5 5600G (12-Core), 64GB Mem, 2TB NVMe Gen4 SSD
  * Network: 10Gbps Ethernet

* original rsync: 932 Mbps
```bash
rsync -av --progress /Users/rifujita/parasync_src/ rsync://192.168.1.2/parasync_tgt/
...
sent 46,861,733,173 bytes  received 8,665 bytes  122,194,893.97 bytes/sec
total size is 46,850,265,318  speedup is 1.00
```

* parasync (--max-procs 10): 3.5 Gbps
```bash
parasync --max-procs 10 --progress /Users/rifujita/parasync_src/ rsync://192.168.1.2/parasync_tgt/
...
[Summary] Transferred file count: 454 files, Data transferred: 43.6 GB, Average transfer speed: 3.5 Gbps (Total time: 107.8 seconds)
```

* parasync (default: --max-procs 9): 5.1 Gbps
```bash
parasync --progress /Users/rifujita/parasync_src/ rsync://192.168.1.2/parasync_tgt/
...
[Summary] Transferred file count: 454 files, Data transferred: 43.6 GB, Average transfer speed: 5.1 Gbps (Total time: 74.0 seconds)
```

* parasync (--max-procs 8): 4.5 Gbps
```bash
parasync --max-procs 8 --progress /Users/rifujita/parasync_src/ rsync://192.168.1.2/parasync_tgt/
...
[Summary] Transferred file count: 454 files, Data transferred: 43.6 GB, Average transfer speed: 4.5 Gbps (Total time: 83.2 seconds)
```

* parasync (--max-procs 7): 4.0 Gbps
```bash
parasync --max-procs 7 --progress /Users/rifujita/parasync_src/ rsync://192.168.1.2/parasync_tgt/
...
[Summary] Transferred file count: 454 files, Data transferred: 43.6 GB, Average transfer speed: 4.0 Gbps (Total time: 93.4 seconds)
```

* parasync (--max-procs 6): 3.0 Gbps
```bash
parasync --max-procs 6 --progress /Users/rifujita/parasync_src/ rsync://192.168.1.2/parasync_tgt/
...
[Summary] Transferred file count: 454 files, Data transferred: 43.6 GB, Average transfer speed: 3.0 Gbps (Total time: 125.2 seconds)
```

### Summary
* parasync is faster than the original rsync. But the best number of --max-procs depends on the environment, number of CPU cores and IOPS of SSDs on the local and remote hosts, network bandwidth, and so on.

## Limitations
* 0.1.0: parasync uses rsync, not scp or sftp, and so on. If a directory specified does not exist on the remote destination, it fails. Because ryync does not fork shell on the remote host.
  e.g., `parasync /path/to/local_dir/ rsync://host_name/path/to/remote_dir/` fails if `/path` does not exist on the remote host.
  And, parasync does not use 'compress' option of rsync. With wide network bandwidth, it may be better not to use 'compress' option.

## Release Notes

### 0.1.0 Release
* First release.

## License
MIT License
