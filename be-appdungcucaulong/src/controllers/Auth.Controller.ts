import { Request, Response } from "express";
import { AuthService } from "../services/auth.service";
import { plainToInstance } from "class-transformer";
import { RegisterCustomerDto } from "../dto/request/khachhang/register.customer.dto";
import { validate } from "class-validator";

export class AuthController {
  constructor(private authService: AuthService) {}

  async register(req: Request, res: Response) {
    const dto = plainToInstance(RegisterCustomerDto, req.body);
    const errors = await validate(dto);

    if (errors.length > 0) {
      const validationErrors = errors.map(error => ({
        field: error.property,
        messages: Object.values(error.constraints || {}),
      }));

      return res.status(400).json({ errors: validationErrors });
    }

    const customer = await this.authService.register(dto);
    res.status(201).json({ message: "Registered", customer });
  }

  async login(req: Request, res: Response) {
    try {
      const result = await this.authService.login(req.body);
      res.status(200).json(result);
    } catch (err: any) {
      res.status(401).json({ error: err.message });
    }
  }
}
