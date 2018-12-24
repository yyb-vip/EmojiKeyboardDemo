//
//  InputBar.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/20.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiKeyboard/YBEmojiTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputBar : UIView

@property (nonatomic, strong) YBEmojiTextView *textView;

@property (nonatomic, strong) UIButton *emojiBtn;

@property (nonatomic, strong) UIButton *sendBtn;

@end

NS_ASSUME_NONNULL_END
