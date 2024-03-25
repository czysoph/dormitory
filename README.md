# 宿舍管理系统

#### 介绍
该项目为宿舍管理系统。该软件的开发意图是为了快速、高效地对学生宿舍进行管理，并处理学生宿舍相关事务。该软件的应用目标是为了让学生更加方便自由地申请退换寝室，也让后勤管理部门能及时处理申请要求。该软件的作用范围是住校学生，宿舍管理员以及后勤管理人员。

该宿舍管理系统是教务系统组成的一部分，宿舍管理系统中的学生信息由教务系统提供，而宿舍管理系统为教务系统提供学生的住宿信息。

#### 软件架构
![本地路径](doc/Data flow diagram.png "相对路径演示")

#### **数据流图**


#### 环境与安装

参考：Installation.md

#### 软件功能

本系统设计三种角色，分别为学生、宿舍管理员、后勤管理人员

系统分为6个模块：
- 登录管理模块
  - 用户登录
  - 忘记密码
  - 修改密码
- 用户管理模块
  - 后勤管理人员
    - 新增用户信息
    - 修改用户信息
    - 删除用户信息
    - 查询用户信息
- 楼宇管理模块
  - 后勤管理人员
    - 新增楼宇信息
    - 修改楼宇信息
    - 删除楼宇信息
    - 查询楼宇信息
    - 房间管理模块
      - 查看床位信息
- 通知管理模块
  - 宿舍管理员
    - 发布通知
    - 删除通知
  - 学生
    - 查看通知
- 维修管理模块
  - 学生
    - 申请维修
    - 查看维修列表
  - 宿舍管理员
    - 审核申请
    - 修改申请状态
- 宿舍分配模块
  - 申请退/换宿舍
    - 学生
      - 申请退/换宿舍
      - 查看申请列表
    - 后勤管理人员
      - 审核申请
      - 修改申请状态
  - 自选宿舍
    - 学生
      - 申请分配宿舍
    - 后勤管理人员
      - 审核申请
      - 修改申请状态
