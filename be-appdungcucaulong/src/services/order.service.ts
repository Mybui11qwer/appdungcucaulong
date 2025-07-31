import { CreateOrderDTO } from '../dto/request/donhang/create-order.dto';
import { OrderRepository } from '../repositories/order.repository';

export const OrderService = {
  async createOrder(order: CreateOrderDTO) {
    const orderId = await OrderRepository.createOrder(order);
    await OrderRepository.createOrderDetails(orderId, order.products);
    return orderId;
  },

  async getOrdersForCustomer(customerId: number) {
    return await OrderRepository.getOrdersByCustomer(customerId);
  },

  async getOrderDetail(orderId: number) {
    const items = await OrderRepository.getOrderDetails(orderId);
    return items;
  },

  async cancelOrder(orderId: number) {
    await OrderRepository.cancelOrder(orderId);
  }
};