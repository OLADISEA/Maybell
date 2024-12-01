// Define WebSocket states
import 'package:equatable/equatable.dart';

abstract class WebSocketState extends Equatable {
  const WebSocketState();
  @override
  List<Object> get props => [];
}

class WebSocketInitial extends WebSocketState {}

class WebSocketConnected extends WebSocketState {}

class WebSocketMessageReceived extends WebSocketState {
  final String message;

  const WebSocketMessageReceived(this.message);

  @override
  List<Object> get props => [message];
}

class WebSocketError extends WebSocketState {
  final String message;

  const WebSocketError(this.message);

  @override
  List<Object> get props => [message];
}