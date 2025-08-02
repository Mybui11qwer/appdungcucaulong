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
  async create(product: Product): Promise<void> {
    const pool = await Database.getInstance();
    await pool.request()
      .input("ID_Category", sql.Int, product.ID_Category)
      .input("ID_Warranty", sql.Int, product.ID_Warranty)
      .input("ID_Material", sql.Int, product.ID_Material)
      .input("Name", sql.NVarChar, product.Name)
      .input("Price", sql.Float, product.Price)
      .input("Quantity", sql.Int, product.Quantity)
      .input("Description", sql.NVarChar, product.Description)
      .input("Image", sql.NVarChar, product.Image)
      .query(`
      INSERT INTO Product (ID_Category, ID_Warranty, ID_Material, Name, Price, Quantity, Description, Image)
      VALUES (@ID_Category, @ID_Warranty, @ID_Material, @Name, @Price, @Quantity, @Description, @Image)
    `);
  }

  async update(id: number, product: Product): Promise<void> {
    const pool = await Database.getInstance();
    await pool.request()
      .input("id", sql.Int, id)
      .input("ID_Category", sql.Int, product.ID_Category)
      .input("ID_Warranty", sql.Int, product.ID_Warranty)
      .input("ID_Material", sql.Int, product.ID_Material)
      .input("Name", sql.NVarChar, product.Name)
      .input("Price", sql.Float, product.Price)
      .input("Quantity", sql.Int, product.Quantity)
      .input("Description", sql.NVarChar, product.Description)
      .input("Image", sql.NVarChar, product.Image)
      .query(`
      UPDATE Product
      SET ID_Category = @ID_Category,
          ID_Warranty = @ID_Warranty,
          ID_Material = @ID_Material,
          Name = @Name,
          Price = @Price,
          Quantity = @Quantity,
          Description = @Description,
          Image = @Image
      WHERE ID_Product = @id
    `);
  }

  async delete(id: number): Promise<void> {
    const pool = await Database.getInstance();
    await pool.request()
      .input("id", sql.Int, id)
      .query(`DELETE FROM Product WHERE ID_Product = @id`);
  }
}
