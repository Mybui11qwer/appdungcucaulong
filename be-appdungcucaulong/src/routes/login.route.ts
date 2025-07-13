import { Router } from "express";
import { AuthController } from "../controllers/Auth.Controller";
import { CustomerRepository } from "../repositories/auth.repository";
import { AuthService } from "../services/auth.service";

const customerRepo = new CustomerRepository();
const authService = new AuthService(customerRepo);
const authController = new AuthController(authService);

const router = Router();

/**
 * @swagger
 * /api/register:
 *   post:
 *     summary: Đăng ký khách hàng mới
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               Username:
 *                 type: string
 *               Email:
 *                 type: string
 *               Phone:
 *                 type: string
 *               Password:
 *                 type: string
 *     responses:
 *       201:
 *         description: Đăng ký thành công
 *       400:
 *         description: Lỗi đầu vào
 */
router.post("/register", (req, res) => authController.register(req, res));

/**
 * @swagger
 * /api/login:
 *   post:
 *     summary: Đăng nhập tài khoản khách hàng
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               Email:
 *                 type: string
 *               Password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Đăng nhập thành công
 *       401:
 *         description: Sai thông tin đăng nhập
 */
router.post("/login", (req, res) => authController.login(req, res));

export default router;
