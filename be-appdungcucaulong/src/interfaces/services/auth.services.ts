import { LoginCustomerDto } from "../../dto/request/khachhang/login.customer.dto";
import { RegisterCustomerDto } from "../../dto/request/khachhang/register.customer.dto";
import { LoginResponseDto } from "../../dto/respone/login.respone.dto";

export interface IAuthService {
  register(data: RegisterCustomerDto): Promise<any>;
  login(data: LoginCustomerDto): Promise<LoginResponseDto>;
}
