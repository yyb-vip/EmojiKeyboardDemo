//
//  YBEmojiInputView.m
//  EmojiKeyboardDemo
//
//  Created by 杨艺博 on 2018/12/12.
//  Copyright © 2018 杨艺博. All rights reserved.
//

#import "YBEmojiInputView.h"

@interface YBEmojiInputView ()<YBEmojiTabbarDelegate, YBEmojiContentViewDelegate, YBEmojiPageViewDelegate>

@property (nonatomic, strong) YBEmojiConfig *config;

@end

@implementation YBEmojiInputView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame config:[YBEmojiConfig defaultConfig]];
}

- (instancetype)initWithFrame:(CGRect)frame config:(YBEmojiConfig * _Nonnull)config {
    return [self initWithFrame:frame config:config delegate:nil];
}

- (instancetype)initWithDlegate:(_Nonnull id <YBEmojiInputViewDelegate>)delegate {
    return [self initWithFrame:CGRectZero config:[YBEmojiConfig defaultConfig] delegate:delegate];
}

- (instancetype)initWithFrame:(CGRect)frame config:(YBEmojiConfig * _Nonnull)config delegate:(nullable id <YBEmojiInputViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.config = config;
        self.delegate = delegate;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self addSubview:self.tabbar];
    [self addSubview:self.pageControl];
    [self addSubview:self.contentView];
}

#pragma mark - YBEmojiTabbarDelegate
// 点击表情包
- (void)tabbar:(YBEmojiTabbar *)tabbar clickedEmojiPackageWith:(NSInteger)index {
    YBEmojiGroupModel *groupModel = YBEmojiDataManager.manager.emojiPackages[index];
    NSInteger numberPages = [self numberPageOfGroupModel:groupModel];
    self.pageControl.numberOfPages = numberPages;
    self.pageControl.currentPage = 0;
    [self.contentView setEmojiPackageWith:groupModel totalPage:numberPages];
}

// 点击发送
- (void)tabbar:(YBEmojiTabbar *)tabbar clickedSendAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(inputView:clickedSendWith:)]) {
        [_delegate inputView:self clickedSendWith:button];
    }
}

#pragma mark - YBEmojiContentViewDelegate
// 滚动pageView
- (void)contentView:(YBEmojiContentView *)contentView didScrollViewToIndex:(NSInteger)index {
    self.pageControl.currentPage = index;
}

#pragma mark - YBEmojiPageViewDelegate
// 点击表情
- (void)pageView:(YBEmojiPageView *)pageView clickedEmojiWith:(YBEmojiItemModel *)emoji {
    if (_delegate && [_delegate respondsToSelector:@selector(inputView:clickedEmojiWith:)]) {
        [_delegate inputView:self clickedEmojiWith:emoji];
    }
}

// 点击大表情
- (void)pageView:(YBEmojiPageView *)pageView clickedBigEmojiWith:(YBEmojiItemModel *)emoji {
    if (_delegate && [_delegate respondsToSelector:@selector(inputView:clickedBigEmojiWith:)]) {
        [_delegate inputView:self clickedBigEmojiWith:emoji];
    }
}

// 点击删除
- (void)pageView:(YBEmojiPageView *)pageView clickedDeleteWith:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(inputView:clickedDeleteWith:)]) {
        [_delegate inputView:self clickedDeleteWith:button];
    }
}

#pragma mark - pravite method
- (NSInteger)numberPageOfGroupModel:(YBEmojiGroupModel *)groupModel {
    NSInteger columnCount = groupModel.isLargeEmoji ? self.config.largeEmojiColumnCount : self.config.smallEmojiColumnCount;
    NSInteger lineCount = groupModel.isLargeEmoji ? self.config.largeEmojiLineCount : self.config.smallEmojiLineCount;
    
    NSInteger countOffset = groupModel.emojis.count % (columnCount * lineCount - 1) == 0 ? 0 : 1;
    NSUInteger totalPage = groupModel.emojis.count / (columnCount * lineCount - 1) + countOffset;
    return totalPage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tabbar.frame = CGRectMake(0, self.bounds.size.height-self.config.tabBarHeigh, self.bounds.size.width, self.config.tabBarHeigh);
    self.pageControl.frame = CGRectMake(0, CGRectGetMinY(self.tabbar.frame)-self.config.pageControlHeigh, self.bounds.size.width, self.config.pageControlHeigh);
    self.contentView.frame = CGRectMake(0, 0, self.bounds.size.width, CGRectGetMinY(self.pageControl.frame));
}

- (YBEmojiTabbar *)tabbar {
    if (!_tabbar) {
        _tabbar = [[YBEmojiTabbar alloc] initWithConfig:self.config];
        _tabbar.delegate = self;
    }
    return _tabbar;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = self.config.pageIndicatorTintColor;
        _pageControl.currentPageIndicatorTintColor = self.config.currentPageIndicatorTintColor;;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.numberOfPages = [self numberPageOfGroupModel:YBEmojiDataManager.manager.emojiPackages.firstObject];
    }
    return _pageControl;
}

- (YBEmojiContentView *)contentView {
    if (!_contentView) {
        _contentView = [[YBEmojiContentView alloc] initWithConfig:self.config];
        _contentView.leftPageView.delegate = self;
        _contentView.centerPageView.delegate = self;
        _contentView.rightPageView.delegate = self;
        _contentView.delegate = self;
    }
    return _contentView;
}

@end
