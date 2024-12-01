// Define events
abstract class AllowLoginEvent {}

class AllowLoginRequested extends AllowLoginEvent {
  final bool allowLogin;
  final String loginInfoId;
  AllowLoginRequested({required this.loginInfoId,required this.allowLogin});
}
