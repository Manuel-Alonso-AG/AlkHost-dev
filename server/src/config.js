import { env } from "node:process";

const { PORT = 3000 } = env;

export const port = PORT;
