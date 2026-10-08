# Changelog

Versions use calendar versioning: `YYYY.M.D`, with a trailing `.N` for additional releases on the same day.

## 2026.10.8.1 - 2026-10-08

- Add this changelog.

## 2026.10.8 - 2026-10-08

### Changed
- Relicensed from BSD-3-Clause (and GPL-2.0+ in `poly2tex.m`) to the MIT License.
- `matrix2tex` now returns the LaTeX string, printing only when called with no output, and wraps the result in a `bmatrix` environment (configurable with a third `env` argument; `''` for bare rows).
- `poly2tex` omits zero terms and unit coefficients, and prints negative coefficients as `- 3` instead of `+ -3`.
- Source moved to `inst/` and packaged for `pkg install` (`DESCRIPTION`, `COPYING`).

### Added
- `poly2tex` optional `format` argument and default variable `'x'`; complex coefficients are supported.
- Input validation, texinfo help and `%!test` blocks for both functions.
- GitHub Actions workflow running the tests in Octave.
- README with install and usage instructions.

### Fixed
- `poly2tex` failed or gave wrong output for constant and linear polynomials.
- `matrix2tex` passed its output through `sprintf`/`printf` as a format string, and used `|`/`&` instead of `||`/`&&`.
- Signs of complex matrix entries.
