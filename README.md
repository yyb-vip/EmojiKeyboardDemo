# EmojiKeyboardDemo

<div align=center><img src="https://upload-images.jianshu.io/upload_images/2887144-f253858cdc91728f.gif?imageMogr2/auto-orient/strip"/></div>


### 实现的功能

> * 支持将表情转换成字符串, 同时也可以将带有表情的字符串转换成表情图片
> * 可自定义表情包, 可自定义每页表情的行数和列数, 自定义表情包需要两步
1: 添加表情包到EmojiPackage.bundle目录下
2: 按照demo中的格式修改EmojiPackageList.plist文件
> * 支持长按预览, 大表情支持gif, 删除表情
> * YBEmojiTextView实现了拷贝粘贴剪切功能, 所以如果需要支持该功能, 输入框需要继承自该类
> * 支持修改部分外观, 具体请查看YBEmojiConfig.h文件
> * 适配iPhone X

## 使用方法
初始化表情键盘
````
self.emojiKeyboard = [[YBEmojiInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 230)];
self.emojiKeyboard.delegate = self;
````
切换键盘
````
- (void)clickedEmoji:(UIButton *)sender {
    if (self.inputBar.textView.inputView == nil) {
        self.inputBar.textView.inputView = self.emojiKeyboard;
        [sender setImage:[UIImage imageNamed:@"btn_chat_input_keyborad"] forState:UIControlStateNormal];
    }else {
        self.inputBar.textView.inputView = nil;
        [sender setImage:[UIImage imageNamed:@"btn_chat_input_emoji"] forState:UIControlStateNormal];
    }
    [self.inputBar.textView reloadInputViews];
    [self.inputBar.textView becomeFirstResponder];
}
````
实现代理方法, 下边这两个方法代码基本上都是一样的
````
// 点击表情
- (void)inputView:(YBEmojiInputView *)inputView clickedEmojiWith:(YBEmojiItemModel *)emoji {
    NSRange selectedRange = self.inputBar.textView.selectedRange;
    NSAttributedString *emojiAttributedString = [[NSAttributedString alloc] initWithString:emoji.desc];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputBar.textView.attributedText];
    [attributedText replaceCharactersInRange:selectedRange withAttributedString:emojiAttributedString];
    self.inputBar.textView.attributedText = attributedText;
    self.inputBar.textView.selectedRange = NSMakeRange(selectedRange.location + emojiAttributedString.length, 0);
    [self textViewDidChange:self.inputBar.textView];
}

// 点击删除
- (void)inputView:(YBEmojiInputView *)inputView clickedDeleteWith:(UIButton *)button {
    NSRange selectedRange = self.inputBar.textView.selectedRange;
    if (selectedRange.location == 0 && selectedRange.length == 0) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputBar.textView.attributedText];
    if (selectedRange.length > 0) {
        [attributedText deleteCharactersInRange:selectedRange];
        self.inputBar.textView.attributedText = attributedText;
        self.inputBar.textView.selectedRange = NSMakeRange(selectedRange.location, 0);
    } else {
        NSUInteger deleteCharactersCount = 1;
        // 下面这段正则匹配是用来匹配文本中的所有系统自带的 emoji 表情，以确认删除按钮将要删除的是否是 emoji。这个正则匹配可以匹配绝大部分的 emoji，得到该 emoji 的正确的 length 值；不过会将某些 combined emoji（如 👨‍👩‍👧‍👦 👨‍👩‍👧‍👦 👨‍👨‍👧‍👧），这种几个 emoji 拼在一起的 combined emoji 则会被匹配成几个个体，删除时会把 combine emoji 拆成个体。瑕不掩瑜，大部分情况下表现正确，至少也不会出现删除 emoji 时崩溃的问题了。
        NSString *emojiPattern1 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900-\\U0001F9FF]";
        NSString *emojiPattern2 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF]\\uFE0F";
        NSString *emojiPattern3 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF][\\U0001F3FB-\\U0001F3FF]";
        NSString *emojiPattern4 = @"[\\rU0001F1E6-\\U0001F1FF][\\U0001F1E6-\\U0001F1FF]";
        NSString *pattern = [[NSString alloc] initWithFormat:@"%@|%@|%@|%@", emojiPattern4, emojiPattern3, emojiPattern2, emojiPattern1];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:kNilOptions error:NULL];
        NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:attributedText.string options:kNilOptions range:NSMakeRange(0, attributedText.string.length)];
        for (NSTextCheckingResult *match in matches) {
            if (match.range.location + match.range.length == selectedRange.location) {
            deleteCharactersCount = match.range.length;
            break;
            }
        }
        [attributedText deleteCharactersInRange:NSMakeRange(selectedRange.location - deleteCharactersCount, deleteCharactersCount)];
        self.inputBar.textView.attributedText = attributedText;
        self.inputBar.textView.selectedRange = NSMakeRange(selectedRange.location - deleteCharactersCount, 0);
    }
    [self textViewDidChange:self.inputBar.textView];
}

// 点击大表情
- (void)inputView:(YBEmojiInputView *)inputView clickedBigEmojiWith:(YBEmojiItemModel *)emoji {

}

// 点击发送
- (void)inputView:(YBEmojiInputView *)inputView clickedSendWith:(UIButton *)button {

}
````
#### 简书地址 https://www.jianshu.com/p/b6494074d4df
