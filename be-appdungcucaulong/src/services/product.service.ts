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

  async createProduct(product: Product): Promise<void> {
    await this.productRepository.create(product);
  }

  async updateProduct(id: number, product: Product): Promise<void> {
    await this.productRepository.update(id, product);
  }

  async deleteProduct(id: number): Promise<void> {
    await this.productRepository.delete(id);
  }
}
