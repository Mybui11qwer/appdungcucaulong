export interface AddToCartDTO {
  productId: number;
  sizeId: number;
  quantity: number;
}

export interface RemoveFromCartDTO {
  cartItemId: number;
}

export interface UpdateQuantityDTO {  
  cartItemId: number;
  quantity: number;
}

