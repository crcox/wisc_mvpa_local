%% README
% In this script, I simulate some data with true signal. You can replace
% the next two sections below with code to load your real data, and the
% rest of the script should work.

%% Specify data dimensions
nitems = 100;
nfeatures = 1000;
embedding_dimensions = 3;


%% Simulate X and Y
X = zscore(randn(nitems, nfeatures));
Btrue = zeros(nfeatures, embedding_dimensions);
Btrue(1:10, 1:embedding_dimensions) = 1;
Btrue(11:20, 1) = 1;
Btrue(21:30, 2) = 1;
Btrue(31:40, 3) = 1;
Ystar = X * Btrue;
Y = Ystar + randn(size(Ystar));


%% Specify hyperparameters
lambda = 1; % relates to minimum value in lambda sequence
lambda1 = 200; % relates to the range of lambda sequence
lambda_sequence = build_lambda_sequence(nfeatures, lambda, lambda1, "linear");


%% Build model object
bias = 1;
training_set = true(nitems, 1);
opts = struct( ...
    'lambda', lambda, ...
    'lambda1', lambda1 ...
);
m = Adlas(size(X), size(Y), lambda_sequence, training_set, bias, opts);


%% Fit model
mfit = m.train(X, Y, opts);

%% Casual inspection of weights
% The first 10 features, that are contributing across all three dimensions,
% are prefered.
imagesc(mfit.X(1:100, :))
