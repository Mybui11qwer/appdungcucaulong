import { injectable } from "inversify";
import sql from "mssql";
import EnvConfig from "./env";

@injectable()
class Database {
  private static instance: sql.ConnectionPool;

  public static async getInstance(): Promise<sql.ConnectionPool> {
    if (!Database.instance) {
      const dbConfig: sql.config = {
        user: EnvConfig.get("DB_USER") || "",
        password: EnvConfig.get("DB_PASSWORD") || "",
        server: EnvConfig.get("DB_SERVER") || "",
        database: EnvConfig.get("DB_NAME") || "",
        options: {
          encrypt: false,
          trustServerCertificate: true,
        },
      };

      const pool = new sql.ConnectionPool(dbConfig);
      Database.instance = await pool.connect();
      console.log("✅ Connected to SQL Server");
    }

    return Database.instance;
  }
}

export default Database;
