%% NMPC_Iter
DoP = 4; % degree of parallism: 1 = in serial, otherwise in parallel
%% 
data       = coder.load('GEN_initData.mat');
lambdaDim  = data.lambdaDim;
muDim      = data.muDim;
uDim       = data.uDim;
xDim       = data.xDim;
pDim       = data.pDim;
N          = data.N;
x0         = data.x0;
lambda     = data.lambda;
mu         = data.mu;
u          = data.u;
x          = data.x;
par        = data.par;
LAMBDA     = data.LAMBDA;

% split into DoP pieces
sizeSeg     = N/DoP;
lambdaSplit = reshape(lambda, lambdaDim,  sizeSeg,DoP);
muSplit     = reshape(mu,     muDim,      sizeSeg,DoP);
uSplit      = reshape(u,      uDim,       sizeSeg,DoP);
xSplit      = reshape(x,      xDim,       sizeSeg,DoP);
pSplit      = reshape(par,    pDim,       sizeSeg,DoP);
LAMBDASplit = reshape(LAMBDA, xDim, xDim, sizeSeg,DoP);
%% generate dll for simulink simulation
% is re-gen?
reGen = true;
if reGen
    args_NMPC_Iter = {x0,...
                      lambdaSplit,...
                      muSplit,...
                      uSplit,...
                      xSplit,...
                      pSplit,...
                      LAMBDASplit};
    NMPC_Iter_CodeGen('lib','C',args_NMPC_Iter);
end