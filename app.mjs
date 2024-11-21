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

// Define the Reviews Model
// This model represents the 'reviews' table in the database
const Review = sequelize.define('Review', {
    // Primary key: Auto-incrementing integer for unique review IDs
    review_id: { 
      type: DataTypes.INTEGER, 
      autoIncrement: true, 
      primaryKey: true 
    },
    // Foreign key: Links the review to a specific product
    product_id: { 
      type: DataTypes.INTEGER, 
      allowNull: false // Ensures that every review is associated with a product
    },
    // Foreign key: Links the review to a specific customer
    customer_id: { 
      type: DataTypes.INTEGER, 
      allowNull: false // Ensures that every review is associated with a customer
    },
    // The main review content, allowing users to leave detailed feedback
    review_content: { 
      type: DataTypes.TEXT // Supports long-form text for detailed reviews
    },
    // The numeric rating provided by the customer
    rating: { 
      type: DataTypes.INTEGER, 
      allowNull: false, // A rating is required for every review
      validate: { 
        min: 1, // Minimum rating value (1 - lowest rating)
        max: 5  // Maximum rating value (5 - highest rating)
      } 
    },
    // The timestamp indicating when the review was created
    review_date: { 
      type: DataTypes.DATE, 
      defaultValue: Sequelize.NOW // Automatically sets the current timestamp when a review is created
    },
  }, {
    timestamps: false, // Disables Sequelize's automatic `createdAt` and `updatedAt` fields
    tableName: 'reviews', // Specifies the exact table name in the database
  });
  
  // Sync and Populate the Table
  (async () => {
    try {
      // Synchronize the Reviews table
      // 'force: true' ensures the table structure matches the model by dropping and recreating it
      await sequelize.sync({ force: true }); 
      console.log('Reviews table created!');
  
      // Insert Sample Data into the Reviews table
      // Adds several example reviews to the database for testing purposes
      const reviews = await Review.bulkCreate([
        { 
          product_id: 1, 
          customer_id: 1, 
          review_content: 'Amazing laptop, totally worth the price!', 
          rating: 5 // A perfect rating for a satisfied customer
        },
        { 
          product_id: 2, 
          customer_id: 2, 
          review_content: 'The smartphone is decent but battery life could be better.', 
          rating: 3 // A neutral rating with constructive feedback
        },
        { 
          product_id: 3, 
          customer_id: 3, 
          review_content: 'Noise-canceling is excellent, and it’s very comfortable.', 
          rating: 4 // A high rating indicating satisfaction with minor room for improvement
        },
        { 
          product_id: 4, 
          customer_id: 1, 
          review_content: 'Great tablet for the price. Very lightweight.', 
          rating: 5 // Another perfect rating praising value for money
        },
        { 
          product_id: 5, 
          customer_id: 2, 
          review_content: 'The 4K monitor is stunning, but it’s pricey.', 
          rating: 4 // A high rating with a note about cost
        },
      ]);
  
      console.log('Sample reviews inserted successfully!');
    } catch (error) {
      // Handles any errors that occur during table creation or data insertion
      console.error('Error creating or populating the reviews table:', error);
    } finally {
      // Ensures the database connection is closed after all operations are complete
      await sequelize.close();
    }
  })();
  


  
 