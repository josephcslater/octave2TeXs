## Copyright (c) 2005-2019 Joseph C. Slater
## Licensed under the MIT License; see the LICENSE file in the repository root.

## -*- texinfo -*-
## @deftypefn  {Function File} {} matrix2tex (@var{a})
## @deftypefnx {Function File} {} matrix2tex (@var{a}, @var{format})
## @deftypefnx {Function File} {} matrix2tex (@var{a}, @var{format}, @var{env})
## @deftypefnx {Function File} {@var{texstr} =} matrix2tex (@dots{})
## Return (or print, when no output is requested) the LaTeX form of the
## real or complex matrix @var{a}.
##
## @var{format} is a printf-style format used for each number (default
## @code{'%5.3f'}), e.g. @code{'%d'}, @code{'%8.3e'}, @code{'%g'}.
##
## @var{env} is the LaTeX matrix environment (default @code{'bmatrix'}).
## Use @code{''} to emit only the rows, without a surrounding environment.
##
## @example
## a = rand (4, 2);
## matrix2tex (a)
## matrix2tex (a, '%8.3g')
## s = matrix2tex (a * 1000, '%8.3e', 'pmatrix');
## @end example
## @end deftypefn

## Author: Joseph C. Slater <joseph.c.slater@gmail.com>

function texstr = matrix2tex (a, format, env)

  if (nargin < 1 || nargin > 3)
    error ('matrix2tex: usage: texstr = matrix2tex (a, format, env)');
  end
  if (nargin < 2 || isempty (format))
    format = '%5.3f';
  end
  if (nargin < 3)
    env = 'bmatrix';
  end
  if (! isnumeric (a) && ! islogical (a))
    error ('matrix2tex: A must be a numeric or logical matrix');
  end
  if (ndims (a) != 2)
    error ('matrix2tex: A must be a 2-D matrix');
  end
  if (! ischar (format) || ! ischar (env))
    error ('matrix2tex: FORMAT and ENV must be strings');
  end

  nl = char (10);
  [m, n] = size (a);

  rows = cell (1, m);
  for i = 1:m
    cells = cell (1, n);
    for j = 1:n
      cells{j} = element2tex (a(i,j), format);
    end
    rows{i} = strjoin (cells, ' & ');
  end
  texstr = strjoin (rows, [' \\' nl]);

  if (! isempty (env))
    texstr = ['\begin{' env '}' nl texstr nl '\end{' env '}'];
  end

  if (nargout == 0)
    fprintf ('%s\n', texstr);
    clear texstr
  end

end

function s = element2tex (x, format)

  re = real (x);
  im = imag (x);
  if (im == 0)
    s = sprintf (format, re);
  elseif (re == 0)
    s = [sprintf(format, im) 'i'];
  else
    if (im < 0)
      sgn = '-';
    else
      sgn = '+';
    end
    s = [sprintf(format, re) sgn sprintf(format, abs (im)) 'i'];
  end

end

%!assert (matrix2tex ([1 2; 3 4], '%d'), ...
%!        ['\begin{bmatrix}' char(10) '1 & 2 \\' char(10) '3 & 4' char(10) '\end{bmatrix}'])
%!assert (matrix2tex ([1 2; 3 4], '%d', ''), ['1 & 2 \\' char(10) '3 & 4'])
%!assert (matrix2tex (1.5), ['\begin{bmatrix}' char(10) '1.500' char(10) '\end{bmatrix}'])
%!assert (matrix2tex (1+2i, '%d', ''), '1+2i')
%!assert (matrix2tex (1-2i, '%d', ''), '1-2i')
%!assert (matrix2tex (2i, '%d', ''), '2i')
%!assert (matrix2tex (0, '%d', ''), '0')
%!error <numeric> matrix2tex ('abc')
%!error <2-D> matrix2tex (ones (2, 2, 2))
