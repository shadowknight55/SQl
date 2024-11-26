// Import Sequelize and DataTypes modules
// Sequelize is used for interacting with the database
import { Sequelize, DataTypes } from "sequelize";

import dotenv from "dotenv"

dotenv.config();
// Create a Sequelize instance
// This instance connects to the 'ecommerce_store' database using the provided credentials
// Host and port are retrieved from environment variables
const sequelize = new Sequelize(
    
    {
        database: process.env.DB_NAME, // Database name  
        username: process.env.DB_USER,  // Database username
        password: process.env.DB_PASSWORD, // Database password
        host: process.env.DB_HOST, // Database host address
        port: process.env.DB_PORT, // Database port
        dialect: 'mysql'          // Type of database (MySQL in this case)
    }
);

// Test database connection
// Ensures that the database credentials and configurations are correct
const testConnection = async () => {
    try {
        // Attempt to authenticate with the database
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        // Log an error message if the connection fails
        console.error('Unable to connect to the database:', error);
    }
};
testConnection();

// Define the Reviews model
// This model represents the structure of the 'reviews' table in the database
const Review = sequelize.define('Review', {
    review_id: { 
        // Unique identifier for each review (primary key)
        type: DataTypes.INTEGER,
        autoIncrement: true, // Auto-incrementing ID
        primaryKey: true     // Designates this field as the primary key
    },
    product_id: { 
        // Links the review to a specific product (foreign key)
        type: DataTypes.INTEGER,
        allowNull: false // Ensures this field cannot be null
    },
    customer_id: { 
        // Links the review to a specific customer (foreign key)
        type: DataTypes.INTEGER,
        allowNull: false // Ensures this field cannot be null
    },
    review_content: { 
        // The main content of the review
        type: DataTypes.TEXT // Supports detailed text content
    },
    rating: { 
        // The numeric rating given by the customer
        type: DataTypes.INTEGER,
        allowNull: false, // A rating is mandatory for every review
        validate: { 
            min: 1, // Minimum allowable rating
            max: 5  // Maximum allowable rating
        }
    },
    review_date: { 
        // The timestamp when the review was created
        type: DataTypes.DATE,
        defaultValue: Sequelize.NOW // Automatically sets the current date and time
    },
}, {
    timestamps: false, // Disables automatic timestamp fields (createdAt, updatedAt)
    tableName: 'reviews', // Explicitly sets the table name in the database
});

// Sync and populate the Reviews table
// This function creates the table and inserts sample data
(async () => {
    try {
        // Synchronize the database with the Reviews model
        // force: true drops and recreates the table every time (useful for testing)
        await sequelize.sync({ force: true });
        console.log('Reviews table created!');

        // Add sample reviews to the 'reviews' table
        // Example data to simulate user reviews
        const reviews = await Review.bulkCreate([
            { 
                product_id: 1, 
                customer_id: 1, 
                review_content: 'Amazing laptop, totally worth the price!', 
                rating: 5 
            },
            { 
                product_id: 2, 
                customer_id: 2, 
                review_content: 'The smartphone is decent but battery life could be better.', 
                rating: 3 
            },
            { 
                product_id: 3, 
                customer_id: 3, 
                review_content: 'Noise-canceling is excellent, and it’s very comfortable.', 
                rating: 4 
            },
            { 
                product_id: 4, 
                customer_id: 1, 
                review_content: 'Great tablet for the price. Very lightweight.', 
                rating: 5 
            },
            { 
                product_id: 5, 
                customer_id: 2, 
                review_content: 'The 4K monitor is stunning, but it’s pricey.', 
                rating: 4 
            },
        ]);
        console.log('Sample reviews inserted successfully!');
    } catch (error) {
        // Log any errors during table creation or data insertion
        console.error('Error creating or populating the reviews table:', error);
    } finally {
        // Close the database connection to release resources
        await sequelize.close();
    }
})();
