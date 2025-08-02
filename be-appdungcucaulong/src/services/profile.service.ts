// src/services/profile.service.ts
import { getAllCustomers, getCustomerById } from '../repositories/customer.repository';

export const getProfileService = async (id: number) => {
  const customer = await getCustomerById(id);
  if (!customer) throw new Error('Customer not found');
  return customer;
};

export const getAllCustomersService = async () => {
  return await getAllCustomers();
};
