import { Router } from "express";
import { CartController } from "../controllers/cart.controller";
import { verifyToken } from "../middlewares/auth.middleware";

const router = Router();
const controller = new CartController();

/**
 * @swagger
 * /cart:
 *   get:
 *     summary: Lấy danh sách sản phẩm trong giỏ hàng
 *     tags: [Cart]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Danh sách sản phẩm trong giỏ
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/CartItem'
 */
router.get("/", verifyToken, controller.getCart);

/**
 * @swagger
 * /cart/add:
 *   post:
 *     summary: Thêm sản phẩm vào giỏ hàng
 *     tags: [Cart]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - productId
 *               - sizeId
 *               - quantity
 *             properties:
 *               productId:
 *                 type: integer
 *               sizeId:
 *                 type: integer
 *               quantity:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Thêm sản phẩm vào giỏ hàng thành công
 */
router.post("/add", verifyToken, controller.addToCart);

/**
 * @swagger
 * /cart/remove:
 *   delete:
 *     summary: Xóa sản phẩm khỏi giỏ hàng
 *     tags: [Cart]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - cartItemId
 *             properties:
 *               cartItemId:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Xóa thành công
 */
router.delete("/remove", verifyToken, controller.removeFromCart);

export default router;
