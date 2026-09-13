abstract class Result<S, F> {
  const Result();

  bool get isSuccess => this is Success<S, F>;
  bool get isFailure => this is FailureResult<S, F>;

  S? get dataOrNull => isSuccess ? (this as Success<S, F>).data : null;
  F? get failureOrNull => isFailure ? (this as FailureResult<S, F>).failure : null;

  R fold<R>(R Function(S data) onSuccess, R Function(F failure) onFailure) {
    if (this is Success<S, F>) {
      return onSuccess((this as Success<S, F>).data);
    } else {
      return onFailure((this as FailureResult<S, F>).failure);
    }
  }
}

class Success<S, F> extends Result<S, F> {
  final S data;
  const Success(this.data);
}

class FailureResult<S, F> extends Result<S, F> {
  final F failure;
  const FailureResult(this.failure);
}
