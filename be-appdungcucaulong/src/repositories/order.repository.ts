import sql from "mssql";
import Database from "../configs/db";
import { CreateOrderDTO } from '../dto/request/donhang/create-order.dto';

export const OrderRepository = {
  async createOrder(order: CreateOrderDTO): Promise<number> {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .input('CustomerId', order.customerId)
      .input('Total', order.products.reduce((sum, p) => sum + p.quantity * p.unitPrice, 0))
      .input('Status', 'Processing')
      .input('SaleId', order.saleId ?? null)
      .input('PaymentMethod', order.paymentMethod)
      .input('ShippingAddress', order.shippingAddress)
      .query(`
      DECLARE @InsertedOrders TABLE (ID_Order INT);

      INSERT INTO [Order] (ID_Customer, Total, Status, ID_Sale, PaymentMethod, ShippingAddress)
      OUTPUT INSERTED.ID_Order INTO @InsertedOrders(ID_Order)
      VALUES (@CustomerId, @Total, @Status, @SaleId, @PaymentMethod, @ShippingAddress);

      SELECT ID_Order FROM @InsertedOrders;
    `);
    return result.recordset[0].ID_Order;
  },

  async createOrderDetails(orderId: number, products: CreateOrderDTO['products']) {
    const pool = await Database.getInstance();
    for (const p of products) {
      await pool.request()
        .input('OrderId', orderId)
        .input('ProductId', p.productId)
        .input('SizeId', p.sizeId)
        .input('Quantity', p.quantity)
        .input('UnitPrice', p.unitPrice)
        .query(`
          INSERT INTO Detail_Order (ID_Order, ID_Product, ID_Size, Quantity, Unit_Price)
          VALUES (@OrderId, @ProductId, @SizeId, @Quantity, @UnitPrice)
        `);
    }
  },

  async getOrdersByCustomer(customerId: number) {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .input('CustomerId', customerId)
      .query(`SELECT * FROM [Order] WHERE ID_Customer = @CustomerId ORDER BY Order_Date DESC`);
    return result.recordset;
  },

  async getOrderDetails(orderId: number) {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .input('OrderId', orderId)
      .query(`SELECT * FROM Detail_Order WHERE ID_Order = @OrderId`);
    return result.recordset;
  },

  // order.repository.ts
  async updateOrderStatus(orderId: number, status: string) {
    const pool = await Database.getInstance();
    await pool.request()
      .input('OrderId', orderId)
      .input('Status', status)
      .query(`UPDATE [Order] SET Status = @Status WHERE ID_Order = @OrderId`);
  },

  async getAllOrders() {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .query(`SELECT * FROM [Order]`);
    return result.recordset;
  },

  async getOrderDetailsByCustomer(customerId: number) {
    const pool = await Database.getInstance();
    const result = await pool.request()
      .input('CustomerId', customerId)
      .query(`
      SELECT o.*, d.ID_Product, d.ID_Size, d.Quantity, d.Unit_Price
      FROM [Order] o
      JOIN Detail_Order d ON o.ID_Order = d.ID_Order
      WHERE o.ID_Customer = @CustomerId
      ORDER BY o.Order_Date DESC
    `);
    return result.recordset;
  },

  async cancelOrder(orderId: number) {
    const pool = await Database.getInstance();
    await pool.request()
      .input('OrderId', orderId)
      .query(`UPDATE [Order] SET Status = 'Canceled' WHERE ID_Order = @OrderId`);
  }
};
