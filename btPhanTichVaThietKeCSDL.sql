CREATE TABLE `customers` (
  `customer_number` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `contact_lastname` varchar(50) NOT NULL,
  `contact_firstname` varchar(50) NOT NULL,
  `address_line_1` varchar(50) NOT NULL,
  `address_line_2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `postal_code` varchar(15) NOT NULL,
  `country` varchar(50) NOT NULL,
  `credit_limit` double DEFAULT NULL,
  `office_code` varchar(10) NOT NULL,
  PRIMARY KEY (`customer_number`),
  KEY `customers_fk` (`office_code`),
  CONSTRAINT `customers_fk` FOREIGN KEY (`office_code`) REFERENCES `offices` (`office_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `product_line` (
  `product_line` varchar(50) NOT NULL,
  `text_description` text,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`product_line`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `products` (
  `product_code` varchar(15) NOT NULL,
  `product_name` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `product_vendor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `quantity_in_stock` int NOT NULL,
  `buy_price` double NOT NULL,
  `MSRP` double NOT NULL,
  `product_scale` varchar(10) NOT NULL,
  `product_description` text NOT NULL,
  `product_line` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`product_code`),
  KEY `products_fk` (`product_line`),
  CONSTRAINT `products_fk` FOREIGN KEY (`product_line`) REFERENCES `product_line` (`product_line`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `orders` (
  `order_number` int NOT NULL,
  `order_date` date NOT NULL,
  `required_date` date NOT NULL,
  `shipped_date` date DEFAULT NULL,
  `status` varchar(15) NOT NULL,
  `comments` text,
  `quantity_ordered` int NOT NULL,
  `price_each` double NOT NULL,
  `customer_number` int NOT NULL,
  PRIMARY KEY (`order_number`),
  KEY `orders_fk` (`customer_number`),
  CONSTRAINT `orders_fk` FOREIGN KEY (`customer_number`) REFERENCES `customers` (`customer_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `payments` (
  `customer_number` int NOT NULL,
  `check_number` varchar(50) NOT NULL,
  `payment_date` date NOT NULL,
  `amount` double NOT NULL,
  `sale_rep_employee_number` int NOT NULL,
  KEY `payments_fk` (`customer_number`),
  KEY `payments_to_employee_fk` (`sale_rep_employee_number`),
  CONSTRAINT `payments_fk` FOREIGN KEY (`customer_number`) REFERENCES `customers` (`customer_number`),
  CONSTRAINT `payments_to_employee_fk` FOREIGN KEY (`sale_rep_employee_number`) REFERENCES `employees` (`employee_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `employees` (
  `employee_number` int NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `report_to` int DEFAULT NULL,
  PRIMARY KEY (`employee_number`),
  KEY `employees_fk` (`report_to`),
  CONSTRAINT `employees_fk` FOREIGN KEY (`report_to`) REFERENCES `employees` (`employee_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `offices` (
  `office_code` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address_line_1` varchar(50) NOT NULL,
  `address_line_2` varchar(50) DEFAULT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `postal_code` varchar(15) NOT NULL,
  PRIMARY KEY (`office_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `order_details` (
  `order_number` int NOT NULL,
  `product_code` varchar(15) NOT NULL,
  KEY `order_details_fk` (`order_number`),
  KEY `order_details_product_fk` (`product_code`),
  CONSTRAINT `order_details_fk` FOREIGN KEY (`order_number`) REFERENCES `orders` (`order_number`),
  CONSTRAINT `order_details_product_fk` FOREIGN KEY (`product_code`) REFERENCES `products` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci.