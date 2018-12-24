//
//  YBTextAttachment.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/16.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBTextAttachment.h"

@implementation YBTextAttachment

+ (YBTextAttachment *)attachmentWith:(YBEmojiItemModel *)emoji font:(UIFont *)font {
    YBTextAttachment *attachment = [[YBTextAttachment alloc] init];
    attachment.desc = emoji.desc;
    attachment.imageName = emoji.imageName;
    attachment.bounds = CGRectMake(0, font.descender, font.lineHeight, font.lineHeight);
    attachment.image = emoji.image;
    return attachment;
}


@end
