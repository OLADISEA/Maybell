// Define WebSocket events
import 'package:equatable/equatable.dart';

abstract class WebSocketEvent extends Equatable {
  const WebSocketEvent();
  @override
  List<Object> get props => [];
}

class InitializeWebSocket extends WebSocketEvent {
  final String userEmail;
  final String phoneModel;

  const InitializeWebSocket(this.userEmail, this.phoneModel);
}

class NewWebSocketMessage extends WebSocketEvent {
  final String message;

  const NewWebSocketMessage(this.message);
}