import { LoginCustomerDto } from "../dto/request/khachhang/login.customer.dto";
import { RegisterCustomerDto } from "../dto/request/khachhang/register.customer.dto";
import { LoginResponseDto } from "../dto/respone/login.respone.dto";
import { IAuthService } from "../interfaces/services/auth.services";
import { CustomerRepository } from "../repositories/auth.repository";
import { hashPassword, comparePassword } from "../utils/password.util";
import jwt from "jsonwebtoken";

export class AuthService implements IAuthService {
  constructor(private customerRepo: CustomerRepository) {}

  async register(data: RegisterCustomerDto): Promise<any> {
    const hashed = await hashPassword(data.password);
    return this.customerRepo.createCustomer({ ...data, Password: hashed });
  }

  async login(data: LoginCustomerDto): Promise<LoginResponseDto> {
    const user = await this.customerRepo.findByEmail(data.email);
    if (!user) throw new Error("Email not found");
    const valid = await comparePassword(data.password, user.Password);
    if (!valid) throw new Error("Invalid password");

    const token = jwt.sign({ id: user.ID_Customer }, process.env.JWT_SECRET!, { expiresIn: "7d" });

    return {
      token,
      user: {
        ID_Customer: user.ID_Customer,
        Username: user.Username,
        Email: user.Email,
        Phone: user.Phone,
        Role: user.Role,
      },
    };
  }
}
