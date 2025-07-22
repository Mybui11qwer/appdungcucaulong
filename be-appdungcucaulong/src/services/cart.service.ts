import { CartRepository } from "../repositories/cart.repository";
import { AddToCartDTO, RemoveFromCartDTO, UpdateQuantityDTO } from "../dto/request/giohang/cart.dto";

export class CartService {
  private repo = new CartRepository();

  async addToCart(customerId: number, dto: AddToCartDTO) {
    const cart = await this.repo.findOrCreateCart(customerId);
    return this.repo.addToCart(cart.ID_Cart, dto);
  }

  async getCartByCustomerId(customerId: number) {
    return this.repo.getCartItemsByCustomer(customerId);
  }

  async updateQuantity(customerId: number, dto: UpdateQuantityDTO) {
  // Optional: Verify item belongs to customer's cart
  return this.repo.updateQuantity(dto.cartItemId, dto.quantity);
  }

  async removeFromCart(customerId: number, dto: RemoveFromCartDTO) {
    // Optional: verify item belongs to customer's cart
    return this.repo.removeFromCart(dto.cartItemId);
  }
}
