//
//  YBEmojiModel.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiModel.h"
#import "YBEmojiGifImage.h"

@implementation YBEmojiItemModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.imageName = dict[@"image"];
        self.desc = dict[@"desc"];
    }
    return self;
}

@end

@implementation YBEmojiGroupModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.cover_pic = dict[@"cover_pic"];
        self.title = dict[@"title"];
        self.folderName = dict[@"folderName"];
        self.isLargeEmoji = [dict[@"isLargeEmoji"] boolValue];
        NSMutableArray *arrM = [NSMutableArray array];
        
        NSString *emojiBundlePath = [[NSBundle mainBundle] pathForResource:@"EmojiPackage" ofType:@"bundle"];
        NSString *sourcePath = [[NSBundle bundleWithPath:emojiBundlePath] pathForResource:self.folderName ofType:nil];
        
        NSArray<NSDictionary *> *emojis = dict[@"emojis"];
        for (int i = 0; i < emojis.count; i ++) {
            NSDictionary *emojiDict = emojis[i];
            YBEmojiItemModel *emoji = [[YBEmojiItemModel alloc] init];
            NSString *imagePath = [sourcePath stringByAppendingPathComponent:emojiDict[@"image"]];
            emoji.imageName = emojiDict[@"image"];
            emoji.desc = emojiDict[@"desc"];
            emoji.image = [UIImage imageWithContentsOfFile:imagePath];
            emoji.gifImage = [YBEmojiGifImage imageWithContentsOfFile:imagePath];
            [arrM addObject:emoji];
        }
        self.emojis = arrM;
    }
    return self;
}

@end
