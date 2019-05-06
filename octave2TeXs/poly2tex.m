## Copyright (C) 2006 Joseph C. Slater
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

## usage: texstr=poly2tex(poly,var,iseqn)
## POLY2TEX(POLY,VAR,ISEQN) returns the latex equation for a polynomial
## POLY is the polynomial defined in matlab/octave form. 
## VAR is the variable the polynomial is to be written in.
## ISEQN (Optional) returns the polynomial equal to zero (an
## equation) instead of just the polynomial.
##


## Author: Joseph C. Slater <jslater@cs.wright.edu>
## Created: February 2006
## Adapted-By: 

function texstr=poly2tex(poly,var,iseqn)

if nargin==2
  iseqn=0;
end
n=length(poly)-1;
texstr='';
if n>1
  for i=n:-1:2
    texstr=[texstr num2str(poly(n-i+1)) ' ' var '^{' num2str(i) ...
                        '} + '];
  end
end

texstr=[texstr  num2str(poly(n)) ' ' var  ' + '];
texstr=[texstr  num2str(poly(n+1)) ];
if iseqn==1
  texstr=[texstr ' = 0'];
end

%!assert(poly2tex([1 2 3],'x'),'1 x^{2} + 2 x + 3');
%!assert(poly2tex([1 2 3],'x_y'),'1 x_y^{2} + 2 x_y + 3');
%!assert(poly2tex([1 2 3],'x_y',1),'1 x_y^{2} + 2 x_y + 3 = 0');
