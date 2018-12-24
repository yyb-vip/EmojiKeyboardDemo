//
//  YBTextAttachment.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/16.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBTextAttachment : NSTextAttachment

+ (YBTextAttachment *)attachmentWith:(YBEmojiItemModel *)emoji font:(UIFont *)font;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
