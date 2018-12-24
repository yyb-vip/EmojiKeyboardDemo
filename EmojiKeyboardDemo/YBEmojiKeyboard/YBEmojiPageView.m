//
//  YBEmojiPageView.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiPageView.h"
#import "YBEmojiGifImageView.h"
#import "YBEmojiPreviewView.h"

@interface YBEmojiPageView ()

@property (nonatomic, strong) YBEmojiConfig *config;

@property (nonatomic, strong) NSMutableArray<YBEmojiItemView *> *emojiItems;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) BOOL isLargeEmoji;

@property (nonatomic, strong) YBEmojiPreviewView *emojiPreview;

@end

@implementation YBEmojiPageView

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config {
    if (self = [super init]) {
        self.config = config;
        self.backgroundColor = config.pageViewBackgroundColor;
        self.emojiItems = [NSMutableArray array];
        // 初始化, 循环创建表情按钮(每页的按钮数量 = 行数 x 列数, 最后一个为删除按钮, 所以表情按钮数量要 -1<大表情就不需要-1了>)
        NSInteger btnCount = MAX(config.smallEmojiLineCount*config.smallEmojiColumnCount-1, config.largeEmojiLineCount*config.largeEmojiColumnCount);
        for (NSUInteger i = 0; i < btnCount; i++) {
            YBEmojiItemView *emojiItem = [[YBEmojiItemView alloc] init];
            [emojiItem addTarget:self action:@selector(clickedEmojiItemView:)];
            [_emojiItems addObject:emojiItem];
            [self addSubview:emojiItem];
        }
        // 删除按钮
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setImage:self.config.pageViewDeleteButtonImage forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(clickedDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteBtn];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)];
        longPress.minimumPressDuration = 0.25;
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger columnCount = self.isLargeEmoji ? self.config.largeEmojiColumnCount : self.config.smallEmojiColumnCount;
    NSInteger lineCount = self.isLargeEmoji ? self.config.largeEmojiLineCount : self.config.smallEmojiLineCount;
    
    // 计算表情按钮宽度
    CGFloat width = (self.bounds.size.width - self.config.pageViewEdgeInsets.left - self.config.pageViewEdgeInsets.right - ((columnCount - 1) * self.config.pageViewMinColumnSpace)) / (CGFloat)columnCount;
    // 计算表情按钮高度
    CGFloat heigh = (self.bounds.size.height - self.config.pageViewEdgeInsets.top - self.config.pageViewEdgeInsets.bottom - ((lineCount - 1) * self.config.pageViewMinLineSpace)) / (CGFloat)lineCount;
    // 表情按钮为正方形, 所以取一个最小值作为宽高, 那么久需要重新计算行间距列间距
    CGFloat minSize = MIN(width, heigh);
    // 计算行间距
    CGFloat lineSpace = (self.bounds.size.height - self.config.pageViewEdgeInsets.top - self.config.pageViewEdgeInsets.bottom - minSize * lineCount) / (CGFloat)(lineCount + 1);
    // 计算列间距
    CGFloat columnSpace = (self.bounds.size.width - self.config.pageViewEdgeInsets.left - self.config.pageViewEdgeInsets.right - minSize * columnCount) / (CGFloat)(columnCount + 1);
    // 遍历设置表情按钮的frame
    for (int i = 0; i < self.emojiItems.count; i ++) {
        NSInteger line = i / columnCount;   // 当前行数
        NSInteger column = i % columnCount; // 当前列数
        // 表情按钮的最小 x 和最小 y
        CGFloat minX = self.config.pageViewEdgeInsets.left + column * minSize + ((column + 1) * columnSpace);
        CGFloat minY = self.config.pageViewEdgeInsets.top + (line * minSize) + ((line + 1) * lineSpace);
        CGRect frame = CGRectMake(minX, minY, minSize, minSize);
        self.emojiItems[i].frame = frame;
    }
    // 删除按钮
    self.deleteBtn.frame = CGRectMake(self.bounds.size.width - self.config.pageViewEdgeInsets.right - minSize, self.bounds.size.height - self.config.pageViewEdgeInsets.bottom - minSize - lineSpace, minSize, minSize);
    self.deleteBtn.hidden = self.isLargeEmoji;
}

// 点击表情
- (void)clickedEmojiItemView:(UITapGestureRecognizer *)tap {
    YBEmojiItemView *emojiItemView = (YBEmojiItemView *)tap.view;
    if (emojiItemView.emoji == nil) return;
    if (self.isLargeEmoji) {
        if (_delegate && [_delegate respondsToSelector:@selector(pageView:clickedBigEmojiWith:)]) {
            [_delegate pageView:self clickedBigEmojiWith:emojiItemView.emoji];
        }
    }else {
        if (_delegate && [_delegate respondsToSelector:@selector(pageView:clickedEmojiWith:)]) {
            [_delegate pageView:self clickedEmojiWith:emojiItemView.emoji];
        }
    }
}

// 点击删除
- (void)clickedDeleteButtonAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(pageView:clickedDeleteWith:)]) {
        [_delegate pageView:self clickedDeleteWith:sender];
    }
}

- (void)configEmojisButtonWith:(YBEmojiGroupModel *)groupModel pageIndex:(NSInteger)pageIndex {
    self.isLargeEmoji = groupModel.isLargeEmoji;
    // 重置表情按钮图片
    NSArray<YBEmojiItemModel *> *emojis = [self emojiItemWith:groupModel atPageIndex:pageIndex];
    self.hidden = emojis.count == 0;
    for (int i = 0; i < self.emojiItems.count; i ++) {
        YBEmojiItemView *emojiItemView = self.emojiItems[i];
        // 设置表情图片 当表情数量不满一整页的时候, 其余按钮图片置空
        YBEmojiItemModel *emoji = i < emojis.count ? emojis[i] : nil;
        emojiItemView.isShowTitle = groupModel.isLargeEmoji;
        [emojiItemView setEmoji:emoji];
    }
    [self setNeedsLayout];
}

