import { injectable } from "inversify";
import sql from "mssql";
import EnvConfig from "./env";

@injectable()
class Database {
    private readonly pool: sql.ConnectionPool;
    static request: sql.Request;

    constructor() {
        const dbConfig: sql.config = {
            user: EnvConfig.get("DB_USER") || "",
            password: EnvConfig.get("DB_PASSWORD") || "",
            server: EnvConfig.get("DB_SERVER") || "",
            database: EnvConfig.get("DB_NAME") || "",
            options: {
                encrypt: false, // Nếu không dùng Azure thì để false
                trustServerCertificate: true, // Bỏ lỗi SSL khi dùng local
            },
        };

        this.pool = new sql.ConnectionPool(dbConfig);
    }

    public async connect(): Promise<void> {
        try {
            if (!this.pool.connected) {
                await this.pool.connect();
                Database.request = this.pool.request();
                console.log("✅ Connected to SQL Server");
            }
        } catch (err) {
            console.error("❌ Error connecting to SQL Server:", err);
            throw err;
        }
    }

    public async close(): Promise<void> {
        try {
            if (this.pool.connected) {
                await this.pool.close();
                console.log("🔌 Disconnected from SQL Server");
            }
        } catch (err) {
            console.error("❌ Error closing SQL Server connection:", err);
        }
    }

    public getPool(): sql.ConnectionPool {
        return this.pool;
    }
}

export default Database;
