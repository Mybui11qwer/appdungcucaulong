import { Request, Response } from 'express';
import { OrderService } from '../services/order.service';

export const OrderController = {
  async create(req: Request, res: Response) {
    try {
      const orderId = await OrderService.createOrder(req.body);
      res.status(201).json({ message: 'Đặt hàng thành công', orderId });
    } catch (err) {
      res.status(500).json({ message: 'Lỗi khi tạo đơn hàng', error: err });
    }
  },

  async getByCustomer(req: Request, res: Response) {
    const customerId = Number(req.params.customerId);
    const orders = await OrderService.getOrdersForCustomer(customerId);
    res.json(orders);
  },

  async getDetail(req: Request, res: Response) {
    const orderId = Number(req.params.orderId);
    const detail = await OrderService.getOrderDetail(orderId);
    res.json(detail);
  },

  // order.controller.ts
  async updateStatus(req: Request, res: Response) {
    try {
      const orderId = Number(req.params.orderId);
      const { status } = req.body;
      await OrderService.updateStatus(orderId, status);
      res.json({ message: 'Cập nhật trạng thái đơn hàng thành công' });
    } catch (err) {
      res.status(500).json({ message: 'Lỗi khi cập nhật trạng thái', error: err });
    }
  },

  async getAll(req: Request, res: Response) {
    const orders = await OrderService.getAllOrders();
    res.json(orders);
  },

  async getDetailByCustomer(req: Request, res: Response) {
    const customerId = Number(req.params.customerId);
    const detail = await OrderService.getOrderDetailByCustomer(customerId);
    res.json(detail);
  },

  async cancelOrder(req: Request, res: Response) {
    try {
      const orderId = Number(req.params.orderId);
      await OrderService.cancelOrder(orderId);
      res.json({ message: 'Đơn hàng đã được hủy thành công' });
    } catch (err) {
      res.status(500).json({ message: 'Lỗi khi hủy đơn hàng', error: err });
    }
  }
};
