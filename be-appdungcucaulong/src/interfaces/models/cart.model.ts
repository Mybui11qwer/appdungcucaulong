export interface Cart {
  ID_Cart: number;
  ID_Customer: number;
  CreatedAt: Date;
}

export interface CartItem {
  ID_CartItem: number;
  ID_Cart: number;
  ID_Product: number;
  ID_Size: number;
  Quantity: number;
}
