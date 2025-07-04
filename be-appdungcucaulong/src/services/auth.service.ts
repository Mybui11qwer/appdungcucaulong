// src/services/auth.service.ts
import { injectable } from "inversify";
import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";
import { AuthRepository } from "../repositories/auth.repository";
import { IAuthService } from "../interfaces/services/auth.services";
import { LoginResponseDto } from "../dto/respone/login.respone.dto";
import { comparePassword } from "../utils/password.util";


@injectable()
export class AuthService {
    private authRepo = new AuthRepository();
    
    async login(email: string, password: string): Promise<LoginResponseDto> {
        const user = await this.authRepo.findByEmail(email);
        if (!user) throw new Error("Tài khoản không tồn tại");

        const match = await comparePassword(password, user.Password);
        if (!match) throw new Error("Sai mật khẩu");

        const token = jwt.sign(
            { email: user.Email },
            process.env.JWT_SECRET || "SECRET_KEY",
            { expiresIn: "1d" }
        );

        return new LoginResponseDto(token, {
            Email: user.Email,
            Username: user.Username
        });
    }

    async register(email: string, password: string, username: string, gender: string, phone: number) {
        await this.authRepo.createUser(email, password, username, gender, phone);
    }
}
