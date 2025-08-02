import Database from '../configs/db';
import { Customer } from '../interfaces/models/customer.model';
import sql from 'mssql';

export const getCustomerById = async (id: number): Promise<Customer | null> => {
  const pool = await Database.getInstance(); // Bạn nên expose connection từ Database
  const request = pool.request();

  request.input('id', sql.Int, id);

  const result = await request.query(`
    SELECT
      ID_Customer as id,
      Username as username,
      Email as email,
      Phone as phone,
      Address as address,
      Gender as gender,
      Avatar as avatar,
      Role as role
    FROM Customer
    WHERE ID_Customer = @id
  `);

  return result.recordset[0] || null;
};

// src/repositories/customer.repository.ts
export const getAllCustomers = async (): Promise<Customer[]> => {
  const pool = await Database.getInstance();
  const result = await pool.request().query(`
    SELECT
      ID_Customer as id,
      Username as username,
      Email as email,
      Phone as phone,
      Address as address,
      Gender as gender,
      Avatar as avatar,
      Role as role
    FROM Customer
  `);
  return result.recordset;
};
