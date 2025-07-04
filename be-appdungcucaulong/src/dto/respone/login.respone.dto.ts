import { ICustomerModel } from "../../interfaces/models/customer.model";

export class LoginResponseDto {
  token: string;
  taiKhoan: Partial<ICustomerModel>;

  constructor(token: string, taiKhoan: Partial<ICustomerModel>) {
    this.token = token;
    this.taiKhoan = taiKhoan;
  }
}