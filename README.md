![DupLn Logo](dupln.png)

[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/)
[![PyPI version fury.io](https://badge.fury.io/py/dupln.svg)](https://pypi.python.org/pypi/dupln/)
[![Tests Status](https://github.com/jet-logic/dupln/actions/workflows/test.yml/badge.svg)](https://github.com/jet-logic/dupln/actions)

**Dupln**. This command-line application scans a specified directory for duplicate files and replaces duplicates with hard links to a single
copy of the file. By doing so, it conserves storage space while preserving the file structure and accessibility.

## ☕ Support

If you find this project helpful, consider supporting me:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/B0B01E8SY7)

## Features

- **Fast duplicate detection** using file sizes, inodes, and MD5 hashes
- **Space optimization** by replacing duplicates with links
- **Multiple operations**:
  - Statistics (`stat`)
  - Linking (`link`)
  - Listing unique files (`uniques`)
  - Listing duplicates (`duplicates`)

# Install

```
> pip install dupln
```

# Usage

## Usage

### Basic Commands

```bash
# Show statistics about duplicates
dupln stat /path/to/directory

# Link duplicates using hardlinks (default)
dupln link /path/to/directory

# List unique files
dupln uniques /path/to/directory

# List duplicate files
dupln duplicates /path/to/directory
```

## Hard link files with same content

```bash
> dupln link '/tmp/dupln'
INFO: Scanning: '/tmp/dupln'
INFO: ++ '/tmp/dupln/as/ci/i_letters' [2]
INFO:  - '/tmp/dupln/as/cii_letters' - '/tmp/dupln/as/tmp7uwq0r4l' [1]
INFO:  - '/tmp/dupln/as/ci/i_/letters' - '/tmp/dupln/as/ci/i_/tmp0beeaxht' [0]
INFO: ++ '/tmp/dupln/as/ci/i_uppercase' [2]
INFO:  - '/tmp/dupln/as/ci/i_/uppercase' - '/tmp/dupln/as/ci/i_/tmpcsykrlv5' [1]
INFO:  - '/tmp/dupln/as/cii_uppercase' - '/tmp/dupln/as/tmp5knmbazf' [0]
INFO: ++ '/tmp/dupln/as/ci/i_/lowercase' [2]
INFO:  - '/tmp/dupln/as/ci/i_lowercase' - '/tmp/dupln/as/ci/tmpxeegm9eu' [1]
INFO:  - '/tmp/dupln/as/cii_lowercase' - '/tmp/dupln/as/tmp8ra1cf6z' [0]
INFO: ++ '/tmp/dupln/di/gits' [1]
INFO:  - '/tmp/dupln/di/gi/ts' - '/tmp/dupln/di/gi/tmp80gznyej' [0]
INFO: ++ '/tmp/dupln/he/xd/ig/its' [2]
INFO:  - '/tmp/dupln/he/xd/igits' - '/tmp/dupln/he/xd/tmpg3jm_ttb' [1]
INFO:  - '/tmp/dupln/he/xdigits' - '/tmp/dupln/he/tmp2nqxy47g' [0]
INFO: ++ '/tmp/dupln/oc/td/igits' [2]
INFO:  - '/tmp/dupln/oc/tdigits' - '/tmp/dupln/oc/tmpodvxqodo' [1]
INFO:  - '/tmp/dupln/oc/td/ig/its' - '/tmp/dupln/oc/td/ig/tmp1um7nupk' [0]
INFO: ++ '/tmp/dupln/pr/intable' [2]
INFO:  - '/tmp/dupln/pr/in/ta/ble' - '/tmp/dupln/pr/in/ta/tmploz2qhry' [1]
INFO:  - '/tmp/dupln/pr/in/table' - '/tmp/dupln/pr/in/tmptf8egynt' [0]
INFO: ++ '/tmp/dupln/pu/nc/tu/ation' [2]
INFO:  - '/tmp/dupln/pu/nctuation' - '/tmp/dupln/pu/tmp4yjomdni' [1]
INFO:  - '/tmp/dupln/pu/nc/tuation' - '/tmp/dupln/pu/nc/tmpp0hsusw1' [0]
INFO: ++ '/tmp/dupln/wh/it/es/pace' [2]
INFO:  - '/tmp/dupln/wh/it/espace' - '/tmp/dupln/wh/it/tmpd2plpkm7' [1]
INFO:  - '/tmp/dupln/wh/itespace' - '/tmp/dupln/wh/tmpg7bw47b1' [0]
INFO: Total disk_size 564b; files 35; inodes 35; linked 17; same_hash 9; same_size 8; size 1.1k; uniq_hash 9;
```

## List unique file content

```bash
> dupln uniques '/tmp/dupln'
INFO: Scanning: '/tmp/dupln'
/tmp/dupln/as/ci/i_/letters
/tmp/dupln/ascii_letters
/tmp/dupln/as/cii_uppercase
/tmp/dupln/as/cii_lowercase
/tmp/dupln/ascii_lowercase
/tmp/dupln/ascii_uppercase
/tmp/dupln/di/gi/ts
/tmp/dupln/digits
/tmp/dupln/he/xd/igits
/tmp/dupln/hexdigits
/tmp/dupln/oc/td/igits
/tmp/dupln/octdigits
/tmp/dupln/pr/in/table
/tmp/dupln/printable
/tmp/dupln/pu/nctuation
/tmp/dupln/punctuation
/tmp/dupln/wh/itespace
/tmp/dupln/whitespace
INFO: Total devices 1; disk_size 564b; files 35; inodes 18; same_ino 9; size 1.1k; unique_size 8;
```

## Show stats about duplicate files

```bash
> dupln stat '/tmp/dupln'
INFO: Scanning: '/tmp/dupln'
INFO: Total disk_size 564b; files 35; inodes 18; same_ino 9; same_size 8; size 1.1k;
```

## Stats meaning

- disk_size - total size excluding duplicate files
- size - total size including duplicate files
- files - total files found
- inodes - total unique i-nodes found
- same_ino - total unique i-nodes found at least twice
- same_size - total unique size found at least twice
- same_hash - total unique hash found at least twice
- unique_size - total unique size found
- unique_hash - total unique file hash found

### Advanced Options

```bash

# Use symbolic links instead of hardlinks
dupln link --linker os.symlink /path/to/dir

# Filter by size range (1MB to 10MB)
dupln duplicates --sizes 1M..10M /path/to/dir

# Continue on errors
dupln link --carry-on /path/to/dir
```

## Safety Features

- **Dry-run mode**: Use `stat` command first to preview
- **Atomic operations**: Temporary files used during linking
- **Error recovery**: `--carry-on` continues after errors

### Linker Types

| Option       | Description                     |
| ------------ | ------------------------------- |
| `os.link`    | Python hardlinks (default)      |
| `os.symlink` | Python symbolic links           |
| `ln`         | System hardlinks (`ln` command) |
| `lns`        | System symlinks (`ln -s`)       |

## Requirements

- Python 3.7+
- Optional: `PyYAML` for YAML output support

**Note**: Always back up important data before running file operations.

---

[![PyPI license](https://img.shields.io/pypi/l/dupln.svg)](https://pypi.python.org/pypi/dupln/)
![Python package](https://github.com/jet-logic/dupln/workflows/Python%20package/badge.svg)
![Upload Python Package](https://github.com/jet-logic/dupln/workflows/Upload%20Python%20Package/badge.svg)
