# EmojiKeyboardDemo

## 效果展示
![效果展示.gif](https://upload-images.jianshu.io/upload_images/2887144-f253858cdc91728f.gif?imageMogr2/auto-orient/strip)
#实现的功能
> * 支持将表情转换成字符串, 同时也可以将带有表情的字符串转换成表情图片
> * 可自定义表情包, 可自定义每页表情的行数和列数, 自定义表情包需要两步

> 1: 添加表情包到EmojiPackage.bundle目录下
> 2: 按照demo中的格式修改EmojiPackageList.plist文件

> * 支持长按预览, 大表情支持gif, 删除表情
> * YBEmojiTextView实现了拷贝粘贴剪切功能, 所以如果需要支持该功能, 输入框需要继承自该类
> * 支持修改部分外观, 具体请查看YBEmojiConfig.h文件
> * 适配iPhone X

