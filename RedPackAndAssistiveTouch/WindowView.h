//
//  WindowView.h
//  MVVM
//
//  Created by Haven on 2017/7/21.
//  Copyright © 2017年 com.RuanZhiHongYi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^WindowViewClickBlock)();

@interface WindowView : UIView
// 模仿AssistiveTouch功能  size为空的时候,  默认设置为长宽为60 * 60
- (instancetype _Nullable )initWithWindowView: (CGSize)size withClickBlock:(WindowViewClickBlock _Nullable )clickBlock;

// 模仿外卖网抢红包
- (instancetype _Nullable )initWithWindowView: (CGSize)size withImage: (NSString *_Nullable)imageName withClickBlock:(WindowViewClickBlock _Nullable )clickBlock;

// 隐藏
- (void)windowButtonHide;

@end
