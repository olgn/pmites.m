function [tp, error, k] = irls(p, guess, tol, t, V, y1)
	k = 0;
	tp = guess;
	errorLast = 0;
	error = sqrt(sum((t-tp).^2));
	while (abs(error-errorLast) > tol && k < 1e4)
		errorLast = error;
		W = abs(y1-(V*tp)).^(p-2);
		Wmin = min(W(:));
		W(W > Wmin*1e7) = Wmin*1e7;
		W = diag(W);
		tp = (V'*W*V)\(V'*W)*y1;
		error = sqrt(sum((t-tp).^2));
		k = k+1;
	end
