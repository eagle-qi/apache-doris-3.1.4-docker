# 🚀 Apache Doris 3.1.4 Docker 一键部署方案

[![Apache License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-✓-2496ED.svg)](https://www.docker.com/)
[![Doris 3.1.4](https://img.shields.io/badge/Apache%20Doris-3.1.4-green.svg)](https://doris.apache.org/)

一个完整的 Apache Doris 3.1.4 单机 Docker 部署方案，包含开箱即用的测试数据库和丰富的示例数据。

## 📦 项目特色

- ✅ **一键部署** - 单命令启动完整 Doris 集群
- ✅ **生产就绪** - 健康检查、数据持久化、日志管理
- ✅ **即用型测试数据** - 4个表，40条测试记录，2个物化视图
- ✅ **详细文档** - 完整的部署指南和查询示例
- ✅ **多环境支持** - Docker Compose，易于扩展

## 🚀 快速开始

### 环境要求
- Docker Engine 20.10+
- Docker Compose 2.0+
- 至少 8GB 可用内存
- 至少 10GB 可用磁盘空间

### 启动 Doris 集群
```bash
# 1. 克隆项目
git clone https://github.com/qyq88888/apache-doris-3.1.4-docker.git
cd apache-doris-3.1.4-docker

# 2. 启动服务
docker-compose up -d

# 3. 查看状态
docker-compose ps
```

### 初始化数据库
```bash
# 自动初始化（推荐）
chmod +x init-scripts/init.sh
./init-scripts/init.sh

# 或手动执行
docker exec -it doris-fe-3.1.4 bash
mysql -uroot -pdoris123
```

## 📊 测试数据库

### 数据库结构
```
test_db/
├── users (用户表，10条记录)
├── products (产品表，10条记录)
├── orders (订单表，10条记录)
└── user_logs (用户日志表，10条记录)
```

### 测试数据示例
- **用户表**: 10个测试用户，包含姓名、年龄、城市、薪资
- **产品表**: 10个电子产品（iPhone、MacBook、华为、小米等）
- **订单表**: 10个测试订单，多种状态
- **用户日志**: 10条用户行为日志（登录、购买、查看等）

## 🔌 连接信息

| 服务 | 端口 | 用途 | 默认密码 |
|------|------|------|----------|
| **FE Web UI** | 8030 | 管理界面 | `doris123` |
| **MySQL 连接** | 9030 | SQL 查询 | `doris123` |
| **BE HTTP** | 8040 | 后端监控 | - |

### 连接方式
```bash
# MySQL 客户端连接
mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123

# Web UI 访问
http://localhost:8030 (用户名: root, 密码: doris123)
```

## 🔍 示例查询

### 基础查询
```sql
-- 查看所有用户
SELECT * FROM test_db.users;

-- 统计用户数
SELECT COUNT(*) as total_users FROM test_db.users;

-- 按城市统计用户
SELECT city, COUNT(*) as user_count 
FROM test_db.users 
GROUP BY city 
ORDER BY user_count DESC;
```

### 订单分析
```sql
-- 每日销售额
SELECT order_date, 
       SUM(total_amount) as daily_revenue,
       COUNT(*) as order_count
FROM test_db.orders
GROUP BY order_date
ORDER BY order_date;
```

### 产品分析
```sql
-- 产品按类别统计
SELECT category, 
       COUNT(*) as product_count,
       AVG(price) as avg_price
FROM test_db.products
GROUP BY category;
```

## 🛠️ 管理命令

### 启动和停止
```bash
# 启动服务
docker-compose up -d

# 停止服务
docker-compose down

# 停止并删除数据
docker-compose down -v

# 查看日志
docker-compose logs -f
```

### 监控和维护
```bash
# 查看容器状态
docker ps | grep doris

# 查看资源使用
docker stats doris-fe-3.1.4 doris-be-3.1.4

# 进入容器
docker exec -it doris-fe-3.1.4 bash
```

## 🔒 安全配置

### 修改默认密码
```sql
-- 连接到 Doris
mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123

-- 修改 root 密码
SET PASSWORD FOR 'root' = PASSWORD('your_new_password');
```

### 创建新用户
```sql
-- 创建只读用户
CREATE USER 'reader'@'%' IDENTIFIED BY 'reader_password';
GRANT SELECT ON test_db.* TO 'reader'@'%';
```

## 📁 文件结构
```
.
├── docker-compose.yml          # Docker Compose 配置文件
├── init-scripts/
│   ├── init.sql               # 数据库初始化脚本
│   └── init.sh                # 初始化执行脚本
├── nginx.conf                  # Nginx 代理配置（可选）
├── .gitignore                  # Git 忽略文件
├── LICENSE                     # Apache 2.0 许可证
└── README.md                   # 项目说明文档
```

## 🐳 Docker 镜像信息

- **FE 镜像**: `apache/doris.fe-ubuntu:3.1.4`
- **BE 镜像**: `apache/doris.be-ubuntu:3.1.4`
- **MySQL 客户端**: `mysql:8.0` (用于初始化)
- **Nginx**: `nginx:alpine` (可选代理)

## ⚠️ 故障排除

### 常见问题
1. **端口占用错误**
   ```bash
   netstat -tlnp | grep -E '8030|9030|8040|9060'
   ```

2. **内存不足**
   ```bash
   # 检查 Docker 资源限制
   docker stats
   ```

3. **连接失败**
   ```bash
   # 检查服务状态
   docker-compose ps
   curl http://localhost:8030/api/health
   ```

### 日志查看
```bash
# FE 日志
docker logs -f doris-fe-3.1.4

# BE 日志  
docker logs -f doris-be-3.1.4
```

## 📈 性能调优

### 调整配置
在 `docker-compose.yml` 中增加内存限制：
```yaml
deploy:
  resources:
    limits:
      memory: 8G
```

### 监控建议
1. 定期检查磁盘使用
2. 监控内存使用情况
3. 分析慢查询日志

## 🔗 相关资源

- [Apache Doris 官网](https://doris.apache.org/)
- [Doris GitHub 仓库](https://github.com/apache/doris)
- [Doris 官方文档](https://doris.apache.org/docs/get-starting/what-is-apache-doris/)
- [Doris 开发者社区](https://github.com/apache/doris/discussions)

## 📄 许可证

本项目基于 [Apache License 2.0](LICENSE) 许可证开源。

## ✨ 贡献

欢迎提交 Issue 和 Pull Request！

## 📞 联系

如有问题，请通过以下方式联系：
- GitHub Issues: [qyq88888/apache-doris-3.1.4-docker](https://github.com/qyq88888/apache-doris-3.1.4-docker/issues)

---

**💡 提示**: 首次启动可能需要 2-3 分钟完成初始化，请耐心等待所有服务健康检查通过。