//
//  YBEmojiModel.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YBEmojiGifImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBEmojiItemModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) YBEmojiGifImage *gifImage;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@interface YBEmojiGroupModel : NSObject

@property (nonatomic, copy) NSString *cover_pic;

@property (nonatomic, copy) NSString *folderName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isLargeEmoji;

@property (nonatomic, strong) NSArray<YBEmojiItemModel *> *emojis;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
