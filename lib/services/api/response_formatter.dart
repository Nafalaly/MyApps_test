part of '../services.dart';

class ResponseParser {
  late _Meta _meta = _Meta.init();
  dynamic _data;
  ResponseParser() {
    Map init = {
      'status': false,
      'code': 0,
      'message': 'Bad Request',
    };
    _meta = _Meta.createMeta(mapData: init);
  }
  ResponseParser.success({required dynamic mapData}) {
    _meta = _Meta.createMeta(mapData: mapData);
    _data = mapData;
  }
  ResponseParser.error({dynamic mapData}) {
    if (mapData != null) {
      _data = mapData;
    } else {
      _data = null;
    }
    _meta = _Meta.createMeta(mapData: mapData);
  }

  Map? get getData => _data;
  int? get getStatusCode => _meta.responseCode;
  String? get getMessage => _meta.message;
  ResponseStatus? get getStatus => _meta.status;
}

class _Meta {
  late int responseCode;
  late ResponseStatus status;
  late String? message;
  _Meta.init() {
    message = 'Initialization';
    status = ResponseStatus.initialized;
    responseCode = 0;
  }
  _Meta.createMeta({required dynamic mapData}) {
    responseCode = mapData['code'];
    message = mapData['message'].toString();
    if (mapData['status'] == true) {
      status = ResponseStatus.success;
    } else {
      status = ResponseStatus.error;
    }
  }
}

enum ResponseStatus { error, success, initialized, internalError }
