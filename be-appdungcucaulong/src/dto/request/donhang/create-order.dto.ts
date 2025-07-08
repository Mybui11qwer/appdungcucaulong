export interface CreateOrderDTO {
  customerId: number;
  paymentMethod: string;
  shippingAddress: string;
  saleId?: number;
  products: {
    productId: number;
    sizeId: number;
    quantity: number;
    unitPrice: number;
  }[];
}
