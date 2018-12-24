//
//  YBEmojiConfig.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiConfig.h"

@implementation YBEmojiConfig

+ (YBEmojiConfig *)defaultConfig {
    return [[YBEmojiConfig alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        
        // tabbar
        BOOL isIphoneX = UIScreen.mainScreen.bounds.size.height >= 812;
        self.tabBarHeigh = isIphoneX ? 64 : 44;
        self.packageButtonWidth = 50;
        self.packageButtonSelectedColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        self.packageButtonNormalColor = UIColor.whiteColor;
        
        // sendBtn
        self.sendButtonBackgroundColor = [UIColor colorWithRed:63/255.0 green:154/255.0 blue:252/255.0 alpha:1.0];
        self.sendButtonTitleColor = UIColor.whiteColor;
        self.sendButtonWidth = 60;
        self.sendButtonTitleFont = [UIFont systemFontOfSize:15];
        self.sendButtonTitle = @"发送";
        self.sendButtonImage = nil;
        
        // pageControl
        self.pageControlHeigh = 20;
        self.pageIndicatorTintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.currentPageIndicatorTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        
        // pageView
        self.pageViewBackgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        self.largeEmojiHighlightBackgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.pageViewEdgeInsets = UIEdgeInsetsMake(15, 10, 5, 15);
        self.pageViewDeleteButtonImage = [UIImage imageNamed:@"delete-emoji"];
        self.smallEmojiLineCount = 3;
        self.smallEmojiColumnCount = 7;
        self.largeEmojiLineCount = 2;
        self.largeEmojiColumnCount = 4;
        self.pageViewMinLineSpace = 5;
        self.pageViewMinColumnSpace = 5;
        
        // emoji preview
        self.emojiPreviewImage = [UIImage imageNamed:@"emoji-preview-bg"];
        self.emojiPreviewSize = CGSizeMake(90, 136);
        self.emojiImageViewEdgeInsets = UIEdgeInsetsMake(12, 21, 0, 21);
        self.emojiPreviewDescLabel_h = 15;
        self.emojiPreviewDescLabelFont = [UIFont systemFontOfSize:13];
        self.emojiPreviewDescLabelTextColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        
        // large emoji preview
        self.largeEmojiPreviewSize = CGSizeMake(145, 180);
        self.largeEmojiImageViewEdgeInsets = UIEdgeInsetsMake(10, 10, 5, 10);
        self.largeEmojiPreviewDescLabel_h = 25;
        self.largeEmojiPreviewDescLabelFont = [UIFont systemFontOfSize:13];
        self.largeEmojiPreviewDescLabelTextColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        self.largeEmojiPreviewFillColor = [UIColor.whiteColor colorWithAlphaComponent:0.95];
        self.largeEmojiPreviewBorderColor = [UIColor.blackColor colorWithAlphaComponent:0.1];
        self.largeEmojiPreviewAngleRadius = 5;
        self.largeEmojiPreviewAngleHeigh = 8;
        self.largeEmojiPreviewAngleWidth = 14;
        self.largeEmojiPreviewLineWidth = 1.0;
        self.largeEmojiPreviewBorderMargin = 10;
    }
    return self;
}


@end

