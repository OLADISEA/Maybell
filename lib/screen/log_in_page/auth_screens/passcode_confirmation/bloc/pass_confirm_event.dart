class PassEvents{}

class ConfirmPasscode extends PassEvents{
  final String passcode;
  ConfirmPasscode({required this.passcode});
}