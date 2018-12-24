//
//  YBEmojiPreviewView.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/17.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiModel.h"
#import "YBEmojiConfig.h"
#import "YBEmojiGifImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBEmojiPreviewView : UIImageView

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config;

- (void)setEmojiItemModel:(YBEmojiItemModel *)emojiModel isLargeEmoji:(BOOL)isLargeEmoji;

- (void)setAngleOffset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
