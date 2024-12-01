class AuthorizationState{}

class AuthorizationLoading extends AuthorizationState{}
class AuthorizationSuccess extends AuthorizationState{
  final String username;
  AuthorizationSuccess(this.username);
}
class AuthorizationError extends AuthorizationState{}