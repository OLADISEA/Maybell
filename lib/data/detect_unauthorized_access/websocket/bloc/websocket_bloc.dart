import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybell_apk/data/detect_unauthorized_access/websocket/bloc/websocket_event.dart';
import 'package:maybell_apk/data/detect_unauthorized_access/websocket/bloc/websocket_state.dart';
import '../websocket_service.dart';



class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  final WebSocketService webSocketService;
  bool _isListenerAdded = false; // Track if the listener is already added

  WebSocketBloc(this.webSocketService) : super(WebSocketInitial()) {
    on<InitializeWebSocket>((event, emit) async {
      try {
        webSocketService.initializeWebSocket(event.userEmail, event.phoneModel);
        emit(WebSocketConnected());
      } catch (e) {
        emit(WebSocketError(e.toString()));
      }
    });

    on<NewWebSocketMessage>((event, emit) {
      emit(WebSocketMessageReceived(event.message));
    });

    // Add listener only once
    if (!_isListenerAdded) {
      _isListenerAdded = true;
      webSocketService.messageStream.listen((message) {
        add(NewWebSocketMessage(message));
      });
    }
  }
}


// class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
//   final WebSocketService webSocketService;
//
//   WebSocketBloc(this.webSocketService) : super(WebSocketInitial()) {
//     on<InitializeWebSocket>((event, emit) async {
//       try {
//         webSocketService.initializeWebSocket(event.userEmail, event.phoneModel);
//         emit(WebSocketConnected());
//       } catch (e) {
//         emit(WebSocketError(e.toString()));
//       }
//     });
//
//     on<NewWebSocketMessage>((event, emit) {
//       emit(WebSocketMessageReceived(event.message));
//     });
//
//     webSocketService.messageStream.listen((message) {
//       add(NewWebSocketMessage(message));
//     });
//   }
// }
