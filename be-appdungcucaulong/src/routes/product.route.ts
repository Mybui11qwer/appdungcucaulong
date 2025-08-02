import { Router } from "express";
import { ProductController } from "../controllers/product.controller";
import { upload } from "../middlewares/upload.middleware";

const router = Router();
const productController = new ProductController();

/**
 * @swagger
 * /api/products:
 *   get:
 *     summary: Lấy toàn bộ sản phẩm
 *     tags: [Product]
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
router.get("/", productController.getAll);

/**
 * @swagger
 * /api/products/{id}:
 *   get:
 *     summary: Lấy chi tiết sản phẩm theo ID
 *     tags: [Product]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID của sản phẩm
 *     responses:
 *       200:
 *         description: Thông tin sản phẩm
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Product'
 *       400:
 *         description: ID không hợp lệ
 *       404:
 *         description: Không tìm thấy sản phẩm
 *       500:
 *         description: Lỗi server
 */
router.get("/:id", productController.getDetail);

/**
 * @swagger
 * /api/products:
 *   post:
 *     summary: Tạo sản phẩm mới
 *     tags: [Product]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - ID_Category
 *               - ID_Warranty
 *               - ID_Material
 *               - Name
 *               - Price
 *               - Quantity
 *               - Description
 *               - Image
 *             properties:
 *               ID_Category:
 *                 type: integer
 *               ID_Warranty:
 *                 type: integer
 *               ID_Material:
 *                 type: integer
 *               Name:
 *                 type: string
 *               Price:
 *                 type: number
 *               Quantity:
 *                 type: integer
 *               Description:
 *                 type: string
 *               Image:
 *                 type: string
 *                 example: "aoyonex.png"
 *     responses:
 *       201:
 *         description: Tạo sản phẩm thành công
 *       500:
 *         description: Lỗi server
 */
router.post("/", productController.create);

/**
 * @swagger
 * /api/products/{id}:
 *   put:
 *     summary: Cập nhật sản phẩm theo ID
 *     tags: [Product]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID của sản phẩm
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - ID_Category
 *               - ID_Warranty
 *               - ID_Material
 *               - Name
 *               - Price
 *               - Quantity
 *               - Description
 *               - Image
 *             properties:
 *               ID_Category:
 *                 type: integer
 *               ID_Warranty:
 *                 type: integer
 *               ID_Material:
 *                 type: integer
 *               Name:
 *                 type: string
 *               Price:
 *                 type: number
 *               Quantity:
 *                 type: integer
 *               Description:
 *                 type: string
 *               Image:
 *                 type: string
 *                 example: "aoyonex.png"
 *     responses:
 *       200:
 *         description: Cập nhật thành công
 *       400:
 *         description: ID không hợp lệ
 *       500:
 *         description: Lỗi server
 */
router.put("/:id", productController.update);

/**
 * @swagger
 * /api/products/{id}:
 *   delete:
 *     summary: Xoá sản phẩm theo ID
 *     tags: [Product]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID của sản phẩm cần xoá
 *     responses:
 *       200:
 *         description: Xoá thành công
 *       400:
 *         description: ID không hợp lệ
 *       500:
 *         description: Lỗi server
 */
router.delete("/:id", productController.delete);

export default router;
