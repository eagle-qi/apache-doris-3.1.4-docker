-- Doris 数据库初始化脚本
-- 默认密码: doris123
-- 创建时间: 2026-03-16

-- 1. 创建测试数据库
CREATE DATABASE IF NOT EXISTS test_db;

USE test_db;

-- 2. 创建用户表
CREATE TABLE IF NOT EXISTS users (
    id BIGINT NOT NULL COMMENT "用户ID",
    username VARCHAR(50) NOT NULL COMMENT "用户名",
    email VARCHAR(100) COMMENT "邮箱",
    age INT COMMENT "年龄",
    gender VARCHAR(10) COMMENT "性别",
    city VARCHAR(50) COMMENT "城市",
    salary DECIMAL(10, 2) COMMENT "薪资",
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "创建时间",
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "更新时间"
)
DUPLICATE KEY(id)
DISTRIBUTED BY HASH(id) BUCKETS 10
PROPERTIES (
    "replication_num" = "1"
);

-- 3. 创建订单表
CREATE TABLE IF NOT EXISTS orders (
    order_id BIGINT NOT NULL COMMENT "订单ID",
    user_id BIGINT NOT NULL COMMENT "用户ID",
    product_name VARCHAR(100) NOT NULL COMMENT "产品名称",
    quantity INT NOT NULL DEFAULT 1 COMMENT "数量",
    price DECIMAL(10, 2) NOT NULL COMMENT "单价",
    total_amount DECIMAL(10, 2) AS (quantity * price) COMMENT "总金额",
    status VARCHAR(20) NOT NULL DEFAULT 'pending' COMMENT "状态: pending, paid, shipped, completed, cancelled",
    order_date DATE NOT NULL COMMENT "订单日期",
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "创建时间"
)
DUPLICATE KEY(order_id)
DISTRIBUTED BY HASH(order_id) BUCKETS 10
PROPERTIES (
    "replication_num" = "1"
);

-- 4. 创建产品表
CREATE TABLE IF NOT EXISTS products (
    product_id INT NOT NULL COMMENT "产品ID",
    product_name VARCHAR(100) NOT NULL COMMENT "产品名称",
    category VARCHAR(50) NOT NULL COMMENT "类别",
    price DECIMAL(10, 2) NOT NULL COMMENT "价格",
    stock_quantity INT NOT NULL DEFAULT 0 COMMENT "库存数量",
    description TEXT COMMENT "描述",
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "创建时间",
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "更新时间"
)
DUPLICATE KEY(product_id)
DISTRIBUTED BY HASH(product_id) BUCKETS 10
PROPERTIES (
    "replication_num" = "1"
);

-- 5. 创建日志表
CREATE TABLE IF NOT EXISTS user_logs (
    log_id BIGINT NOT NULL COMMENT "日志ID",
    user_id BIGINT NOT NULL COMMENT "用户ID",
    action VARCHAR(50) NOT NULL COMMENT "操作类型",
    action_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "操作时间",
    ip_address VARCHAR(50) COMMENT "IP地址",
    user_agent TEXT COMMENT "User Agent",
    details TEXT COMMENT "详细信息"
)
DUPLICATE KEY(log_id)
DISTRIBUTED BY HASH(log_id) BUCKETS 10
PROPERTIES (
    "replication_num" = "1"
);

-- 6. 插入测试数据 - 用户表
INSERT INTO users (id, username, email, age, gender, city, salary) VALUES
(1, '张三', 'zhangsan@example.com', 28, '男', '北京', 15000.00),
(2, '李四', 'lisi@example.com', 32, '男', '上海', 18000.00),
(3, '王五', 'wangwu@example.com', 25, '男', '深圳', 12000.00),
(4, '赵六', 'zhaoliu@example.com', 29, '女', '广州', 16000.00),
(5, '孙七', 'sunqi@example.com', 35, '女', '杭州', 20000.00),
(6, '周八', 'zhouba@example.com', 27, '男', '成都', 14000.00),
(7, '吴九', 'wujiu@example.com', 31, '男', '重庆', 17000.00),
(8, '郑十', 'zhengshi@example.com', 26, '女', '南京', 13000.00),
(9, '刘一', 'liuyi@example.com', 30, '男', '武汉', 16000.00),
(10, '陈二', 'chener@example.com', 33, '女', '西安', 19000.00);

