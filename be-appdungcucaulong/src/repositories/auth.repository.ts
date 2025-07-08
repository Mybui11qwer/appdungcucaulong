import sql from "mssql";
import Database from "../configs/db";
import { Customer } from "../interfaces/models/customer.model";

export class CustomerRepository {

  async createCustomer(data: Partial<Customer>): Promise<any> {
      const pool = await Database.getInstance();
      const request = pool.request();

    const result = await request
      .input("Username", sql.NVarChar, data.Username)
      .input("Email", sql.NVarChar, data.Email)
      .input("Phone", sql.NVarChar, data.Phone)
      .input("Password", sql.NVarChar, data.Password)
      .input("Address", sql.NVarChar, data.Address ?? null)
      .input("Gender", sql.NVarChar, data.Gender ?? null)
      .input("Avatar", sql.NVarChar, data.Avatar ?? null)
      .input("Role", sql.NVarChar, data.Role ?? 'customer')
      .query(`
        INSERT INTO Customer (Username, Email, Phone, Password, Address, Gender, Avatar, Role)
        OUTPUT INSERTED.*
        VALUES (@Username, @Email, @Phone, @Password, @Address, @Gender, @Avatar, @Role)
      `);

    return result.recordset[0]; // trả về row vừa insert
  }

  async findByEmail(email: string): Promise<Customer | null> {
      const pool = await Database.getInstance();
      const request = pool.request();

    const result = await request
      .input("Email", sql.NVarChar, email)
      .query(`SELECT * FROM Customer WHERE Email = @Email`);

    return result.recordset[0] || null;
  }
}
