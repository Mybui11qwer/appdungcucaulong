// routes/auth.route.ts
import { Router } from "express";
import container from "../configs/inversify.config";
import TYPES from "../configs/types";
import { AuthController } from "../controllers/Auth.Controller";

const router = Router();

const authController = container.get<AuthController>(TYPES.AuthController);

/**
 * @swagger
 * /login:
 *   post:
 *     summary: Đăng nhập
 *     tags:
 *       - Auth
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Đăng nhập thành công
 *       401:
 *         description: Sai thông tin đăng nhập
 */
router.post("/login", authController.login);

export default router;
