function lamseq = build_lambda_sequence(n, lambda, lambda1, type)
    arguments
        n (1,1) double {mustBeInteger}
        lambda (1,1) double
        lambda1 (1,1) double
        type (1,1) string = "linear"
    end
    switch lower(type)
        case 'linear'
            lamseq = lambda1*(n:-1:1)/n + lambda;
        case 'exponential'
            lamseq = lambda*sqrt(2*log((n*ones(1,n))./(1:n)));
        case 'inf'
            lamseq = [lambda+lambda1, repmat(lambda,1,n-1)];
        otherwise
            error("Unrecognized lambda sequence type `%s`.", type)
    end
    lamseq = lamseq(:);
end