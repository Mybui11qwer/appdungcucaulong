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
  }
};
