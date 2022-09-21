import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news360_api/models/device_id_model/device_id_response.dart';

class DeviceIdEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class SendDeviceIdEvent extends DeviceIdEvent{
  final String? deviceId;
  SendDeviceIdEvent({required this.deviceId});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceId];
}
class DeviceIdState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class InitialDeviceIdState extends DeviceIdState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SendingDeviceIdState extends DeviceIdState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SentDeviceIdState extends DeviceIdState{
  final DeviceIdResponse deviceIdResponse;
  SentDeviceIdState({required this.deviceIdResponse});
  @override
  // TODO: implement props
  List<Object?> get props => [deviceIdResponse];
}
class ErrorDeviceIdState extends DeviceIdState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeviceIdBloc extends Bloc<DeviceIdEvent, DeviceIdState>{
  ApiCalls apiCalls;
  DeviceIdBloc(this.apiCalls) : super(InitialDeviceIdState());

  @override
  Stream<DeviceIdState> mapEventToState(DeviceIdEvent event) async*{
    // TODO: implement mapEventToState
    if(event is SendDeviceIdEvent){
      yield InitialDeviceIdState();
      try{
        yield SendingDeviceIdState();
        DeviceIdResponse? deviceIdResponse = await apiCalls.deviceId(event.deviceId);
        String? userId = deviceIdResponse!.userId;
        print(userId);
        yield SentDeviceIdState(deviceIdResponse: deviceIdResponse);
      }catch(_){
        yield ErrorDeviceIdState();
        print('Device Id error: $_');
      }
    }
  }
}