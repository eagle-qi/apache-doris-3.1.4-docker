# 🚀 Apache Doris 3.1.4 Docker 一键部署方案正式发布！

> 作者：qyq88888  
> 发布日期：2026年3月16日  
> 标签：Docker, Apache Doris, 数据库, 数据仓库, OLAP, 开源

## 📖 前言

今天我很高兴地宣布，**Apache Doris 3.1.4 Docker 一键部署方案** 正式开源发布！这是一个完整的 Docker Compose 配置，帮助开发者和数据工程师快速搭建 Apache Doris 数据库集群，并包含开箱即用的测试数据和丰富的示例查询。

## 🎯 项目背景

Apache Doris 是一个基于 MPP 架构的高性能、实时的分析型数据库，以极速易用的特点被人们所熟知。然而，对于初学者和开发者来说，部署和配置 Doris 仍然存在一定的门槛。

为了解决这个问题，我创建了这个项目，旨在：
- **降低使用门槛** - 一键部署，无需复杂的配置
- **提供完整环境** - 包含测试数据库和示例数据
- **加速开发测试** - 为开发者提供即用型测试环境
- **促进学习交流** - 方便学习和体验 Doris 的强大功能

## ✨ 核心特性

### 🚀 一键部署
```bash
# 只需要三个命令
git clone https://github.com/eagle-qi/apache-doris-3.1.4-docker.git
cd apache-doris-3.1.4-docker
docker-compose up -d
```

### 📊 完整测试数据
项目内置了完整的测试数据库，包含：
- **users 表** - 10个测试用户信息
- **products 表** - 10个电子产品信息  
- **orders 表** - 10个测试订单记录
- **user_logs 表** - 10条用户行为日志
- **2个物化视图** - 性能优化视图

### 🔧 生产就绪特性
- ✅ 健康检查机制
- ✅ 数据持久化存储
- ✅ 日志管理系统
- ✅ 服务监控支持
- ✅ 安全访问控制

## 🛠️ 技术架构

### 🐳 Docker 架构
```
├── doris-fe (Frontend)     # 元数据管理和查询协调
├── doris-be (Backend)      # 数据存储和查询执行
├── mysql-client            # 数据库初始化
└── nginx-proxy (可选)      # Web 界面代理
```

### 📡 服务端口
- **FE Web UI**: http://localhost:8030
- **MySQL 协议**: 127.0.0.1:9030  
- **BE 监控**: http://localhost:8040

### 🔐 默认配置
- **用户名**: root
- **密码**: doris123
- **数据库**: test_db

## 🔍 使用示例

### 📈 数据分析查询
```sql
-- 1. 每日销售额统计
SELECT order_date, 
       SUM(total_amount) as daily_revenue,
       COUNT(*) as order_count
FROM test_db.orders
GROUP BY order_date
ORDER BY order_date;

-- 2. 用户行为分析  
SELECT u.username,
       u.city,
       COUNT(o.order_id) as order_count,
       SUM(o.total_amount) as total_spent
FROM test_db.users u
LEFT JOIN test_db.orders o ON u.id = o.user_id
GROUP BY u.id, u.username, u.city;

-- 3. 产品类别统计
SELECT category, 
       COUNT(*) as product_count,
       AVG(price) as avg_price
FROM test_db.products
GROUP BY category
ORDER BY product_count DESC;
```

### 🎯 性能优化示例
项目还包含了两个物化视图：
1. **user_order_summary** - 用户订单汇总视图
2. **daily_sales_summary** - 每日销售汇总视图

这些物化视图可以显著提升复杂查询的性能。

## 🏆 项目优势

### 💡 对开发者
- **快速上手** - 5分钟内即可体验 Doris 全部功能
- **学习资源** - 完整的示例和文档
- **测试环境** - 方便开发和测试数据库应用

### 🏢 对企业
- **快速部署** - 节约部署时间，提高效率
- **标准配置** - 基于最佳实践的配置
- **可扩展性** - 易于扩展为生产环境

