//
//  YBEmojiTextView.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/16.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiTextView.h"

@implementation YBEmojiTextView

- (void)cut:(id)sender {
    NSString *string = [YBEmojiDataManager.manager plainStringWith:self.attributedText range:self.selectedRange];
    if (string.length) {
        [UIPasteboard generalPasteboard].string = string;
        NSRange selectedRange = self.selectedRange;
        NSMutableAttributedString *attributeContent = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributeContent replaceCharactersInRange:self.selectedRange withString:@""];
        self.attributedText = attributeContent;
        self.selectedRange = NSMakeRange(selectedRange.location, 0);
        if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [self.delegate textViewDidChange:self];
        }
    }
}

- (void)copy:(id)sender {
    NSString *string = [YBEmojiDataManager.manager plainStringWith:self.attributedText range:self.selectedRange];
    if (string.length) {
        [UIPasteboard generalPasteboard].string = string;
    }
}

- (void)paste:(id)sender {
    NSString *string = UIPasteboard.generalPasteboard.string;
    if (string.length) {
        NSMutableAttributedString *attributedPasteString = [[NSMutableAttributedString alloc] initWithString:string];
        attributedPasteString = [YBEmojiDataManager.manager replaceEmojiWithAttributedString:attributedPasteString attributes:self.attributes];
        NSRange selectedRange = self.selectedRange;
        NSMutableAttributedString *attributeContent = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributeContent replaceCharactersInRange:self.selectedRange withAttributedString:attributedPasteString];
        self.attributedText = attributeContent;
        self.selectedRange = NSMakeRange(selectedRange.location + attributedPasteString.length, 0);
        if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [self.delegate textViewDidChange:self];
        }
    }
}

@end
