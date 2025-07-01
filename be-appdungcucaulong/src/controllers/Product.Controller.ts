import { Request, Response } from 'express';
import * as ProductService from '../services/product.service';

export const getProducts = async (req: Request, res: Response) => {
  try {
    const products = await ProductService.getProducts();
    res.json(products);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err });
  }
};
