function z=A_kron_B_times_x(A,B,x,xr,xc)
% H1 line
%
% Syntax
% -------
% ::
%
% Inputs
% -------
%
% Outputs
% --------
%
% More About
% ------------
%
% Examples
% ---------
%
% See also: 

% computes the kron(A,B)*x
if nargin<4
    xc=size(A,2);
    if nargin<3
        xr=size(B,2);
    end
end
z=B*reshape(x,xr,xc)*transpose(A);
z=z(:);
end