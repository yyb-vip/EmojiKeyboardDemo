//
//  YBEmojiContentView.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiConfig.h"
#import "YBEmojiPageView.h"

NS_ASSUME_NONNULL_BEGIN

@class YBEmojiContentView;
@protocol YBEmojiContentViewDelegate<NSObject>

// 滚动pageView, 用于外部更新pageControl
- (void)contentView:(YBEmojiContentView *)contentView didScrollViewToIndex:(NSInteger)index;

@end

@interface YBEmojiContentView : UIView

@property (nonatomic, weak) id<YBEmojiContentViewDelegate>delegate;

@property (nonatomic, strong) YBEmojiPageView *leftPageView;
@property (nonatomic, strong) YBEmojiPageView *centerPageView;
@property (nonatomic, strong) YBEmojiPageView *rightPageView;

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config;

- (void)setEmojiPackageWith:(YBEmojiGroupModel *)groupModel totalPage:(NSInteger)totalPage;

@end

NS_ASSUME_NONNULL_END
