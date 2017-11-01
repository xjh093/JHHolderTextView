//
//  JHHolderTextView.h
//  JHKit
//
//  Created by HaoCold on 2017/4/1.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHHolderTextView : UIView

@property (copy,    nonatomic) NSString *text;

@property (strong,  nonatomic) UIColor *textColor;

@property (strong,  nonatomic) UIFont *font;

@property (copy,    nonatomic) NSString *holder;

@property (assign,  nonatomic) NSUInteger  limitCount;

@property (strong,  nonatomic) UIColor *limitCountTextColor;

@property (strong,  nonatomic) UIFont *limitCountFont;

@property (copy,    nonatomic) NSString *limitCountPrefixText;

@property (assign,  nonatomic) CGFloat  limitCountOffsetX;

@property (assign,  nonatomic) CGFloat  limitCountOffsetY;

@end
