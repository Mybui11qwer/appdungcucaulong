export interface OrderDetailDTO {
  id: number;
  orderDate: Date;
  total: number;
  status: string;
  shippingAddress: string;
  paymentMethod: string;
  items: {
    productId: number;
    sizeId: number;
    quantity: number;
    unitPrice: number;
  }[];
}
