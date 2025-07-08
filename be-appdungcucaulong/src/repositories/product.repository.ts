import sql from "mssql";
import Database from "../configs/db";
import { Product } from "../interfaces/models/product.model";

export class ProductRepository {
  async getAll(): Promise<Product[]> {
    const pool = await Database.getInstance();
    const result = await pool.request().query(`
      SELECT * FROM Product
    `);
    return result.recordset;
  }

  async getById(id: number): Promise<any> {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .input("id", sql.Int, id)
      .query(`
      SELECT 
        p.ID_Product AS id,
        p.Name,
        p.Price,
        p.Description,
        p.Quantity,
        p.Image,
        c.Name_Category AS category,
        m.Name_Material AS material,
        w.Content AS warranty
      FROM Product p
      LEFT JOIN Category c ON p.ID_Category = c.ID_Category
      LEFT JOIN Material m ON p.ID_Material = m.ID_Material
      LEFT JOIN Warranty_Policy w ON p.ID_Warranty = w.ID_Warranty
      WHERE p.ID_Product = @id
    `);

    return result.recordset[0];
  }
  // các hàm CRUD khác sẽ thêm sau
}
