# 环境

- 操作系统：Windows Vista/7/8/8.1/10 x86 and x64

- 应用服务器：Tomcat8.5以上

- JDK：JDK8.0以上

- 数据库服务器：Mysql8.5或以上
- 集成开发工具：IntelliJ IDEA Ultimate 2020及以上

# 初始化

- 安装IDEA运行工具、MySQL数据库、Navicat数据库管理工具以及Tomcat应用服务器；

- 打开Navicat数据库管理工具，新建MySQL的localhost连接，新建名为dormitory的数据库，之后运行dormitory.sql的SQL文件，初始化数据库数据。

- 打开IDEA，打开文件中dormitory\code\dormitory的后端文件夹，和dormitory\web\dormitoryfront的前端文件夹，之后点击后端文件中IDEA的运行按钮即可运行。

# 配置文件

配置文件目录：**code/dormitory/src/main/resources/application.yml**

## 数据库配置

```yaml
datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:port/dormitory?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai&useSSL=false
    username: user
    password: password
```

- port：端口号
- user：数据库用户名
- password：数据库密码

## 邮箱配置

```yaml
mail:
    host: smtp.qq.com
    port: port
    username: user
    password: password
    protocol: smtp
    default-encoding: UTF-8
    properties:
      mail.smtp.auth: true
      mail.smtp.starttls.enable: true
      mail.smtp.starttls.required: true
      mail.smtp.socketFactory.port: port
      mail.smtp.socketFactory.class: javax.net.ssl.SSLSocketFactory
      mail.smtp.socketFactory.fallback: false
```

- port：端口号
- user：用户名
- password：密码



