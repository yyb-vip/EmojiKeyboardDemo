//
//  YBEmojiConfig.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YBEmojiConfig : NSObject

// ------------------------ tabbar
// tabbar 高度
@property (nonatomic, assign) CGFloat tabBarHeigh;
// 表情包按钮宽度
@property (nonatomic, assign) CGFloat packageButtonWidth;
// 表情包按钮选中背景颜色
@property (nonatomic, strong) UIColor *packageButtonSelectedColor;
// 表情包按钮未选中背景颜色
@property (nonatomic, strong) UIColor *packageButtonNormalColor;

// ------------------------ 发送按钮
// 发送按钮背景颜色
@property (nonatomic, strong) UIColor *sendButtonBackgroundColor;
// 发送文字字体
@property (nonatomic, assign) UIFont *sendButtonTitleFont;
// 发送按钮文字颜色
@property (nonatomic, strong) UIColor *sendButtonTitleColor;
// 发送按钮宽度
@property (nonatomic, assign) CGFloat sendButtonWidth;
// 发送按钮文字
@property (nonatomic, copy, nullable) NSString *sendButtonTitle;
// 发送按钮图片
@property (nonatomic, strong, nullable) UIImage *sendButtonImage;

// ------------------------ pageControl
// 指示器高度
@property (nonatomic, assign) CGFloat pageControlHeigh;
// 指示器未选中颜色
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
// 指示器选中颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

// ------------------------ pageView
// 背景颜色
@property (nonatomic, strong) UIColor *pageViewBackgroundColor;
// 表情按钮边距
@property (nonatomic, assign) UIEdgeInsets pageViewEdgeInsets;
// 小表情行数
@property (nonatomic, assign) NSInteger smallEmojiLineCount;
// 小表情列数
@property (nonatomic, assign) NSInteger smallEmojiColumnCount;
// 大表情行数
@property (nonatomic, assign) NSInteger largeEmojiLineCount;
// 大表情列数
@property (nonatomic, assign) NSInteger largeEmojiColumnCount;
// 最小行间距
@property (nonatomic, assign) CGFloat pageViewMinLineSpace;
// 最小列间距
@property (nonatomic, assign) CGFloat pageViewMinColumnSpace;
// 删除按钮图片
@property (nonatomic, strong) UIImage *pageViewDeleteButtonImage;
// 长按大表情背景颜色
@property (nonatomic, strong) UIColor *largeEmojiHighlightBackgroundColor;

// ------------------------ previewView
// emoji 预览视图大小
@property (nonatomic, assign) CGSize emojiPreviewSize;
// emoji 预览背景图片
@property (nonatomic, strong) UIImage *emojiPreviewImage;
// emoji 预览图片边距 bottom为距离 descLabel 的距离
@property (nonatomic, assign) UIEdgeInsets emojiImageViewEdgeInsets;
// descLabel 高度
@property (nonatomic, assign) CGFloat emojiPreviewDescLabel_h;
// descLabel 字体
@property (nonatomic, strong) UIFont *emojiPreviewDescLabelFont;
// descLabel 文字颜色
@property (nonatomic, strong) UIColor *emojiPreviewDescLabelTextColor;

// 大表情预览视图大小
@property (nonatomic, assign) CGSize largeEmojiPreviewSize;
// 大表情预览视图边距 bottom为距离 descLabel 的距离
@property (nonatomic, assign) UIEdgeInsets largeEmojiImageViewEdgeInsets;
// 大表情 descLabel 高度
@property (nonatomic, assign) CGFloat largeEmojiPreviewDescLabel_h;
// 大表情 descLabel 字体
@property (nonatomic, strong) UIFont *largeEmojiPreviewDescLabelFont;
// 大表情 descLabel 文字颜色
@property (nonatomic, strong) UIColor *largeEmojiPreviewDescLabelTextColor;

// 大表情背景圆角半径
@property (nonatomic, assign) CGFloat largeEmojiPreviewAngleRadius;
// 大表情背景三角指示器的高度
@property (nonatomic, assign) CGFloat largeEmojiPreviewAngleHeigh;
// 大表情背景三角指示器的宽度
@property (nonatomic, assign) CGFloat largeEmojiPreviewAngleWidth;
// 大表情背景边框线宽度
@property (nonatomic, assign) CGFloat largeEmojiPreviewLineWidth;
// 大表情填充颜色
@property (nonatomic, strong) UIColor *largeEmojiPreviewFillColor;
// 大表情背景边框线颜色
@property (nonatomic, strong) UIColor *largeEmojiPreviewBorderColor;
// 大表情viewj距离屏幕边界最小距离<如果设置为0, 则不进行处理, 即可以超出屏幕>
@property (nonatomic, assign) CGFloat largeEmojiPreviewBorderMargin;

+ (YBEmojiConfig *)defaultConfig;

@end

NS_ASSUME_NONNULL_END
