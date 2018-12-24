//
//  YBEmojiImageView.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/17.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBEmojiItemView : UIView

@property (nonatomic, strong) YBEmojiItemModel *emoji;

@property (nonatomic, assign) BOOL isShowTitle;

- (void)addTarget:(nullable id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
