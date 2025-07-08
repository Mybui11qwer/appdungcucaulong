import '../../data/dto/request/register_request_dto.dart';

abstract class RegisterEvent {}

class SubmitRegister extends RegisterEvent {
  final RegisterRequestDto dto;

  SubmitRegister(this.dto);
}