### 🎓 对学习者
- **实践环境** - 动手操作的实践机会
- **案例丰富** - 多个实际应用场景
- **社区支持** - 活跃的开源社区

## 📁 项目结构
```
apache-doris-3.1.4-docker/
├── docker-compose-doris.yml     # Docker Compose 配置文件
├── init-scripts/               # 初始化脚本
│   ├── init.sql               # 数据库初始化脚本
│   └── init.sh                # 一键初始化脚本
├── nginx.conf                  # Nginx 代理配置
├── README.md                   # 详细文档
├── LICENSE                     # Apache 2.0 许可证
├── .gitignore                  # Git 忽略文件
└── RELEASE_NOTES.md            # 发布说明
```

## 🌐 访问方式

### 🖥️ Web 界面
访问 http://localhost:8030 即可进入 Doris 的 Web 管理界面：
- 用户名：root
- 密码：doris123

### 💻 命令行连接
```bash
# 使用 MySQL 客户端连接
mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123

# 进入 Doris 容器
docker exec -it doris-fe-3.1.4 bash
```

### 📊 监控界面
- **BE 监控**: http://localhost:8040
- **服务状态**: `docker-compose ps`
- **日志查看**: `docker-compose logs -f`

## 🔗 相关资源

### 📚 官方文档
- [Apache Doris 官网](https://doris.apache.org/)
- [Doris GitHub 仓库](https://github.com/apache/doris)
- [Doris 官方文档](https://doris.apache.org/docs/get-starting/what-is-apache-doris/)

### 🛠️ 开发工具
- [Docker 官网](https://www.docker.com/)
- [Docker Compose 文档](https://docs.docker.com/compose/)
- [MySQL 客户端](https://dev.mysql.com/doc/)

## 🤝 社区贡献

### 🐛 问题反馈
如果你在使用过程中遇到任何问题，欢迎通过以下方式反馈：
- [GitHub Issues](https://github.com/eagle-qi/apache-doris-3.1.4-docker/issues)
- 博客留言

### 💻 代码贡献
欢迎提交 Pull Request 来改进项目：
1. Fork 项目仓库
2. 创建功能分支
3. 提交代码更改
4. 创建 Pull Request

### 📣 分享推荐
如果你觉得这个项目对你有帮助，欢迎：
- 给项目 Star ⭐
- 分享给需要的朋友
- 在社交媒体上推荐

## 📈 未来规划

### 🚀 短期计划
- 添加更多测试数据集
- 优化 Docker 镜像大小
- 完善监控和告警功能

### 🌟 长期愿景
- 支持多节点集群部署
- 集成更多数据源连接器
- 提供 Web 管理界面

## 🙏 致谢

感谢以下开源项目的贡献：
- **Apache Doris 社区** - 提供优秀的数据仓库解决方案
- **Docker 社区** - 革命性的容器化技术
- **所有测试用户** - 提供宝贵的反馈和建议

特别感谢我的读者们一直以来的支持！

## 📞 联系方式

- **GitHub**: [@eagle-qi](https://github.com/eagle-qi)
- **邮箱**: oraclehpux@gmail.com
- **博客**: blog.csn.net/qyq88888
- **项目地址**: https://github.com/eagle-qi/apache-doris-3.1.4-docker

## 💬 结语

Apache Doris 是一个非常优秀的实时分析数据库，而 Docker 部署则让它变得更加易用。我希望这个项目能够帮助更多的人快速上手 Doris，体验现代数据仓库的强大功能。

无论你是开发者、数据工程师、还是数据分析师，我相信这个项目都能为你提供价值。如果你有任何问题或建议，欢迎随时联系我。

**让我们一起探索数据的世界！** 🚀

---

**📢 最后提醒**: 
- 项目已开源，采用 Apache 2.0 许可证
- 欢迎 Star、Fork 和贡献代码
- 定期更新，持续改进

**#Docker #ApacheDoris #数据库 #数据仓库 #OLAP #开源 #DevOps**