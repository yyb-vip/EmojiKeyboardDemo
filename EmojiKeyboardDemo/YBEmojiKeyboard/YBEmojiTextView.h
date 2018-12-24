//
//  YBEmojiTextView.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/16.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBEmojiTextView : UITextView

@property (nonatomic, strong) NSDictionary<NSAttributedStringKey, id> *attributes;

@end

NS_ASSUME_NONNULL_END
