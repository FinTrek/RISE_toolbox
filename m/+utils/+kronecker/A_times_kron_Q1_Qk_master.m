function C=A_times_kron_Q1_Qk_master(kind,varargin)
% A_times_kron_Q1_Qk_master -- computes A(Q1*Q2*...*Qk) where * denotes the
% kronecker product
%
% ::
%
%
% - C=A_times_kron_Q1_Qk_master(kind,A,Q1,Q2,...,Qk)
%
% Args:
%
%    - **kind** [{'fast'}|'direct'|'decomp']: matrix on the left-hand side
%
%      - **fast** :  uses transpose and reshape
%      - **direct** : uses kronecker products
%      - **decomp** : decomposes the problem introducing identity matrices
%        and thereby avoiding the call to kronecker products.
%
%    - **A** [matrix]: matrix on the left-hand side
%
%    - **Qi** [matrix]: matrix on the kronecker block
%
% Returns:
%    :
%
%    - **C** [matrix]: result
%
% Note: It is unclear why "decomp" is slower than "fast". Part of the
% answer probably lies in the fact that decomp calls many additional
% functions.
%
% Example:
%
%    imax=10;
%    nrd=randi(imax,1);
%    nmat=4;
%    nra=randi(imax,nmat,1);
%    ncd=prod(nra);
%    A=cell(1,nmat);
%    fvv=rand(nrd,ncd);
%    for ii=1:nmat
%        A{ii}=rand(nra(ii),randi(imax,1));
%    end
%    tic,r0=utils.kronecker.A_times_kron_Q1_Qk_master('fast',fvv,A{:});toc
%    tic,r1=utils.kronecker.A_times_kron_Q1_Qk_master('direct',fvv,A{:});toc
%    tic,r2=utils.kronecker.A_times_kron_Q1_Qk_master('decomp',fvv,A{:});toc
%    max(max(abs(r1-r0)))
%    max(max(abs(r2-r0)))
%
%    See also:

if isempty(kind)
    
    kind='fast';
    
end

switch kind
        
    case 'fast'
        
        C=A_kron_a1_an(varargin{:});
    
    case 'direct'
                
        C=varargin{1}*utils.kronecker.kronall(varargin{2:end});
        
    case 'decomp'
        
        C=utils.kronecker.A_times_kron_Q1_Qk(varargin{:});
        
    otherwise
        
        error('First argument must be "fast", "direct" or "decomp"')
        
end


end

function r=A_kron_a1_an(f,varargin)

% computes f*(A1(x)A2(x)...(x)An)
%
% Supercalifragilisticexpialidocious

nrf=size(f,1);

r=f.';

clear f

for ii=1:length(varargin)
    
    a=varargin{ii};
    
    nra=size(a,1);
    
    r=reshape(r.',[],nra)*a;
    
end

r=reshape(r.',[],nrf).';

end
