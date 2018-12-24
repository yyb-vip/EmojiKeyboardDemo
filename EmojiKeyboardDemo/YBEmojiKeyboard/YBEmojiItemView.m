//
//  YBEmojiImageView.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/17.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiItemView.h"
#import "YBEmojiGifImageView.h"

@interface YBEmojiItemView ()

@property (nonatomic, strong) YBEmojiGifImageView *imageView;

@property (nonatomic, strong) UILabel *titlLabel;

@end

@implementation YBEmojiItemView


- (instancetype)init {
    if (self = [super init]) {
        self.imageView = [[YBEmojiGifImageView alloc] init];
        [self addSubview:self.imageView];
        
        self.titlLabel = [[UILabel alloc] init];
        self.titlLabel.font = [UIFont systemFontOfSize:10];
        self.titlLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        self.titlLabel.adjustsFontSizeToFitWidth = YES;
        self.titlLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titlLabel];
    }
    return self;
}

- (void)setEmoji:(YBEmojiItemModel *)emoji {
    _emoji = emoji;
    self.imageView.image = emoji.image;
    self.titlLabel.text = [emoji.desc substringWithRange:NSMakeRange(2, emoji.desc.length - 3)];
    self.hidden = emoji == nil;
}

- (void)setIsShowTitle:(BOOL)isShowTitle {
    _isShowTitle = isShowTitle;
    UIViewContentMode contentMode = isShowTitle ? UIViewContentModeScaleAspectFit : UIViewContentModeCenter;
    self.imageView.contentMode = contentMode;
}

- (void)addTarget:(nullable id)target action:(SEL)action {
    for (UIGestureRecognizer *ges in self.gestureRecognizers) {
        [self removeGestureRecognizer:ges];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isShowTitle) {
        self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 15);
        self.titlLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.bounds.size.width, 15);
    }else {
        self.imageView.frame = self.bounds;
        self.titlLabel.frame = CGRectZero;
    }
}

@end
