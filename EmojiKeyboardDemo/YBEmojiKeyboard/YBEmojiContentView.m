//
//  YBEmojiContentView.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/13.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiContentView.h"

@interface YBEmojiContentView ()<UIScrollViewDelegate>

@property (nonatomic, strong) YBEmojiConfig *config;

@property (nonatomic, strong) UIScrollView *scrollView;
// 表情包模型
@property (nonatomic, strong) YBEmojiGroupModel *groupModel;

@property (nonatomic, assign) NSInteger totalPage;
// 避免重复对pageView赋值, 导致性能问题
@property (nonatomic, assign) NSInteger pageFlag;
@end

@implementation YBEmojiContentView

- (instancetype)initWithConfig:(YBEmojiConfig * _Nonnull)config {
    if (self = [super init]) {
        self.config = config;
        self.pageFlag = 0;
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.leftPageView];
        [self.scrollView addSubview:self.centerPageView];
        [self.scrollView addSubview:self.rightPageView];
    }
    return self;
}

// 点击表情包按钮
- (void)setEmojiPackageWith:(YBEmojiGroupModel *)groupModel totalPage:(NSInteger)totalPage {
    self.groupModel = groupModel;
    self.totalPage = totalPage;
    [self.scrollView setContentOffset:CGPointZero animated:NO];
    [self reSetPageViews];
    [self setNeedsLayout];
}

// 更新三个pageView位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(contentView:didScrollViewToIndex:)]) {
        NSInteger pageIndex = roundf(self.scrollView.contentOffset.x / self.bounds.size.width);
        [_delegate contentView:self didScrollViewToIndex:pageIndex];
    }
    // 当表情也小于等于两页的时候就不需要更新了
    if (self.totalPage <= 2) { return; }
    [self updatePagesView];
}

// 更新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(self.totalPage * self.bounds.size.width, self.bounds.size.height);
    CGFloat pageOffset = self.scrollView.contentOffset.x / self.bounds.size.width;
    [self layoutPageViewsWith:roundf(pageOffset)];
}

// 更新pageView位置以及内容向右滑动后, 将最右边的pageView放在最左边, 重新赋值, 向左滑动也一样>
- (void)updatePagesView {
    CGFloat pageOffset = self.scrollView.contentOffset.x / self.bounds.size.width;
    NSInteger page = roundf(pageOffset);
    if (page != self.pageFlag) {
        YBEmojiPageView *aView = nil;
        if (pageOffset > page) { // 向右滑动
            // 将最左边那页赋值过来
            [self.rightPageView configEmojisButtonWith:self.groupModel pageIndex:page - 1];
            // 交换位置
            aView = self.rightPageView;
            self.rightPageView = self.centerPageView;
            self.centerPageView = self.leftPageView;
            self.leftPageView = aView;
        }else { // 向左滑动
            // 将最右边那页赋值过来
            [self.leftPageView configEmojisButtonWith:self.groupModel pageIndex:page + 1];
            // 交换位置
            aView = self.leftPageView;
            self.leftPageView =  self.centerPageView;
            self.centerPageView = self.rightPageView;
            self.rightPageView = aView;
        }
        // 更新pageViews的frame
        [self layoutPageViewsWith:page];
    }
    self.pageFlag = page;
}

// 更新pageView的frame
- (void)layoutPageViewsWith:(NSInteger)page {
    self.leftPageView.frame = CGRectMake((page - 1) * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    self.centerPageView.frame = CGRectMake(page * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    self.rightPageView.frame = CGRectMake((page + 1) * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
}

// 重新pageView, 在点击表情包按钮的时候
- (void)reSetPageViews {
    [self.leftPageView configEmojisButtonWith:self.groupModel pageIndex:-1];
    [self.centerPageView configEmojisButtonWith:self.groupModel pageIndex:0];
    [self.rightPageView configEmojisButtonWith:self.groupModel pageIndex:1];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (YBEmojiPageView *)leftPageView {
    if (!_leftPageView) {
        _leftPageView = [[YBEmojiPageView alloc] initWithConfig:self.config];
        [_leftPageView configEmojisButtonWith:self.groupModel pageIndex:-1];
    }
    return _leftPageView;
}

- (YBEmojiPageView *)centerPageView {
    if (!_centerPageView) {
        _centerPageView = [[YBEmojiPageView alloc] initWithConfig:self.config];
        [_centerPageView configEmojisButtonWith:self.groupModel pageIndex:0];
    }
    return _centerPageView;
}

- (YBEmojiPageView *)rightPageView {
    if (!_rightPageView) {
        _rightPageView = [[YBEmojiPageView alloc] initWithConfig:self.config];
        [_rightPageView configEmojisButtonWith:self.groupModel pageIndex:1];
    }
    return _rightPageView;
}

- (YBEmojiGroupModel *)groupModel {
    if (!_groupModel) {
        _groupModel = YBEmojiDataManager.manager.emojiPackages.firstObject;
    }
    return _groupModel;
}

- (NSInteger)totalPage {
    if (_totalPage == 0) {
        NSInteger columnCount = self.groupModel.isLargeEmoji ? self.config.largeEmojiColumnCount : self.config.smallEmojiColumnCount;
        NSInteger lineCount = self.groupModel.isLargeEmoji ? self.config.largeEmojiLineCount : self.config.smallEmojiLineCount;
        
        NSInteger countOffset = self.groupModel.emojis.count % (columnCount * lineCount - 1) == 0 ? 0 : 1;
        _totalPage = self.groupModel.emojis.count / (columnCount * lineCount - 1) + countOffset;
    }
    return _totalPage;
}

@end
