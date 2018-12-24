//
//  YBEmojiDataManager.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiDataManager.h"
#import "YBTextAttachment.h"

@interface YBEmojiDataManager ()

@end

@implementation YBEmojiDataManager

+ (YBEmojiDataManager *)manager {
    static YBEmojiDataManager *shareObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[YBEmojiDataManager alloc] init];
    });
    return shareObj;
}

- (NSMutableAttributedString *)replaceEmojiWithPlanString:(NSString *)planString attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes {
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:planString attributes:attributes];
    return [self replaceEmojiWithAttributedString:attStr attributes:nil];
}

- (NSMutableAttributedString *)replaceEmojiWithAttributedString:(NSAttributedString *)attributedString attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes {
    if (attributedString.length == 0) {
        return nil;
    }
    NSMutableAttributedString *targetAttStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    if (attributes) {
        [targetAttStr addAttributes:attributes range:NSMakeRange(0, attributedString.length)];
    }
    NSError *error = nil;
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"\\[/\\w+\\]" options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error && attributedString != nil && attributedString.length != 0) {
        NSArray *resultArr = [regExp matchesInString:attributedString.string options:0 range:NSMakeRange(0, attributedString.length)];
        UIFont *font = attributes[NSFontAttributeName];
        NSUInteger base = 0;
        //> 遍历匹配结果进行替换
        for (NSTextCheckingResult *result in resultArr) {
            ///> 要替换的字符串
            NSAttributedString *emojStr = [attributedString attributedSubstringFromRange:result.range];
            ///> 判断表情包里边是否包含该表情
            YBEmojiItemModel *emoji = [self isContainObjectWith:emojStr.string];
            if (emoji) {    ///> 如果表情包里边有该表情, 则进行替换, 如果没有不进行操作
                YBTextAttachment *attachment = [YBTextAttachment attachmentWith:emoji font:font];
                ///> 创建包含表情图片的属性字符串
                NSAttributedString *tempAttributedStr = [NSAttributedString attributedStringWithAttachment:attachment];
                ///> 将包含表情图片的属性字符串将表情文字替换掉
                [targetAttStr replaceCharactersInRange:NSMakeRange(result.range.location - base, result.range.length) withAttributedString:tempAttributedStr];
                base = base + emojStr.length - tempAttributedStr.length;
            }
        }
    }
    return targetAttStr;
}

///> 判断表情包所有key中是否含有相同的字符串(表情)
- (YBEmojiItemModel *)isContainObjectWith:(NSString *)str {
    YBEmojiItemModel *emoji = nil;
    for (YBEmojiGroupModel *groupModel in self.emojiPackages) {
        if (!groupModel.isLargeEmoji) {
            for (YBEmojiItemModel *emojiModel in groupModel.emojis) {
                if ([str isEqualToString:emojiModel.desc]) {
                    emoji = emojiModel;
                    break;
                }
            }
        }
    }
    return emoji;
}

- (NSString *)plainStringWith:(nonnull UITextView *)textView {
    NSMutableString *planString = [textView.textStorage.string mutableCopy];
    __block NSUInteger base = 0;
    [textView.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, textView.textStorage.length) options:0 usingBlock:^(YBTextAttachment * _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value && [value isKindOfClass:[YBTextAttachment class]]) {
            [planString replaceCharactersInRange:NSMakeRange(range.location + base, range.length) withString:value.desc];
            base = base + value.desc.length - 1;
        }
    }];
    return planString;
}

- (NSString *)plainStringWith:(NSAttributedString *)attributedString range:(NSRange)range {
    NSMutableString *planString = [[NSMutableString alloc] init];
    if (range.length == 0) {
        return planString;
    }
    NSString *string = attributedString.string;
    [attributedString enumerateAttribute:NSAttachmentAttributeName inRange:range options:kNilOptions usingBlock:^(YBTextAttachment *value, NSRange range, BOOL *stop) {
        if (value && [value isKindOfClass:[YBTextAttachment class]]) {
            [planString appendString:value.desc];
        } else {
            [planString appendString:[string substringWithRange:range]];
        }
    }];
    return planString;
}

// 表情数据
- (NSArray<YBEmojiGroupModel *> *)emojiPackages {
    if (!_emojiPackages) {
        NSString *emojiBundlePath = [[NSBundle mainBundle] pathForResource:@"EmojiPackage" ofType:@"bundle"];
        NSBundle *emojiBundle = [NSBundle bundleWithPath:emojiBundlePath];
        NSString *emojiPath = [emojiBundle pathForResource:@"EmojiPackageList" ofType:@"plist"];
        NSMutableArray<YBEmojiGroupModel *> *emojiPackageList = [NSMutableArray array];
        NSArray<NSDictionary *> *emojiArray = [NSArray arrayWithContentsOfFile:emojiPath];
        NSLog(@">>>>>>>>");
        for (int i = 0; i < emojiArray.count; i ++) {
            YBEmojiGroupModel *groupModel = [[YBEmojiGroupModel alloc] initWithDict:emojiArray[i]];
            [emojiPackageList addObject:groupModel];
        }
        NSLog(@">>>>>>>>");
        _emojiPackages = emojiPackageList;
    }
    return _emojiPackages;
}

@end
