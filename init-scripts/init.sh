#!/bin/bash

# Doris 3.1.4 初始化脚本
# 默认密码: doris123

set -e

echo "========================================="
echo "Apache Doris 3.1.4 初始化脚本"
echo "========================================="

# 等待 Doris FE 服务启动
echo "等待 Doris Frontend 服务启动..."
while ! mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123 -e "SELECT 1" >/dev/null 2>&1; do
    echo "等待 Doris FE 连接... (10秒后重试)"
    sleep 10
done

echo "Doris FE 连接成功！"

# 等待 Doris BE 服务启动
echo "等待 Doris Backend 服务启动..."
while ! curl -s http://127.0.0.1:8040/api/health | grep -q '"status":"OK"'; do
    echo "等待 Doris BE 健康检查... (10秒后重试)"
    sleep 10
done

echo "Doris BE 连接成功！"

# 执行初始化 SQL 脚本
echo "开始初始化数据库和测试数据..."
mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123 < ./init-scripts/init.sql

echo "========================================="
echo "数据库初始化完成！"
echo "========================================="

# 显示连接信息
cat << EOF

🎉 Apache Doris 3.1.4 安装完成！

📊 数据库信息：
- 数据库名称: test_db
- 默认用户名: root
- 默认密码: doris123
- FE Web UI: http://localhost:8030
- MySQL 端口: 9030

🔌 连接方式：
1. MySQL客户端连接：
   mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123

2. 进入容器内部：
   docker exec -it doris-fe-3.1.4 bash

3. 查看容器日志：
   docker logs -f doris-fe-3.1.4
   docker logs -f doris-be-3.1.4

📁 创建的测试表：
- users (用户表) - 10条记录
- products (产品表) - 10条记录  
- orders (订单表) - 10条记录
- user_logs (用户日志表) - 10条记录

🔧 管理命令：
- 启动服务：docker-compose -f docker-compose-doris.yml up -d
- 停止服务：docker-compose -f docker-compose-doris.yml down
- 查看状态：docker-compose -f docker-compose-doris.yml ps
- 查看日志：docker-compose -f docker-compose-doris.yml logs -f

💡 示例查询：
SELECT * FROM test_db.users LIMIT 5;
SELECT COUNT(*) as total_users FROM test_db.users;
SELECT city, COUNT(*) as user_count FROM test_db.users GROUP BY city;
SELECT order_date, SUM(total_amount) as daily_revenue FROM test_db.orders GROUP BY order_date;

EOF

# 执行一个简单的测试查询
echo "正在执行测试查询..."
mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123 -e "
USE test_db;
SELECT '✅ 测试查询成功！' as message;
SELECT '总用户数:' as description, COUNT(*) as count FROM users;
SELECT '总订单数:' as description, COUNT(*) as count FROM orders;
SELECT '总产品数:' as description, COUNT(*) as count FROM products;
SELECT '订单状态分布:' as description, status, COUNT(*) as count FROM orders GROUP BY status ORDER BY count DESC;
"

echo ""
echo "🚀 开始体验 Apache Doris 3.1.4 吧！"