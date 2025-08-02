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
  // các hàm CRUD

  async create(data: Omit<Product, 'ID_Product'>): Promise<Product> {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .input("Name", sql.NVarChar, data.Name)
      .input("Price", sql.Money, data.Price)
      .input("Quantity", sql.Int, data.Quantity)
      .input("Description", sql.NVarChar, data.Description)
      .input("Image", sql.NVarChar, data.Image)
      .input("ID_Category", sql.Int, data.ID_Category)
      .input("ID_Warranty", sql.Int, data.ID_Warranty)
      .input("ID_Material", sql.Int, data.ID_Material)
      .query(`
      INSERT INTO Product (Name, Price, Quantity, Description, Image, ID_Category, ID_Warranty, ID_Material)
      OUTPUT inserted.*
      VALUES (@Name, @Price, @Quantity, @Description, @Image, @ID_Category, @ID_Warranty, @ID_Material)
    `);
    return result.recordset[0];
  }

  async update(id: number, data: Partial<Product>): Promise<boolean> {
    const pool = await Database.getInstance();
    const sets = [];
    const request = pool.request().input("ID", sql.Int, id);

    for (const [key, value] of Object.entries(data)) {
      sets.push(`${key} = @${key}`);
      request.input(key, typeof value === 'number' ? sql.Int : sql.NVarChar, value);
    }

    const result = await request.query(`
    UPDATE Product SET ${sets.join(", ")} WHERE ID_Product = @ID
  `);

    return result.rowsAffected[0] > 0;
  }

  async delete(id: number): Promise<boolean> {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .input("ID", sql.Int, id)
      .query(`DELETE FROM Product WHERE ID_Product = @ID`);
    return result.rowsAffected[0] > 0;
  }
}
