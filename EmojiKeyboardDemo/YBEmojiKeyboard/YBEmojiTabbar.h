//
//  YBEmojiTabbar.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiConfig.h"
#import "YBEmojiDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@class YBEmojiTabbar;
@protocol YBEmojiTabbarDelegate<NSObject>

// 点击表情包
- (void)tabbar:(YBEmojiTabbar *)tabbar clickedEmojiPackageWith:(NSInteger)index;

// 点击发送按钮
- (void)tabbar:(YBEmojiTabbar *)tabbar clickedSendAction:(UIButton *)button;

@end

@interface YBEmojiTabbar : UIView

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, weak) id<YBEmojiTabbarDelegate>delegate;

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config;

@end

NS_ASSUME_NONNULL_END
