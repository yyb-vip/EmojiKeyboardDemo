//
//  YBEmojiTabbar.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiTabbar.h"

@interface YBEmojiTabbar ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YBEmojiConfig *config;

@property (nonatomic, strong) NSMutableArray<UIButton *> *items;

@property (nonatomic, strong) NSBundle *emojiBundle;

@end

@implementation YBEmojiTabbar

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.config = config;
        // 发送按钮
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sendButton.backgroundColor = config.sendButtonBackgroundColor;
        [self.sendButton setTitleColor:config.sendButtonTitleColor forState:UIControlStateNormal];
        [self.sendButton setTitleColor:config.sendButtonTitleColor forState:UIControlStateNormal];
        self.sendButton.titleLabel.font = config.sendButtonTitleFont;
        [self.sendButton setTitle:self.config.sendButtonTitle forState:UIControlStateNormal];
        [self.sendButton setImage:self.config.sendButtonImage forState:UIControlStateNormal];
        [self.sendButton addTarget:self action:@selector(clickedSendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sendButton];
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.alwaysBounceHorizontal = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];

        self.items = [NSMutableArray array];
        UIView *lastView = nil;
        CGFloat h = UIScreen.mainScreen.bounds.size.height >= 812 ? self.config.tabBarHeigh - 20 : self.config.tabBarHeigh;
        NSArray<YBEmojiGroupModel *> *groupArray = YBEmojiDataManager.manager.emojiPackages;
        for (int i = 0; i < groupArray.count; i ++) {
            CGFloat x = lastView == nil ? 0 : CGRectGetMaxX(lastView.frame) + 0.5;
            NSString *folderPath = [self.emojiBundle pathForResource:groupArray[i].folderName ofType:nil];
            NSString *coverPath = [folderPath stringByAppendingPathComponent:groupArray[i].cover_pic];
            UIImage *coverImage = [UIImage imageWithContentsOfFile:coverPath];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:coverImage forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            UIColor *bgColor = i == 0 ? self.config.packageButtonSelectedColor : self.config.packageButtonNormalColor;
            [button setBackgroundColor:bgColor];
            button.frame = CGRectMake(x, 0, self.config.packageButtonWidth, h);
            [button addTarget:self action:@selector(clickedTabbarItemAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 1000 + i;
            [self.scrollView addSubview:button];
            [self.items addObject:button];
            lastView = button;
            if (groupArray.count > 0 && i != groupArray.count-1) {
                UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), 10, 0.5, h-20)];
                separatorView.backgroundColor = self.config.packageButtonSelectedColor;
                [self.scrollView addSubview:separatorView];
            }
        }
    }
    return self;
}

// 点击表情包
- (void)clickedTabbarItemAction:(UIButton *)sender {
    sender.backgroundColor = self.config.packageButtonSelectedColor;
    for (UIButton *button in self.items) {
        if (sender != button) {
            button.backgroundColor = self.config.packageButtonNormalColor;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(tabbar:clickedEmojiPackageWith:)]) {
        [_delegate tabbar:self clickedEmojiPackageWith:sender.tag-1000];
    }
}

// 点击发送
- (void)clickedSendButtonAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(tabbar:clickedSendAction:)]) {
        [_delegate tabbar:self clickedSendAction:sender];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat h = UIScreen.mainScreen.bounds.size.height >= 812 ? self.config.tabBarHeigh - 20 : self.config.tabBarHeigh;
    self.sendButton.frame = CGRectMake(self.bounds.size.width-self.config.sendButtonWidth, 0, self.config.sendButtonWidth, h);
    self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width-self.config.sendButtonWidth, h);
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.items.lastObject.frame), h);
}

- (NSBundle *)emojiBundle {
    if (!_emojiBundle) {
        // 表情包路径
        NSString *emojiBundlePath = [[NSBundle mainBundle] pathForResource:@"EmojiPackage" ofType:@"bundle"];
        _emojiBundle = [NSBundle bundleWithPath:emojiBundlePath];
    }
    return _emojiBundle;
}


@end
