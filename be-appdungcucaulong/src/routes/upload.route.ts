import { Router } from 'express';
import { uploadImage } from '../controllers/upload.controller';
import { upload } from '../middlewares/upload.middleware';
import fs from 'fs';
import path from 'path';
import { Request, Response } from 'express';

const router = Router();

/**
 * @swagger
 * /api/public/image:
 *   post:
 *     summary: Upload ảnh sản phẩm
 *     tags: [Upload]
 *     consumes:
 *       - multipart/form-data
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               image:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Upload thành công
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: Upload thành công
 *                 imageUrl:
 *                   type: string
 *                   example: http://localhost:3000/public/images/1699999999999-image.jpg
 *       400:
 *         description: Không có file được gửi
 */
router.post('/image', upload.single('image'), uploadImage);

router.get('/images', (req: Request, res: Response) => {
  const dirPath = path.join(__dirname, '../../public/images');

  fs.readdir(dirPath, (err, files) => {
    if (err) {
      return res.status(500).json({ message: 'Lỗi đọc thư mục ảnh', error: err.message });
    }

    const imageUrls = files.map(filename => {
      return `${req.protocol}://${req.get('host')}/uploads/images/${filename}`;
    });

    res.status(200).json({ images: imageUrls });
  });
});

export default router;
