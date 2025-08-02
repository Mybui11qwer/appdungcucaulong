import { injectable } from "inversify";
import { ProductRepository } from "../repositories/product.repository";
import { Product } from "../interfaces/models/product.model";

@injectable()
export class ProductService {
  private productRepository: ProductRepository;

  constructor() {
    this.productRepository = new ProductRepository();
  }

  async getAllProducts(): Promise<Product[]> {
    return this.productRepository.getAll();
  }

  async getProductDetail(id: number): Promise<any> {
    return this.productRepository.getById(id);
  }

  async createProduct(data: Omit<Product, 'ID_Product'>): Promise<Product> {
    return this.productRepository.create(data);
  }

  async updateProduct(id: number, data: Partial<Product>): Promise<boolean> {
    return this.productRepository.update(id, data);
  }

  async deleteProduct(id: number): Promise<boolean> {
    return this.productRepository.delete(id);
  }
}
