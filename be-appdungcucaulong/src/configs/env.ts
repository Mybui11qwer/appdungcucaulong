import dotenv from "dotenv";

dotenv.config();

class EnvConfig {
    private static instance: EnvConfig;
    private readonly env: NodeJS.ProcessEnv;

    private constructor() {
        this.env = process.env;

        const requiredCommonEnv = [
            "DB_SERVER",
            "DB_NAME",
            "PORT",
            "NODE_ENV",
            "JWT_SECRET",
            "JWT_EXPIRY"
        ] as const;

        for (const key of requiredCommonEnv) {
            if (!this.env[key]) {
                throw new Error(`Environment variable ${key} is required but not set.`);
            }
        }
        const useWindowsAuth = !this.env["DB_USER"];
        if (!useWindowsAuth) {
            const authRequired = ["DB_USER", "DB_PASSWORD"] as const;
            for (const key of authRequired) {
                if (!this.env[key]) {
                    throw new Error(`Environment variable ${key} is required but not set.`);
                }
            }
        }
    }

    public static getInstance(): EnvConfig {
        if (!EnvConfig.instance) {
            EnvConfig.instance = new EnvConfig();
        }
        return EnvConfig.instance;
    }

    public get<T>(key: string): string {
        return this.env[key] as string;
    }

    public getJwtSecret(): string {
        return this.get("JWT_SECRET");
    }

    public getJwtExpiry(): string {
        return this.get("JWT_EXPIRY");
    }
}

export default EnvConfig.getInstance();
