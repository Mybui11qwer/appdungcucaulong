import { hashPassword } from "../utils/password.util";
import { injectable } from "inversify";
import Database from "../configs/db";
import sql from "mssql";

export class AuthRepository {
  async findByEmail(email: string) {
    const result = await Database.request
      .input("Email", sql.VarChar, email)
      .query("SELECT * FROM Customer WHERE Email = @Email");
    return result.recordset[0];
  }

  async createUser(email: string, password: string, username: string, gender: string, phone: number) {
    const hashed = await hashPassword(password);
    await sql.query`INSERT INTO Customer (Email, Password, Gender, Username, Phone) VALUES (${email}, ${hashed}, ${gender}, ${username}, ${phone})`;
  }
}