import { inject, injectable } from "inversify";
import sql from "mssql";
import TYPES from "../configs/types";
import Database from "../configs/db";
import { LoginDTO } from "../dto/request/login.dto";
import { Customer } from "../interfaces/models/customer.interface";

@injectable()
export class AuthService {
  constructor(
    @inject(TYPES.Database) private readonly db: Database
  ) {}

  public async login({ email, password }: LoginDTO): Promise<Customer | null> {
    await this.db.connect();
    const pool = this.db.getPool();

    const result = await pool
      .request()
      .input("Email", sql.NVarChar(100), email)
      .query("SELECT TOP 1 * FROM Customer WHERE Email = @Email");

    const user = result.recordset[0];
    if (!user || user.Password !== password) return null;

    return {
      ID_Customer: user.ID_Customer,
      Username: user.Username,
      Email: user.Email,
      Password: user.Password,
      Role: user.Role,
      Avatar: user.Avatar,
    };
  }
}
