## RobotFramework框架
>1.RF介绍
- RobotFramework是一个基于Python语言的，可扩展的关键字驱动的自动化的测试框架，用于验收驱动的测试(ATDD)，除了自带的库之外有很多的扩展库 ，这些库我们可以在RobotFramework官网里找到
- 链接为：http://robotframework.org/#Liraries

>2.为什么使用RF
- 表格的方式创建测试用例
- 创建high-level的可重用的关键字
- 测试用例主题由关键字组成(测试库,资源文件,用例所在文件的关键字)
- 各平台通用，包括Windows、iOS、Linux
- 可以使用Python或Java语言实现自定义库
- 提供丰富的扩展库，比如网页测试的Selenium、Java、GUI、Ssh...

>3.RF安装
- 支持selenium自自动化的RF扩展库
- pip install robotframework-seleniumlibrary


>4.RF插件安装

安装三个文件：分别为IntelliBot @SeleniumLibrary Patched
、Run Robot framework file、Run Robot Framework TestCase

操作步骤
- file-->settings-->Plugins-->Browse Repositories-->搜索robot
- IntelliBot@SeleniumLibrary Patched在Pycharm插件中增加了智能编辑功能，以支持Robot Framework
- Run Robot Framework file 插件支持RobotFramework文件运行
- Run RobotFramework TestCase 插件支持RobotFramework运行用例

>5.Pycharm中配置用例操作
- 在Pycharm中配置单个执行用例和用例套件操作文档链接
- http://www.jianshu.com/p/5a97d28a596d

>6.Ride
- 不推荐使用

>7.标准库和扩展库
- 标准库：只要安装好RobotFramework后就可以使用的库
- 扩展库：需要再导入相关的库Library