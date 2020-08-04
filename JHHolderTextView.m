//
//  JHHolderTextView.m
//  JHKit
//
//  Created by HaoCold on 2017/4/1.
//  Copyright © 2017年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
        _limitCountPrefixText = @"";
        _limitCountSubfixText = @"";
        _showLimitCount = YES;
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
    
    if (_limitCount == 0) {
        return;
    }
    
    if (textView.text.length > _limitCount) {
        textView.text = [textView.text substringToIndex:_limitCount];
        _limitedLabel.text = [NSString stringWithFormat:@"%@%@/%@%@",_limitCountPrefixText,@(_limitCount),@(_limitCount),_limitCountSubfixText];
    }else{
        _limitedLabel.text = [NSString stringWithFormat:@"%@%@/%@%@",_limitCountPrefixText,@(textView.text.length),@(_limitCount),_limitCountSubfixText];
    }
}

- (void)setText:(NSString *)text{
    if (text) {
        _textView.text = text;
        [self jhCount:_textView];
    }
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
    _holderLabel.text = [@" " stringByAppendingString:holder];
}

- (void)setTextViewBackgroundColor:(UIColor *)textViewBackgroundColor{
    _textViewBackgroundColor = textViewBackgroundColor;
    _textView.backgroundColor = textViewBackgroundColor;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    CGFloat offsetY = _showLimitCount ? 16 : 0;
    
    CGRect frame = _textView.frame;
    frame.origin.x = edgeInsets.left;
    frame.origin.y = edgeInsets.top;
    frame.size.width = CGRectGetWidth(self.frame) - edgeInsets.left - edgeInsets.right;
    frame.size.height = CGRectGetHeight(self.frame) - edgeInsets.top - edgeInsets.bottom - offsetY;
    
    _textView.frame = frame;
}

- (NSString *)holder{
    return _holderLabel.text;
}

- (void)setHolderTextColor:(UIColor *)holderTextColor{
    _holderTextColor = holderTextColor;
    _holderLabel.textColor = holderTextColor;
}

- (void)setHolderFont:(UIFont *)holderFont{
    _holderFont = holderFont;
    _holderLabel.font = holderFont;
}

- (void)setLimitCount:(NSUInteger)limitCount{
    _limitCount = limitCount;
    _limitedLabel.text = [NSString stringWithFormat:@"%@0/%@",_limitCountPrefixText,@(limitCount)];
    [self jhCount:_textView];
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
    _limitedLabel.text = [NSString stringWithFormat:@"%@0/%@%@",limitCountPrefixText,@(_limitCount),_limitCountSubfixText];
}

- (void)setLimitCountSubfixText:(NSString *)limitCountSubfixText{
    _limitCountSubfixText = limitCountSubfixText;
    _limitedLabel.text = [NSString stringWithFormat:@"%@0/%@%@",_limitCountPrefixText,@(_limitCount),limitCountSubfixText];
}

- (void)setLimitCountOffsetX:(CGFloat)limitCountOffsetX{
    _limitCountOffsetX = limitCountOffsetX;
    _limitedLabel.center = CGPointMake(_limitedLabel.center.x + limitCountOffsetX, _limitedLabel.center.y);
}

- (void)setLimitCountOffsetY:(CGFloat)limitCountOffsetY{
    _limitCountOffsetY = limitCountOffsetY;
    _limitedLabel.center = CGPointMake(_limitedLabel.center.x, _limitedLabel.center.y + limitCountOffsetY);
}

- (void)setShowLimitCount:(BOOL)showLimitCount{
    if (_showLimitCount != showLimitCount) {
        _showLimitCount = showLimitCount;
        
        CGRect frame = _textView.frame;
        if (_showLimitCount) {
            frame.size.height -= 16;
        }else{
            frame.size.height += 16;
        }
        _textView.frame = frame;
        _limitedLabel.hidden = !showLimitCount;
    }
}

@end
