import * as ProductRepo from '../repositories/product.repository';
import { Product } from '../interfaces/models/product.interface';

export const getProducts = async (): Promise<Product[]> => {
  return await ProductRepo.getAllProducts();
};
