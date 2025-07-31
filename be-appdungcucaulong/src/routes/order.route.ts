import { Router } from 'express';
import { OrderController } from '../controllers/order.controller';

const router = Router();

/**
 * @swagger
 * /api/order:
 *   post:
 *     summary: Tạo đơn hàng mới
 *     tags: [Order]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               customerId:
 *                 type: string
 *               items:
 *                 type: array
 *                 items:
 *                   type: object
 *                   properties:
 *                     productId:
 *                       type: string
 *                     quantity:
 *                       type: integer
 *     responses:
 *       201:
 *         description: Tạo đơn hàng thành công
 *       400:
 *         description: Dữ liệu không hợp lệ
 */
router.post('/', OrderController.create);

/**
 * @swagger
 * /api/order/customer/{customerId}:
 *   get:
 *     summary: Lấy danh sách đơn hàng theo customer
 *     tags: [Order]
 *     parameters:
 *       - in: path
 *         name: customerId
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Danh sách đơn hàng của khách hàng
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Order'
 *       404:
 *         description: Không tìm thấy đơn hàng
 */
router.get('/customer/:customerId', OrderController.getByCustomer);

/**
 * @swagger
 * /api/order/{orderId}:
 *   get:
 *     summary: Lấy chi tiết đơn hàng
 *     tags: [Order]
 *     parameters:
 *       - in: path
 *         name: orderId
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Chi tiết đơn hàng
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Order'
 *       404:
 *         description: Không tìm thấy đơn hàng
 */
router.get('/:orderId', OrderController.getDetail);

/**
 * @swagger
 * /api/order/cancel/{orderId}:
 *   put:
 *     summary: Hủy đơn hàng
 *     tags: [Order]
 *     parameters:
 *       - in: path
 *         name: orderId
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Đơn hàng đã được hủy thành công
 *       500:
 *         description: Lỗi khi hủy đơn hàng
 */
router.put('/cancel/:orderId', OrderController.cancelOrder);

export default router;