-- 7. 插入测试数据 - 产品表
INSERT INTO products (product_id, product_name, category, price, stock_quantity, description) VALUES
(1, 'iPhone 15 Pro', '智能手机', 8999.00, 100, '苹果最新款旗舰手机'),
(2, 'MacBook Pro 16', '笔记本电脑', 18999.00, 50, '苹果专业级笔记本电脑'),
(3, '华为 Mate 60 Pro', '智能手机', 6999.00, 200, '华为旗舰手机'),
(4, '联想 ThinkPad X1', '笔记本电脑', 12999.00, 80, '商务笔记本电脑'),
(5, '小米 14 Ultra', '智能手机', 5999.00, 150, '小米影像旗舰手机'),
(6, '戴尔 XPS 13', '笔记本电脑', 9999.00, 60, '超薄笔记本电脑'),
(7, 'iPad Pro', '平板电脑', 7999.00, 120, '苹果专业平板电脑'),
(8, '三星 Galaxy S24', '智能手机', 5999.00, 90, '三星旗舰手机'),
(9, '华为 MatePad Pro', '平板电脑', 4999.00, 150, '华为旗舰平板'),
(10, '小米 Pad 6 Pro', '平板电脑', 3299.00, 180, '小米高性能平板');

-- 8. 插入测试数据 - 订单表
INSERT INTO orders (order_id, user_id, product_name, quantity, price, status, order_date) VALUES
(1001, 1, 'iPhone 15 Pro', 1, 8999.00, 'completed', '2026-03-01'),
(1002, 2, 'MacBook Pro 16', 1, 18999.00, 'shipped', '2026-03-02'),
(1003, 3, '华为 Mate 60 Pro', 2, 6999.00, 'paid', '2026-03-03'),
(1004, 4, '联想 ThinkPad X1', 1, 12999.00, 'pending', '2026-03-04'),
(1005, 5, '小米 14 Ultra', 3, 5999.00, 'completed', '2026-03-05'),
(1006, 6, '戴尔 XPS 13', 1, 9999.00, 'cancelled', '2026-03-06'),
(1007, 7, 'iPad Pro', 2, 7999.00, 'completed', '2026-03-07'),
(1008, 8, '三星 Galaxy S24', 1, 5999.00, 'shipped', '2026-03-08'),
(1009, 9, '华为 MatePad Pro', 1, 4999.00, 'paid', '2026-03-09'),
(1010, 10, '小米 Pad 6 Pro', 2, 3299.00, 'completed', '2026-03-10');

-- 9. 插入测试数据 - 用户日志表
INSERT INTO user_logs (log_id, user_id, action, ip_address, user_agent, details) VALUES
(1, 1, 'login', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '用户登录成功'),
(2, 1, 'view_product', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '查看产品详情: iPhone 15 Pro'),
(3, 2, 'login', '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', '用户登录成功'),
(4, 2, 'purchase', '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', '购买产品: MacBook Pro 16'),
(5, 3, 'login', '192.168.1.102', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '用户登录成功'),
(6, 4, 'register', '192.168.1.103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '新用户注册'),
(7, 5, 'login', '192.168.1.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '用户登录成功'),
(8, 5, 'update_profile', '192.168.1.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '更新个人信息'),
(9, 6, 'logout', '192.168.1.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '用户退出登录'),
(10, 7, 'login', '192.168.1.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '用户登录成功');

-- 10. 创建物化视图用于性能优化
CREATE MATERIALIZED VIEW IF NOT EXISTS user_order_summary
DISTRIBUTED BY HASH(user_id) BUCKETS 10
REFRESH DEFERRED MANUAL
AS
SELECT 
    u.user_id,
    u.username,
    u.city,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_spent,
    AVG(o.total_amount) as avg_order_value,
    MAX(o.order_date) as last_order_date
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username, u.city;

-- 11. 创建数据质量检查的物化视图
CREATE MATERIALIZED VIEW IF NOT EXISTS daily_sales_summary
DISTRIBUTED BY HASH(order_date) BUCKETS 10
REFRESH DEFERRED MANUAL
AS
SELECT 
    order_date,
    COUNT(order_id) as daily_orders,
    SUM(total_amount) as daily_revenue,
    AVG(total_amount) as avg_order_value,
    COUNT(DISTINCT user_id) as unique_customers,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed_orders
FROM orders
GROUP BY order_date;

-- 12. 验证数据插入成功
SELECT '用户表记录数' as table_name, COUNT(*) as record_count FROM users
UNION ALL
SELECT '产品表记录数', COUNT(*) FROM products
UNION ALL
SELECT '订单表记录数', COUNT(*) FROM orders
UNION ALL
SELECT '用户日志表记录数', COUNT(*) FROM user_logs;

-- 13. 创建查询示例视图
SELECT '=== Doris 测试数据库初始化完成 ===' as message;
SELECT '数据库: test_db' as info;
SELECT '默认密码: doris123' as info;
SELECT 'FE Web UI: http://localhost:8030' as access;
SELECT 'MySQL 连接: mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123' as mysql_client;
SELECT '当前时间: ' || NOW() as timestamp;