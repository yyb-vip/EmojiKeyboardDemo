//
//  EmojiTextCell.h
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/20.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiKeyboard/YBEmojiGifImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface EmojiTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet YBEmojiGifImageView *cover;


@end

NS_ASSUME_NONNULL_END
