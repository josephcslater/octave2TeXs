# octave2TeXs

Convert Octave/Matlab matrices and polynomials to LaTeX.

## Install

Download `octave2texs-<version>.tar.gz` from the
[latest release](https://github.com/josephcslater/octave2TeXs/releases/latest), then in Octave:

```octave
pkg install octave2texs-2026.10.8.tar.gz
pkg load octave2texs
```

Or without installing: `addpath('inst')`.

Versions use calendar versioning (`YYYY.M.D`, no leading zeros, tag `vYYYY.M.D`).

## Usage

```octave
matrix2tex([1 2; 3 4], '%d')
% \begin{bmatrix}
% 1 & 2 \\
% 3 & 4
% \end{bmatrix}

s = matrix2tex(rand(2), '%8.3g', 'pmatrix');   % returns the string
matrix2tex([1+2i 3], '%d', '')                 % rows only, no environment

poly2tex([1 0 -3], 's')       % s^{2} - 3
poly2tex([1 2 3], 'x', 1)     % x^{2} + 2 x + 3 = 0
poly2tex([1.5 2], 'x', 0, '%.2f')
```

With no output argument `matrix2tex` prints the result; otherwise it returns it.

## Tests

```octave
addpath('inst'); test poly2tex; test matrix2tex
```

CI runs these on every push.

## License

MIT; see [LICENSE](LICENSE).
