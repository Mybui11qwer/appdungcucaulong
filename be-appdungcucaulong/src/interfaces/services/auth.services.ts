import { LoginResponseDto } from "../../dto/respone/login.respone.dto";

export interface IAuthService {
  login(email: string, password: string): Promise<LoginResponseDto>;
  register(email: string, password: string, username: string, gender: string, phone: number): Promise<void>;
}