// 获取表情包对应页码的模型数组
- (NSArray<YBEmojiItemModel *> *)emojiItemWith:(YBEmojiGroupModel *)groupModel atPageIndex:(NSInteger )pageIndex {
    if (!groupModel || !groupModel.emojis.count) {
        return nil;
    }
    NSInteger columnCount = self.isLargeEmoji ? self.config.largeEmojiColumnCount : self.config.smallEmojiColumnCount;
    NSInteger lineCount = self.isLargeEmoji ? self.config.largeEmojiLineCount : self.config.smallEmojiLineCount;
    NSInteger emojiCOuntOfPage = self.isLargeEmoji ? columnCount * lineCount : columnCount * lineCount - 1;
    NSUInteger totalPage = (groupModel.emojis.count / emojiCOuntOfPage) + 1;
    if (pageIndex >= totalPage || pageIndex < 0) {
        return nil;
    }
    BOOL isLastPage = (pageIndex == totalPage - 1 ? YES : NO);
    // 截取的初始位置
    NSUInteger beginIndex = pageIndex * emojiCOuntOfPage;
    // 截取长度
    NSUInteger length = isLastPage ? (groupModel.emojis.count - pageIndex * emojiCOuntOfPage) : emojiCOuntOfPage;
    NSArray *emojis = [groupModel.emojis subarrayWithRange:NSMakeRange(beginIndex, length)];
    return emojis;
}

- (void)longPressPageView:(UILongPressGestureRecognizer *)longPress {
    
    YBEmojiItemView *emojiItemView = nil;
    CGPoint point = [longPress locationInView:self];
    // 遍历当前页所有按钮, 找到手指所在的按钮
    for (YBEmojiItemView *emojiItem in self.emojiItems) {
        // 大表情长按时候有背景颜色, 小表情则没有
        if (CGRectContainsPoint(emojiItem.frame, point)) {
            emojiItemView = emojiItem;
            if (self.isLargeEmoji) {
                // 大表情长按预览的背景颜色
                emojiItem.backgroundColor = self.config.largeEmojiHighlightBackgroundColor;
            }else {
                break;
            }
        }else {
            emojiItem.backgroundColor = UIColor.clearColor;
        }
    }
    
    if (longPress.state == UIGestureRecognizerStateFailed ||
        longPress.state == UIGestureRecognizerStateCancelled ||
        longPress.state == UIGestureRecognizerStateEnded ||
        emojiItemView.emoji == nil) {
        // hide preview
        self.emojiPreview.hidden = YES;
        // 清除在大表情的时候长按的背景颜色
        if (self.isLargeEmoji) {
            emojiItemView.backgroundColor = UIColor.clearColor;
        }
    }else {
        // show preview
        self.emojiPreview.hidden = NO;
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        // 先计算出相对于window的位置, 然后计算预览视图的frame
        CGRect rectOfWindow = [emojiItemView convertRect:emojiItemView.bounds toView:window];
        // 预览视图的宽度
        CGFloat preview_w = self.isLargeEmoji ? self.config.largeEmojiPreviewSize.width : self.config.emojiPreviewSize.width;
        // 预览视图的高度
        CGFloat preview_h = self.isLargeEmoji ? self.config.largeEmojiPreviewSize.height : self.config.emojiPreviewSize.height;
        // 预览视图的x
        CGFloat preview_x = CGRectGetMaxX(rectOfWindow) - preview_w + (preview_w - rectOfWindow.size.width) / 2.0;
        // 预览视图的y
        CGFloat preview_y = self.isLargeEmoji ? CGRectGetMinY(rectOfWindow) - preview_h : CGRectGetMaxY(rectOfWindow) - preview_h;
        // 计算大表情三角指示器的偏移量
        CGFloat angleOffset_x = 0;
        if (self.config.largeEmojiPreviewBorderMargin != 0 && self.isLargeEmoji) {
            if (preview_x < self.config.largeEmojiPreviewBorderMargin) {
                angleOffset_x = preview_x - self.config.largeEmojiPreviewBorderMargin;
                preview_x = self.config.largeEmojiPreviewBorderMargin;
            }
            if (preview_x + preview_w > UIScreen.mainScreen.bounds.size.width - self.config.largeEmojiPreviewBorderMargin) {
                angleOffset_x = self.config.largeEmojiPreviewBorderMargin + preview_x + preview_w - UIScreen.mainScreen.bounds.size.width;
                preview_x = UIScreen.mainScreen.bounds.size.width - self.config.largeEmojiPreviewBorderMargin - preview_w;
            }
        }
        CGRect frame = CGRectMake(preview_x, preview_y, preview_w, preview_h);
        // 将当前手指所在位置的表情模型给预览视图进行显示
        [self.emojiPreview setEmojiItemModel:emojiItemView.emoji isLargeEmoji:self.isLargeEmoji];
        self.emojiPreview.frame = frame;
        // 用来调整大表情三角指示器的居中
        [self.emojiPreview setAngleOffset:angleOffset_x];
    }
}


- (YBEmojiPreviewView *)emojiPreview {
    if (!_emojiPreview) {
        _emojiPreview = [[YBEmojiPreviewView alloc] initWithConfig:self.config];
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        [window addSubview:_emojiPreview];
    }
    return _emojiPreview;
}


@end
