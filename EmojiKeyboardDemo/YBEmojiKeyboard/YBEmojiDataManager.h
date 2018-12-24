//
//  YBEmojiDataManager.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBEmojiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBEmojiDataManager : NSObject

@property (nonatomic, strong) NSArray<YBEmojiGroupModel *> *emojiPackages;

+ (YBEmojiDataManager *)manager;

- (NSMutableAttributedString *)replaceEmojiWithPlanString:(NSString *)planString attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes;

- (NSMutableAttributedString *)replaceEmojiWithAttributedString:(NSAttributedString *)attributedString attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes;

- (NSString *)plainStringWith:(nonnull UITextView *)textView;

- (NSString *)plainStringWith:(NSAttributedString *)attributedString range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
