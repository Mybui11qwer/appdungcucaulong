import { Request, Response } from "express";
import { CartService } from "../services/cart.service";

const cartService = new CartService();

export class CartController {
    async addToCart(req: Request, res: Response): Promise<void> {
        try {
            const customerId = req.user?.id;
            if (!customerId) {
                res.status(401).json({ message: "Unauthorized" });
                return;
            }

            const result = await cartService.addToCart(customerId, req.body);
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json({ message: "Lỗi khi thêm vào giỏ hàng", error: err });
        }
    }

    async getCart(req: Request, res: Response): Promise<void> {
        try {
            const customerId = req.user?.id;
            if (!customerId) {
                res.status(401).json({ message: "Unauthorized" });
                return;
            }

            const result = await cartService.getCartByCustomerId(customerId);
            res.status(200).json(result);
        } catch (err) {
            res.status(500).json({ message: "Lỗi khi lấy giỏ hàng", error: err });
        }
    }

    async updateQuantity(req: Request, res: Response): Promise<void> {
        try {
            const customerId = req.user?.id;
            if (!customerId) {
                res.status(401).json({ message: "Unauthorized" });
                return;
            }

            const result = await cartService.updateQuantity(customerId, req.body);
            res.status(200).json({ message: "Cập nhật số lượng thành công", result });
        } catch (err) {
            res.status(500).json({ message: "Lỗi khi cập nhật số lượng", error: err });
        }
    }

    async removeFromCart(req: Request, res: Response): Promise<void> {
        try {
            const customerId = req.user?.id;
            if (!customerId) {
                res.status(401).json({ message: "Unauthorized" });
                return;
            }

            const result = await cartService.removeFromCart(customerId, req.body);
            res.status(200).json({ message: "Xóa thành công", result });
        } catch (err) {
            res.status(500).json({ message: "Lỗi khi xóa khỏi giỏ hàng", error: err });
        }
    }
}
