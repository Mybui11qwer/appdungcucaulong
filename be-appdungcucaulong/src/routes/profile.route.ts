// src/routes/profile.route.ts
import { Router } from 'express';
import { getProfileController } from '../controllers/profile.controller';
import { verifyToken } from '../middlewares/auth.middleware';

const router = Router();

/**
 * @swagger
 * /api/user/profile:
 *   get:
 *     summary: Lấy thông tin người dùng đang đăng nhập
 *     tags: [User]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lấy thông tin profile thành công
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                       example: 1
 *                     username:
 *                       type: string
 *                       example: phamliem
 *                     email:
 *                       type: string
 *                       example: liemp966@gmail.com
 *                     phone:
 *                       type: string
 *                       example: 0123456789
 *                     address:
 *                       type: string
 *                       example: 123 Nguyễn Trãi, Hà Nội
 *                     gender:
 *                       type: string
 *                       example: Nam
 *                     avatar:
 *                       type: string
 *                       example: https://i.pravatar.cc/150?img=3
 *                     role:
 *                       type: string
 *                       example: Customer
 *       401:
 *         description: Không có token hoặc token không hợp lệ
 *       500:
 *         description: Lỗi máy chủ
 */
router.get('/profile', verifyToken, getProfileController);

export default router;
