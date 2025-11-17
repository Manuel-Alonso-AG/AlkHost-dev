import mysql from 'mysql2/promise';

const db = await mysql.createPool({
    host: 'mysql',
    port: '3306',
    user: 'user',
    password: 'password'
});

class DatabaseController {
    async getDatabases(req, res) {
        try {
            const [rows] = await db.query('SHOW DATABASES;');
            res.json({ databases: rows })
        } catch (error) {
            res.status(500).json({
                error: error.message
            })

        }
    }

    async getTables(req, res) {
        const { database } = req.params;

        try {
            const [rows] = await db.query(
                "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = ?;",
                [database]
            );

            res.json({
                database,
                tables: rows.map(r => r.TABLE_NAME)
            });
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }
}

export default new DatabaseController();