import { inject, injectable } from "inversify";
import { Request, Response } from "express";
import { AuthService } from "../services/auth.service";
import TYPES from "../configs/types";

@injectable()
export class AuthController {
    constructor(@inject(TYPES.AuthService) private authService: AuthService) {}
    login = async (req: Request, res: Response) => {
        try {
            const { email, password } = req.body;
            const result = await this.authService.login(email, password);
            res.json(result);
        } catch (error) {
          const message = error instanceof Error ? error.message : "Lỗi không xác định";
          res.status(401).json({ message });
        }
    };

    register = async (req: Request, res: Response) => {
        try {
            const { email, password, hoTen, gender, phone } = req.body;
            await this.authService.register(email, password, hoTen, gender, phone);
            res.status(201).json({ message: "Đăng ký thành công" });
        } catch (error) {
          const message = error instanceof Error ? error.message : "Lỗi không xác định";
          res.status(401).json({ message });
        }
    };
}
