//
//  InputBar.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/20.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "InputBar.h"

@implementation InputBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
        self.emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.emojiBtn setImage:[UIImage imageNamed:@"btn_chat_input_emoji"] forState:UIControlStateNormal];
        [self addSubview:self.emojiBtn];
        
        self.sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [self addSubview:self.sendBtn];
        
        self.textView = [[YBEmojiTextView alloc] init];
        self.textView.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor;
        self.textView.layer.cornerRadius = 5;
        self.textView.layer.borderWidth = 1.0;
        self.textView.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.emojiBtn.frame = CGRectMake(10, self.bounds.size.height - 45, 35, 35);
        self.sendBtn.frame = CGRectMake(self.bounds.size.width - 50, self.bounds.size.height - 45, 50, 35);
        self.textView.frame = CGRectMake(55, 10, self.bounds.size.width - CGRectGetWidth(self.emojiBtn.frame) - CGRectGetWidth(self.sendBtn.frame) - 20, self.bounds.size.height - 20);
    }];
    
}


@end
