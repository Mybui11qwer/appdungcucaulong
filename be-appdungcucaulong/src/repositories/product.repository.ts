import Database from '../configs/db';
import { Product } from '../interfaces/models/product.interface';

export const getAllProducts = async (): Promise<Product[]> => {
  const pool = Database;
  const result = await pool.request().execute('sp_GetAllProducts');
  return result.recordset;
};
