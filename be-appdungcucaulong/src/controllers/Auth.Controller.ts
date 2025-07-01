import { Request, Response } from "express";
import { inject, injectable } from "inversify";
import { AuthService } from "../services/auth.service";
import TYPES from "../configs/types";

@injectable()
export class AuthController {
  constructor(@inject(TYPES.AuthService) private readonly authService: AuthService) {}

  login = async (req: Request, res: Response): Promise<void> => {
    const { email, password } = req.body;

    if (!email || !password) {
      res.status(400).json({ message: "Vui lòng nhập đầy đủ thông tin" });
      return;
    }

    try {
      const user = await this.authService.login({ email, password });

      if (!user) {
        res.status(401).json({ message: "Email hoặc mật khẩu không đúng" });
        return;
      }

      res.json({
        message: "Đăng nhập thành công!",
        user,
      });
    } catch (err) {
      res.status(500).json({ message: "Lỗi server khi đăng nhập" });
    }
  };
}
