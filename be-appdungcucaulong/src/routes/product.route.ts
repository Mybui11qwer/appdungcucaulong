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
 *     summary: Thêm sản phẩm mới
 *     tags: [Product]
 *     consumes:
 *       - multipart/form-data
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             required:
 *               - Name
 *               - Price
 *               - Quantity
 *               - Description
 *               - ID_Category
 *               - ID_Warranty
 *               - ID_Material
 *               - Image
 *             properties:
 *               Name:
 *                 type: string
 *               Price:
 *                 type: number
 *               Quantity:
 *                 type: integer
 *               Description:
 *                 type: string
 *               ID_Category:
 *                 type: integer
 *               ID_Warranty:
 *                 type: integer
 *               ID_Material:
 *                 type: integer
 *               Image:
 *                 type: string
 *                 format: binary
 *     responses:
 *       201:
 *         description: Sản phẩm được tạo thành công
 *       400:
 *         description: Dữ liệu không hợp lệ
 */
router.post("/", upload.single("Image"), productController.create);

/**
 * @swagger
 * /api/products/{id}:
 *   put:
 *     summary: Cập nhật sản phẩm theo ID
 *     tags: [Product]
 *     consumes:
 *       - multipart/form-data
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID sản phẩm
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               Name:
 *                 type: string
 *               Price:
 *                 type: number
 *               Quantity:
 *                 type: integer
 *               Description:
 *                 type: string
 *               ID_Category:
 *                 type: integer
 *               ID_Warranty:
 *                 type: integer
 *               ID_Material:
 *                 type: integer
 *               Image:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Sản phẩm đã được cập nhật
 *       400:
 *         description: Dữ liệu không hợp lệ
 *       404:
 *         description: Không tìm thấy sản phẩm
 */
router.put("/:id", upload.single("Image"), productController.update);

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
 *         description: ID sản phẩm
 *     responses:
 *       200:
 *         description: Đã xoá sản phẩm
 *       404:
 *         description: Không tìm thấy sản phẩm
 */
router.delete("/:id", productController.delete);

export default router;
