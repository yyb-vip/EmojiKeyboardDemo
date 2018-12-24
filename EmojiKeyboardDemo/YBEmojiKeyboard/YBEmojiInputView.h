//
//  YBEmojiInputView.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/12.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiDataManager.h"
#import "YBEmojiConfig.h"
#import "YBEmojiTabbar.h"
#import "YBEmojiContentView.h"
#import "YBEmojiTextView.h"

NS_ASSUME_NONNULL_BEGIN

@class YBEmojiInputView;
@protocol YBEmojiInputViewDelegate<NSObject>

// 点击表情
- (void)inputView:(YBEmojiInputView *)inputView clickedEmojiWith:(YBEmojiItemModel *)emoji;

// 点击大表情
- (void)inputView:(YBEmojiInputView *)inputView clickedBigEmojiWith:(YBEmojiItemModel *)emoji;

// 点击删除
- (void)inputView:(YBEmojiInputView *)inputView clickedDeleteWith:(UIButton *)button;

// 点击发送
- (void)inputView:(YBEmojiInputView *)inputView clickedSendWith:(UIButton *)button;

@end

@interface YBEmojiInputView : UIView

@property (nonatomic, strong) YBEmojiContentView *contentView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) YBEmojiTabbar *tabbar;

@property (nonatomic, weak, nullable) id<YBEmojiInputViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame config:(YBEmojiConfig * _Nonnull)config;

- (instancetype)initWithDlegate:(_Nonnull id <YBEmojiInputViewDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame config:(YBEmojiConfig * _Nonnull)config delegate:(nullable id <YBEmojiInputViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
