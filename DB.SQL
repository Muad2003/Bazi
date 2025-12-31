CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  line_uid VARCHAR(100) UNIQUE NOT NULL,
  name VARCHAR(100),
  gender VARCHAR(20),
  phone VARCHAR(20),
  birth_date DATE,
  birth_time TIME,
  birth_place VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_elements (
  id SERIAL PRIMARY KEY,
  user_id INTEGER UNIQUE NOT NULL,
  main_element VARCHAR(50) NOT NULL,
  favorable_elements JSONB NOT NULL,
  unfavorable_elements JSONB NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE TABLE restaurants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menus (
  id SERIAL PRIMARY KEY,
  restaurant_id INTEGER NOT NULL,
  name VARCHAR(150) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  element VARCHAR(50) NOT NULL,
  image_url TEXT,
  status VARCHAR(20) CHECK (status IN ('AVAILABLE','UNAVAILABLE')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(id)
    ON DELETE CASCADE
);

CREATE TABLE promotions (
  id SERIAL PRIMARY KEY,
  menu_id INTEGER UNIQUE NOT NULL,
  description TEXT,
  discount_value DECIMAL(5,2),
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  status VARCHAR(20) CHECK (status IN ('AVAILABLE','UNAVAILABLE')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_menu
    FOREIGN KEY (menu_id)
    REFERENCES menus(id)
    ON DELETE CASCADE
);

CREATE TABLE coupons (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  promotion_id INTEGER NOT NULL,
  code VARCHAR(100) UNIQUE NOT NULL,
  status VARCHAR(20) CHECK (status IN ('UNUSED','USED','EXPIRED')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_coupon_user
    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE,

  CONSTRAINT fk_coupon_promotion
    FOREIGN KEY (promotion_id)
    REFERENCES promotions(id)
    ON DELETE CASCADE
);