//
//  YBEmojiPreviewView.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/17.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiPreviewView.h"

// 大表情的边框视图, 通过绘制来显示
@interface YBEmojiPreviewBorderView : UIView

@property (nonatomic, strong) YBEmojiConfig *config;

@property (nonatomic, assign) CGFloat offset;

@end

@implementation YBEmojiPreviewBorderView

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config {
    if (self = [super init]) {
        self.config = config;
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat r = self.config.largeEmojiPreviewAngleRadius;
    CGFloat angle_h = self.config.largeEmojiPreviewAngleHeigh;
    CGFloat angle_w = self.config.largeEmojiPreviewAngleWidth;
    CGFloat line_w = self.config.largeEmojiPreviewLineWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = line_w;
    [self.config.largeEmojiPreviewFillColor setFill];
    [self.config.largeEmojiPreviewBorderColor setStroke];
    [path moveToPoint:CGPointMake(w / 2.0 + self.offset, h)];
    [path addLineToPoint:CGPointMake(w / 2.0 + angle_w / 2.0 + self.offset, h - angle_h)];
    // right bottom
    [path addArcWithCenter:CGPointMake(w - r - line_w / 2.0, h - angle_h - r) radius:r startAngle:-M_PI_2 * 3 endAngle:0 clockwise:NO];
    // right top
    [path addArcWithCenter:CGPointMake(w - r - line_w / 2.0, r + line_w / 2.0) radius:r startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    // left top
    [path addArcWithCenter:CGPointMake(r + line_w / 2.0, r + line_w / 2.0) radius:r startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
    // left bottom
    [path addArcWithCenter:CGPointMake(r + line_w / 2.0, h - angle_h - r) radius:r startAngle:-M_PI endAngle:-M_PI_2 * 3 clockwise:NO];
    
    [path addLineToPoint:CGPointMake(w / 2.0 - angle_w / 2.0 + self.offset, h - angle_h)];
    [path closePath];
    [path fill];
    [path stroke];
    
}

@end

@interface YBEmojiPreviewView ()

@property (nonatomic, strong) YBEmojiConfig *config;

@property (nonatomic, strong) YBEmojiGifImageView *emojiImageView;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, assign) BOOL isLargeEmoji;

@property (nonatomic, strong) YBEmojiPreviewBorderView *borderView;

@end

@implementation YBEmojiPreviewView

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config {
    if (self = [super init]) {
        self.config = config;
        
        self.borderView = [[YBEmojiPreviewBorderView alloc] initWithConfig:config];
        [self addSubview:self.borderView];
        
        self.contentMode = UIViewContentModeCenter;
        self.emojiImageView = [[YBEmojiGifImageView alloc] init];
        [self addSubview:self.emojiImageView];
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.font = config.emojiPreviewDescLabelFont;
        self.descriptionLabel.textColor = config.emojiPreviewDescLabelTextColor;
        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        self.descriptionLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.descriptionLabel];
    }
    return self;
}

- (void)setEmojiItemModel:(YBEmojiItemModel *)emojiModel isLargeEmoji:(BOOL)isLargeEmoji {
    self.isLargeEmoji = isLargeEmoji;
    self.descriptionLabel.text = [emojiModel.desc substringWithRange:NSMakeRange(2, emojiModel.desc.length-3)];
    if (!isLargeEmoji) {
        self.image = self.config.emojiPreviewImage;
        self.emojiImageView.image = emojiModel.image;
        self.emojiImageView.contentMode = UIViewContentModeCenter;
    }else {
        self.image = nil;
        self.emojiImageView.image = emojiModel.gifImage;
        self.emojiImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.borderView.frame = self.bounds;
    self.borderView.hidden = !self.isLargeEmoji;
    
    CGFloat emojiPreviewImage_w = 0;
    if (self.isLargeEmoji) {
        CGFloat w = self.bounds.size.width - self.config.largeEmojiImageViewEdgeInsets.left - self.config.largeEmojiImageViewEdgeInsets.right;
        CGFloat h = self.bounds.size.height - self.config.largeEmojiImageViewEdgeInsets.top - self.config.largeEmojiImageViewEdgeInsets.bottom - self.config.largeEmojiPreviewDescLabel_h - 8;
        emojiPreviewImage_w = MIN(w, h);
    }else {
        emojiPreviewImage_w = self.bounds.size.width - self.config.emojiImageViewEdgeInsets.left - self.config.emojiImageViewEdgeInsets.right;
    }
    CGFloat x = (self.bounds.size.width - emojiPreviewImage_w) / 2.0;
    CGFloat y = self.isLargeEmoji ? self.config.largeEmojiImageViewEdgeInsets.top : self.config.emojiImageViewEdgeInsets.top;
    CGFloat label_h = self.isLargeEmoji ? self.config.largeEmojiPreviewDescLabel_h : self.config.emojiPreviewDescLabel_h;
    CGFloat labelOffset_y = self.isLargeEmoji ? self.config.largeEmojiImageViewEdgeInsets.bottom : self.config.emojiImageViewEdgeInsets.bottom;
    self.emojiImageView.frame = CGRectMake(x, y, emojiPreviewImage_w, emojiPreviewImage_w);
    self.descriptionLabel.frame = CGRectMake(x, CGRectGetMaxY(self.emojiImageView.frame) + labelOffset_y, emojiPreviewImage_w, label_h);
    [self.borderView setNeedsDisplay];
}

- (void)setAngleOffset:(CGFloat)offset {
    self.borderView.offset = offset;
    [self.borderView setNeedsDisplay];
}



@end
