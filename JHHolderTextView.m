//
//  JHHolderTextView.m
//  JHKit
//
//  Created by HaoCold on 2017/4/1.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHHolderTextView.h"

@interface JHHolderTextView()<UITextViewDelegate>

@property (nonatomic,   strong) UITextView      *textView;
@property (nonatomic,   strong) UILabel         *holderLabel;
@property (nonatomic,   strong) UILabel         *limitedLabel;

@end

@implementation JHHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jhSetupViews:frame];
    }
    return self;
}

- (void)jhSetupViews:(CGRect)frame
{
    [self addSubview:({[[UIView alloc] init];})];
    
    CGFloat X = 10;
    CGFloat Y = 5;
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(X, Y, frame.size.width-2*X, frame.size.height-2*Y-16);
    textView.font = [UIFont systemFontOfSize:14];
    textView.delegate = self;
    textView.showsVerticalScrollIndicator = NO;
    [self addSubview:textView];
    _textView = textView;
    
    UILabel *holderLabel = [[UILabel alloc] init];
    holderLabel.frame = CGRectMake(X, textView.frame.origin.y+10, frame.size.width-2*X, 14);
    holderLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    holderLabel.font = textView.font;
    holderLabel.text = @" 请在此输入内容";
    [self addSubview:holderLabel];
    _holderLabel = holderLabel;
    
    UILabel *limitedLabel = [[UILabel alloc] init];
    limitedLabel.frame = CGRectMake(X, CGRectGetMaxY(textView.frame), CGRectGetWidth(textView.frame), 16);
    limitedLabel.text = @"";
    limitedLabel.textColor = [UIColor blackColor];
    limitedLabel.font = [UIFont systemFontOfSize:14];
    limitedLabel.textAlignment = 2;
    [self addSubview:limitedLabel];
    _limitedLabel = limitedLabel;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _holderLabel.hidden = YES;
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    [self jhCount:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self jhCount:textView];
}

- (void)jhCount:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _holderLabel.hidden = NO;
    }else{
        _holderLabel.hidden = YES;
    }
    
    if (textView.text.length > _limitCount) {
        textView.text = [textView.text substringToIndex:_limitCount];
        _limitedLabel.text = [NSString stringWithFormat:@"%@%@/%@",_limitCountPrefixText,@(_limitCount),@(_limitCount)];
    }else{
        _limitedLabel.text = [NSString stringWithFormat:@"%@%@/%@",_limitCountPrefixText,@(textView.text.length),@(_limitCount)];
    }
}

- (void)setText:(NSString *)text{
    _textView.text = text;
}

- (NSString *)text{
    return _textView.text;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _textView.textColor = textColor;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    _textView.font = font;
    _holderLabel.font = font;
}

- (void)setHolder:(NSString *)holder{
    _holderLabel.text = holder;
}

- (NSString *)holder{
    return _holderLabel.text;
}

- (void)setLimitCount:(NSUInteger)limitCount{
    _limitCount = limitCount;
    _limitedLabel.text = [NSString stringWithFormat:@"%@0/%@",_limitCountPrefixText,@(limitCount)];
}

- (void)setLimitCountTextColor:(UIColor *)limitCountTextColor{
    _limitCountTextColor = limitCountTextColor;
    _limitedLabel.textColor = limitCountTextColor;
}

- (void)setLimitCountFont:(UIFont *)limitCountFont{
    _limitCountFont = limitCountFont;
    _limitedLabel.font = limitCountFont;
}

- (void)setLimitCountPrefixText:(NSString *)limitCountPrefixText{
    _limitCountPrefixText = limitCountPrefixText;
    _limitedLabel.text = [NSString stringWithFormat:@"%@0/%@",limitCountPrefixText,@(_limitCount)];
}

- (void)setLimitCountOffsetX:(CGFloat)limitCountOffsetX{
    _limitCountOffsetX = limitCountOffsetX;
    _limitedLabel.center = CGPointMake(_limitedLabel.center.x + limitCountOffsetX, _limitedLabel.center.y);
}

- (void)setLimitCountOffsetY:(CGFloat)limitCountOffsetY{
    _limitCountOffsetY = limitCountOffsetY;
    _limitedLabel.center = CGPointMake(_limitedLabel.center.x, _limitedLabel.center.y + limitCountOffsetY);
}

@end
