const connection = "Crear conexion";

class DatabaseController {
    getDatabases(res, req) {
        res.json({
            cont: 5,
            databasesNames: [
                "DB1", "DB2", "DB3", "DB4", "DB5"
            ]
        })
    }

    getTables(res, req) {
        const { database } = req;

        res.json({
            count: 3,
            tablesNames: [
                "TB1", "TB2", "TB3",
            ]
        });
    }
}

export default new DatabaseController();