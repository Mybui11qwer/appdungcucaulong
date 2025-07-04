import bcrypt from "bcryptjs";

export const hashPassword = async (raw: string) => {
  return await bcrypt.hash(raw, 10);
};

export const comparePassword = async (raw: string, hashed: string) => {
  return await bcrypt.compare(raw, hashed);
};