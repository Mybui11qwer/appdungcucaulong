import { Container } from "inversify";
import TYPES from "./types";

import Database from "../configs/db"
import { AuthService } from "../services/auth.service";

// Controllers
import { AuthController } from "../controllers/Auth.Controller";

const container = new Container();
container.bind<Database>(TYPES.Database).to(Database).inSingletonScope();
container.bind<AuthService>(TYPES.AuthService).to(AuthService);
container.bind<AuthController>(TYPES.AuthController).to(AuthController);

export default container;
