function isShowHeader() {
return 1;
}

function getFileName() {
return "/Users/huangchao/workspace/go/ulb_api_go/README.md";
}

function getFileType() {
return "markdown";
}

function getLastModified() {
return "2019/11/13 (Wed) 16:23:56";
}

function getContent() {
return "### ulb_api_go\n\n#### 部署\n- 支持机房\n    - 公有云（除北京一、浪潮北京一）均支持\n    - 专有云，理论支持。但是由于专有云原online_api版本落后太多，还有好多后续工作需要处理，需要处理的工作\n        - 1.online_api打平至不再维护的最高版本（杜绝增量脏数据）\n        - 2.脏数据清理（各种长短Id问题）\n        - 3.需要专有云的灰度\n        - 4.mysql 表的变更\n    - 新增专有云，期望直接部署新版API\n    - 部署列表：https://ushare.ucloudadmin.com/pages/viewpage.action?pageId=14747613\n\n#### 配置文件维护\n- SRE项目下：git@git.ucloudadmin.com:unetsre/resource_center.git\n- 配置变更步骤：\n	- docker/templates/confinfo 文件会引入不同的配置模板，另外还维护了不同版本的服务监听端口\n	- 如果配置模板的变更需更改 docker/templates/ulb_api.json.{{version}}.template 模板\n	- 同时更新配置文件\n\n#### 灰度策略\n- ulb_api_gray 内部测试灰度\n- ulb_api_master 灰度外部用户\n- ulb_api_stable 全量发布\n- 灰度控制：\n    - 1. apigw提供的灰度系统控制用户级别灰度\n    - 2. 通过proxy的配置控制region && action级别的灰度\n    - 3. proxy项目地址：git@git.ucloudadmin.com:ulb/ulb_api_proxy.git\n\n#### 监控\n- 监控页面：http://grafana.iaas.ucloudadmin.com/d/6Gml4zIWk/ulb-api?orgId=1\n- prometheus: http://172.18.185.57/:9090\n- prometheus配置：\n    - root@172.18.185.57:/root/prometheus\n    - vim prometheus.yml 配置文件以文件方式添加（文件目录conf.d下以地域为维度添加）\n    - 修改配置文件，保证每个机器都打上labels\n    - 修改json文件会动态加载，修改yml文件需重载\n    - 重载命令：curl -X POST http://172.18.185.57:9090/-/reload\n\n#### Dockerfile 维护\n- 维护项目下docker目录文件，需要修改的情况：\n    - 1. 运行环境的变更\n    - 2. 配置文件模板的变更\n\n#### 发布管理\n- 通过运维平台发布：https://devops.ucloudadmin.com/storage-ops/\n- 通过作业平台发布：https://devops.ucloudadmin.com/unet-jobs/（暂未配置）\n\n#### 注意事项\n- ULB API 的 Error code 段\n    - 63000—63300\n    - 之前已经在网络那边用到的 error code 还继续用，只是新加的 error code 需要再这个段下\n- 不要在代码里执行系统命令，运行环境的镜像是alpine大部分命令都是busybox的，和linux命令会有差异。如果必要需apk add安装相关依赖";
}
