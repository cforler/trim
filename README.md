# trim

A small Unix command-line tool that removes leading and trailing whitespace
from every line of input.  It reads one or more files, or standard input if
no file is given, and writes the trimmed lines to standard output — one
newline-terminated line at a time.

## Usage

```
trim [FILE]...
```

With no `FILE` argument `trim` reads from **stdin**, making it a natural fit
for shell pipelines:

```bash
echo "   Hello World   " | trim
# → Hello World

cat essay.txt | trim

grep "keyword" data.txt | trim > clean.txt

trim file1.txt file2.txt > result.txt
```

## Build

Requires a C compiler (gcc or clang) and GNU make.

```bash
make
```

The `Makefile` enables a hardened set of compiler and linker flags by default:

| Flag | Purpose |
|---|---|
| `-Wall -Wextra -Werror` | Strict warnings, treated as errors |
| `-fstack-protector-all` | Stack smashing protection |
| `-fstack-clash-protection` | Stack clash mitigation |
| `-D_FORTIFY_SOURCE=2` | Compile-time and runtime buffer checks |
| `-fPIE` / `-pie` | Position-independent executable |
| `-Wl,-z,relro,-z,now` | Full RELRO (read-only relocations) |
| `-s` | Strip symbol table from the binary |

## Installation

Install the binary and both man pages (English and German) system-wide:

```bash
sudo make install
```

The following files are installed:

| File | Destination |
|---|---|
| `trim` | `/usr/local/bin/trim` |
| `trim_en.1` | `/usr/local/share/man/man1/trim.1.gz` |
| `trim_de.1` | `/usr/local/share/man/de/man1/trim.1.gz` |

## Uninstall

```bash
sudo make uninstall
```

## Man page

After installation the man page is available in English and German:

```bash
man trim           # English (default)
LANG=de man trim   # German
```

## How it works

`trim` uses `getline(3)` to read input line by line, so arbitrarily long
lines and large files are handled correctly without fixed-size buffers.
Whitespace is defined by `isspace(3)`: space, tab (`\t`), newline (`\n`),
carriage return (`\r`), form feed (`\f`), and vertical tab (`\v`).
Characters *between* words are never modified.

## Alternatives

Standard Unix tools can achieve the same result without installing anything:

```bash
# sed — most robust, handles any input
echo "   Hello   " | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'

# awk — concise
echo "   Hello   " | awk '{$1=$1; print}'

# xargs — simple cases only (interprets quotes and backslashes)
echo "   Hello   " | xargs
```

`trim` exists for readability: `cat essay.txt | trim` is easier to type and
understand at a glance than the `sed` equivalent.

## License

See [LICENSE](LICENSE).

## Author

Christian Forler

## Acknowledgments

This README was written by Claude Sonnet 4.6, an AI assistant made by Anthropic.
