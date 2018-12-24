//
//  YBEmojiPageView.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiConfig.h"
#import "YBEmojiDataManager.h"
#import "YBEmojiItemView.h"

NS_ASSUME_NONNULL_BEGIN

@class YBEmojiPageView;
@protocol YBEmojiPageViewDelegate<NSObject>

// 点击表情
- (void)pageView:(YBEmojiPageView *)pageView clickedEmojiWith:(YBEmojiItemModel *)emoji;

// 点击大表情
- (void)pageView:(YBEmojiPageView *)pageView clickedBigEmojiWith:(YBEmojiItemModel *)emoji;

// 点击删除
- (void)pageView:(YBEmojiPageView *)pageView clickedDeleteWith:(UIButton *)button;

@end

@interface YBEmojiPageView : UIView

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config;

- (void)configEmojisButtonWith:(YBEmojiGroupModel *)groupModel pageIndex:(NSInteger)pageIndex;

@property (nonatomic, weak) id<YBEmojiPageViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
