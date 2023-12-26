--https://stackoverflow.com/questions/1481476/when-to-use-on-update-cascade
--"It's true that if your primary key is just an identity value auto incremented, you would have no real use for ON UPDATE CASCADE."
--"If you follow database design best practices and your primary key is never updatable (which I think should always be the case anyway), then you never really need the ON UPDATE CASCADE clause."

-- Anyway, przykład:
-- CREATE TABLE categories
-- (
--     id INT PRIMARY KEY,
--     name NVARCHAR(255) NOT NULL,
--     slug NVARCHAR(255) UNIQUE NOT NULL
-- );

-- CREATE TABLE subcategories
-- (
--     id INT PRIMARY KEY,
--     name NVARCHAR(255) NOT NULL,
--     slug NVARCHAR(255) NOT NULL,
--     category_id INT NOT NULL,
--     FOREIGN KEY (category_id) REFERENCES categories(id) ON UPDATE CASCADE
-- );