import { env } from "node:process";

const { PORT = 3000,
    PHP_PORT = 9000,
 } = env;

export const port = PORT;
export const php_port = PHP_PORT;
