// Create Sequelize instance
import { Sequelize,DataTypes } from "sequelize";

const sequelize = new Sequelize(
    'ecommerce_store',
    'root',
    'Kingbear',
    {
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        dialect: 'mysql', // Change to your database dialect if needed
    }
);
const testConnection = async () => {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
};
testConnection();