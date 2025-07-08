export interface Order {
  id: number;
  customerId: number;
  orderDate: Date;
  total: number;
  status: string;
  saleId?: number;
  paymentMethod: string;
  shippingAddress: string;
}

export interface OrderDetail {
  id: number;
  orderId: number;
  productId: number;
  sizeId: number;
  quantity: number;
  unitPrice: number;
}
