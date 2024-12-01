class CreatePasscodeEvents{}

class TriggerPasscodeEvents extends CreatePasscodeEvents{
  final String passcode;
  TriggerPasscodeEvents({required this.passcode});
}