## Copyright (C) 2006 Joseph C. Slater
##
## Licensed under the MIT License; see the LICENSE file in the repository root.

## -*- texinfo -*-
## @deftypefn  {Function File} {@var{texstr} =} poly2tex (@var{poly})
## @deftypefnx {Function File} {@var{texstr} =} poly2tex (@var{poly}, @var{var})
## @deftypefnx {Function File} {@var{texstr} =} poly2tex (@var{poly}, @var{var}, @var{iseqn})
## @deftypefnx {Function File} {@var{texstr} =} poly2tex (@var{poly}, @var{var}, @var{iseqn}, @var{format})
## Return the LaTeX string for a polynomial.
##
## @var{poly} is the coefficient vector in Matlab/Octave form (highest power
## first).  @var{var} is the variable name (default @code{'x'}).  If
## @var{iseqn} is true, @code{' = 0'} is appended.  @var{format} is the
## printf-style format for each coefficient (default @code{'%g'}).
##
## Zero terms are omitted and unit coefficients are not printed.
## Complex coefficients are wrapped in parentheses.
## @end deftypefn

## Author: Joseph C. Slater <joseph.c.slater@gmail.com>
## Created: February 2006

function texstr = poly2tex (poly, var, iseqn, format)

  if (nargin < 1 || nargin > 4)
    error ('poly2tex: usage: texstr = poly2tex (poly, var, iseqn, format)');
  end
  if (nargin < 2 || isempty (var))
    var = 'x';
  end
  if (nargin < 3 || isempty (iseqn))
    iseqn = 0;
  end
  if (nargin < 4 || isempty (format))
    format = '%g';
  end
  if (! isnumeric (poly) || ! (isvector (poly) || isscalar (poly)))
    error ('poly2tex: POLY must be a numeric vector');
  end
  if (! ischar (var) || ! ischar (format))
    error ('poly2tex: VAR and FORMAT must be strings');
  end

  n = length (poly) - 1;
  texstr = '';

  for k = 1:length (poly)
    c = poly(k);
    if (c == 0)
      continue
    end
    p = n - k + 1;

    if (isreal (c))
      neg = c < 0;
      mag = abs (c);
      if (mag == 1 && p > 0)
        cs = '';
      else
        cs = sprintf (format, mag);
      end
    else
      neg = false;
      cs = ['(' sprintf(format, real (c))];
      if (imag (c) < 0)
        cs = [cs '-' sprintf(format, abs (imag (c))) 'i)'];
      else
        cs = [cs '+' sprintf(format, imag (c)) 'i)'];
      end
    end

    if (p == 0)
      term = cs;
    elseif (p == 1)
      term = strtrim ([cs ' ' var]);
    else
      term = strtrim ([cs ' ' var '^{' sprintf('%d', p) '}']);
    end

    if (isempty (texstr))
      if (neg)
        texstr = ['-' term];
      else
        texstr = term;
      end
    elseif (neg)
      texstr = [texstr ' - ' term];
    else
      texstr = [texstr ' + ' term];
    end
  end

  if (isempty (texstr))
    texstr = '0';
  end
  if (iseqn)
    texstr = [texstr ' = 0'];
  end

end

%!assert (poly2tex ([1 2 3], 'x'), 'x^{2} + 2 x + 3')
%!assert (poly2tex ([1 2 3], 'x_y'), 'x_y^{2} + 2 x_y + 3')
%!assert (poly2tex ([1 2 3], 'x_y', 1), 'x_y^{2} + 2 x_y + 3 = 0')
%!assert (poly2tex ([1 2 3]), 'x^{2} + 2 x + 3')
%!assert (poly2tex ([1 0 -3], 's'), 's^{2} - 3')
%!assert (poly2tex ([-1 -2 -3]), '-x^{2} - 2 x - 3')
%!assert (poly2tex ([2 1], 's'), '2 s + 1')
%!assert (poly2tex (5), '5')
%!assert (poly2tex (0), '0')
%!assert (poly2tex ([0 0 0], 'x', 1), '0 = 0')
%!assert (poly2tex ([1.5 2], 'x', 0, '%.2f'), '1.50 x + 2.00')
%!assert (poly2tex ([1+2i 3], 'x'), '(1+2i) x + 3')
%!error <vector> poly2tex ([1 2; 3 4])
