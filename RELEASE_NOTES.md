# 🎉 Apache Doris 3.1.4 Docker 部署项目 v1.0.0

## 🚀 项目概述

**Apache Doris 3.1.4 Docker 一键部署方案** 是一个完整的 Docker Compose 配置，用于快速部署 Apache Doris 3.1.4 数据库集群，并包含开箱即用的测试数据和丰富的示例查询。

## 📦 版本亮点

### ✅ 核心特性
- **一键部署** - 单命令启动完整的 Doris 集群
- **生产就绪** - 包含健康检查、数据持久化、日志管理
- **即用型测试数据** - 4个表，40条测试记录，2个物化视图
- **详细文档** - 完整的部署指南和查询示例
- **开源许可证** - Apache 2.0 License

### 🛠️ 技术栈
- **Docker Engine**: 20.10+
- **Docker Compose**: 2.0+
- **Apache Doris**: 3.1.4 (稳定版)
- **MySQL 客户端**: 8.0
- **Nginx**: alpine (可选代理)

## 📊 测试数据库结构

### 🗃️ 数据库表
1. **users** - 用户表 (10条记录)
   - 姓名、邮箱、年龄、城市、薪资等信息
   
2. **products** - 产品表 (10条记录)
   - iPhone、MacBook、华为、小米等电子产品
   
3. **orders** - 订单表 (10条记录)
   - 多种状态：pending、paid、shipped、completed、cancelled
   
4. **user_logs** - 用户日志表 (10条记录)
   - 登录、查看产品、购买等操作记录

### 📈 物化视图
1. **user_order_summary** - 用户订单汇总
   - 优化用户行为分析查询性能
   
2. **daily_sales_summary** - 每日销售汇总
   - 提供实时销售数据统计

## 🚀 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/eagle-qi/apache-doris-3.1.4-docker.git
cd apache-doris-3.1.4-docker
```

### 2. 启动服务
```bash
docker-compose up -d
```

### 3. 初始化数据库
```bash
chmod +x init-scripts/init.sh
./init-scripts/init.sh
```

### 4. 连接使用
```bash
# MySQL 客户端连接
mysql -h 127.0.0.1 -P 9030 -uroot -pdoris123

# Web UI 访问
http://localhost:8030 (用户名: root, 密码: doris123)
```

## 🔗 访问地址

### 🌐 Web 界面
- **Doris FE Web UI**: http://localhost:8030
- **Doris BE 监控**: http://localhost:8040

### 📡 服务端口
| 服务 | 端口 | 用途 | 默认密码 |
|------|------|------|----------|
| FE Web UI | 8030 | 管理界面 | `doris123` |
| MySQL 协议 | 9030 | SQL 查询 | `doris123` |
| BE HTTP | 8040 | 后端监控 | - |

## 📁 文件结构
```
.
├── docker-compose-doris.yml          # Docker Compose 配置文件
├── init-scripts/                     # 初始化脚本
│   ├── init.sql                      # 数据库初始化脚本
│   └── init.sh                       # 一键初始化脚本
├── .github/                          # GitHub 配置
│   └── ISSUE_TEMPLATE/               # Issue 模板
├── nginx.conf                        # Nginx 代理配置
├── README.md                         # 详细文档
├── LICENSE                           # Apache 2.0 许可证
└── .gitignore                        # Git 忽略文件
```

## 🎯 使用场景

### 🧪 开发测试
- 快速搭建 Doris 测试环境
- 学习和体验 Doris 功能
- 开发和测试数据库应用

### 📊 数据分析
- 实时数据分析演示
- OLAP 查询性能测试
- 数据仓库功能验证

### 🎓 教学培训
- 数据库课程实验环境
- 数据仓库技术培训
- 大数据分析学习

## 🔧 系统要求

### 📋 最低配置
- **内存**: 8GB+
- **磁盘**: 10GB+
- **CPU**: 2 核心+
- **操作系统**: Linux, macOS, Windows (WSL2)

### 🐳 软件要求
- **Docker**: 20.10+
- **Docker Compose**: 2.0+
- **Git**: 2.30+

## 📚 文档资源

### 📖 快速指南
- [安装部署指南](README.md#快速开始)
- [测试数据库说明](README.md#测试数据库)
- [查询示例大全](README.md#示例查询)

### 🔗 相关链接
- **GitHub 仓库**: https://github.com/eagle-qi/apache-doris-3.1.4-docker
- **Doris 官网**: https://doris.apache.org/
- **Docker 文档**: https://docs.docker.com/

## 🤝 贡献指南

### 🐛 报告问题
请使用 GitHub Issues 报告 bug 或提出功能请求：
- [Bug 报告模板](.github/ISSUE_TEMPLATE/bug_report.md)
- [功能请求模板](.github/ISSUE_TEMPLATE/feature_request.md)

### 💻 开发贡献
1. Fork 项目仓库
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 📄 许可证

本项目基于 [Apache License 2.0](LICENSE) 许可证开源。

## 🙏 致谢

- **Apache Doris 社区** - 优秀的开源数据仓库项目
- **Docker 社区** - 容器化技术的革命者
- **所有贡献者** - 感谢你们的支持和贡献

## 📞 联系信息

- **GitHub**: [@eagle-qi](https://github.com/eagle-qi)
- **邮箱**: oraclehpux@gmail.com
- **博客**: blog.csn.net/qyq88888

---

**🎯 目标**: 为开发者提供开箱即用的 Apache Doris 体验  
**🚀 愿景**: 简化数据仓库部署，加速数据分析应用开发  
**❤️ 承诺**: 持续维护和更新，服务开源社区