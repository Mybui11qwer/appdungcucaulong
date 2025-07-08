import { LoginCustomerDto } from "../dto/request/khachhang/login.customer.dto";
import { RegisterCustomerDto } from "../dto/request/khachhang/register.customer.dto";
import { LoginResponseDto } from "../dto/respone/login.respone.dto";
import { IAuthService } from "../interfaces/services/auth.services";
import { CustomerRepository } from "../repositories/auth.repository";
import { hashPassword, comparePassword } from "../utils/password.util";
import jwt from "jsonwebtoken";

export class AuthService implements IAuthService {
  constructor(private customerRepo: CustomerRepository) {}

  async register(dto: RegisterCustomerDto) {
    // Hash password
    if (!dto.password) {
      throw new Error("Password is required");
    }
    const passwordHash = await hashPassword(dto.password);

    // Gọi repository để lưu vào DB
    const newCustomer = await this.customerRepo.createCustomer({
      Username: dto.username,
      Email: dto.email,
      Phone: dto.phone,
      Password: passwordHash,
      Role: 'customer', // default role
      Address: undefined,
      Gender: undefined,
      Avatar: undefined,
    });

    // Có thể trả về thông tin (bỏ password)
    return {
      id: newCustomer.ID,
      username: newCustomer.Username,
      email: newCustomer.Email,
    };
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
        Role: 'customer',
      },
    };
  }
}
