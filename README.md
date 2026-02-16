🛒 Zepto Product Analytics — PostgreSQL Project
A structured SQL project that explores and analyzes Zepto's product catalog data using PostgreSQL. This project covers database setup, data cleaning, and actionable business insights through analytical queries.

🗄️ Database Schema
The project uses a single table zepto:
ColumnTypeDescriptionsku_idSERIAL PRIMARY KEYUnique product identifiercategoryVARCHAR(120)Product categorynameVARCHAR(150)Product name (NOT NULL)mrpNUMERIC(8,2)Maximum Retail PricediscountPercentNUMERIC(5,2)Discount percentage offeredavailableQuantityINTEGERUnits currently in stockdiscountedSellingPriceNUMERIC(8,2)Final price after discountweightInGmsINTEGERProduct weight in gramsoutOfStockBOOLEANStock availability flagquantityINTEGERQuantity unit

🔍 Data Exploration
Before analysis, the dataset was explored to assess structure and quality:

Row Count — Total number of records in the table
Sample Data — First 10 rows to preview the dataset
NULL Value Check — Identified missing values across all critical columns
Distinct Categories — Listed all unique product categories
Stock Status — Counted products in stock vs. out of stock
Duplicate Names — Products appearing with multiple SKUs

🧹 Data Cleaning
Two cleaning steps were applied before analysis:
1. Removed Zero-Price Products
Products where mrp = 0 were deleted as they represent invalid or placeholder entries that would distort results.
2. Currency Conversion: Paise → Rupees
Raw data stored prices in paise (1 Rupee = 100 Paise). Both mrp and discountedSellingPrice were divided by 100.
sqlUPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

📊 Analysis Queries
1. 🏷️ Top 10 Best-Value Products by Discount
Identifies products with the highest discount percentages — useful for deal discovery and promotional benchmarking.
2. 📦 High-MRP Products That Are Out of Stock
Flags premium products (MRP > ₹300) currently unavailable — supports restocking prioritization and demand planning.
3. 💰 Estimated Revenue by Category
Calculates potential revenue per category using discountedSellingPrice × availableQuantity, revealing the highest-value categories.
4. 💸 Premium Products with Low Discounts
Finds products priced above ₹500 with discounts below 10% — useful for identifying pricing and promotional opportunities.
5. 🎯 Top 5 Categories by Average Discount
Ranks categories by average discount to reveal where Zepto is most aggressive with promotions.
6. ⚖️ Best Value by Price Per Gram
For products above 100g, computes discountedSellingPrice / weightInGms to surface the most economical options — ideal for value-conscious shoppers.
7. 📐 Product Weight Classification
Segments products into weight tiers using a CASE expression:
Weight RangeTierUnder 1,000gLow1,000g – 4,999gMedium5,000g and aboveBulk
8. 🏭 Total Inventory Weight by Category
Computes weightInGms × availableQuantity per category to assess physical stock load — relevant for logistics and warehouse planning.

💡 Key Business Questions Answered

Which product categories generate the most estimated revenue?
Which high-value products are out of stock and need restocking?
Where is Zepto offering the steepest discounts?
Which products give consumers the best value per gram?
How is inventory weight distributed across categories?


📌 Notes

Prices in the raw data were stored in paise and converted to rupees during cleaning.
DISTINCT is used throughout since one product name can have multiple SKUs.
Revenue figures are estimated based on available quantity — actual transactional data is needed for true revenue reporting.


Built with PostgreSQL | Data Source: https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data?select=zepto_v2.csv
