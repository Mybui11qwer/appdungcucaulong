import { AddToCartDTO } from "../dto/request/giohang/cart.dto";
import Database from "../configs/db";

export class CartRepository {
  async findOrCreateCart(customerId: number) {
    const pool = await Database.getInstance();

    const result = await pool
      .request()
      .input("customerId", customerId)
      .query("SELECT * FROM Cart WHERE ID_Customer = @customerId");

    if (result.recordset.length > 0) return result.recordset[0];

    const insertResult = await pool
      .request()
      .input("customerId", customerId)
      .query(
        "INSERT INTO Cart (ID_Customer) VALUES (@customerId); SELECT * FROM Cart WHERE ID_Customer = @customerId"
      );

    return insertResult.recordset[0];
  }

  async addToCart(cartId: number, dto: AddToCartDTO) {
    const pool = await Database.getInstance();

    const existing = await pool
      .request()
      .input("cartId", cartId)
      .input("productId", dto.productId)
      .input("sizeId", dto.sizeId)
      .query(`
        SELECT * FROM CartItem
        WHERE ID_Cart = @cartId AND ID_Product = @productId AND ID_Size = @sizeId
      `);

    if (existing.recordset.length > 0) {
      return await pool
        .request()
        .input("cartItemId", existing.recordset[0].ID_CartItem)
        .input("quantity", dto.quantity)
        .query(`
          UPDATE CartItem
          SET Quantity = Quantity + @quantity
          WHERE ID_CartItem = @cartItemId;

          SELECT * FROM CartItem WHERE ID_CartItem = @cartItemId
        `);
    } else {
      const insert = await pool
        .request()
        .input("cartId", cartId)
        .input("productId", dto.productId)
        .input("sizeId", dto.sizeId)
        .input("quantity", dto.quantity)
        .query(`
          INSERT INTO CartItem (ID_Cart, ID_Product, ID_Size, Quantity)
          VALUES (@cartId, @productId, @sizeId, @quantity);

          SELECT * FROM CartItem
          WHERE ID_Cart = @cartId AND ID_Product = @productId AND ID_Size = @sizeId
        `);
      return insert.recordset;
    }
  }

  async getCartItemsByCustomer(customerId: number) {
    const pool = await Database.getInstance();

    const result = await pool.request().input("customerId", customerId).query(`
      SELECT ci.*, p.Name, p.Price, p.Image, s.Name AS SizeName
      FROM Cart c
      JOIN CartItem ci ON c.ID_Cart = ci.ID_Cart
      JOIN Product p ON ci.ID_Product = p.ID_Product
      JOIN Size s ON ci.ID_Size = s.ID_Size
      WHERE c.ID_Customer = @customerId
    `);

    return result.recordset;
  }

  async updateQuantity(cartItemId: number, quantity: number) {
    const pool = await Database.getInstance();

    const result = await pool
      .request()
      .input("cartItemId", cartItemId)
      .input("quantity", quantity)
      .query(`
        UPDATE CartItem
        SET Quantity = @quantity
        WHERE ID_CartItem = @cartItemId;

        SELECT * FROM CartItem WHERE ID_CartItem = @cartItemId
      `);
    return result.recordset[0];
  }

  async removeFromCart(cartItemId: number) {
    const pool = await Database.getInstance();

    return await pool
      .request()
      .input("cartItemId", cartItemId)
      .query("DELETE FROM CartItem WHERE ID_CartItem = @cartItemId");
  }
}
