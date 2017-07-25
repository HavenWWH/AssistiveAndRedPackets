//
//  WindowView.m
//  MVVM
//
//  Created by Haven on 2017/7/21.
//  Copyright © 2017年 com.RuanZhiHongYi. All rights reserved.
//

#import "WindowView.h"
#import "UIView+extension.h"


#define kAppWindow           [UIApplication sharedApplication].delegate.window
//获取屏幕宽高
#define KScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
//设置View圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

@interface WindowView()
@property (nonatomic, strong) UIButton *midBtn;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, assign) CGPoint beginP;
@property (nonatomic, strong) WindowViewClickBlock clickBlock;
@end

@implementation WindowView
- (instancetype)initWithWindowView: (CGSize)size withClickBlock:(WindowViewClickBlock)clickBlock
{

    return [self initWithWindowView: size withImage: nil withClickBlock: clickBlock];;
}

- (instancetype)initWithWindowView:(CGSize)size withImage:(NSString *)imageName withClickBlock:(WindowViewClickBlock)clickBlock
{
    if (self = [super init]) {
        if (size.width == 0 && size.height == 0 && imageName.length != 0) {
            self.frame = CGRectMake(0, KScreenHeight * 0.5, 80, 60);
        }else if (size.width == 0 && size.height == 0 && imageName.length == 0){
            self.frame = CGRectMake(0, KScreenHeight * 0.5, 60, 60);
        }else{
            self.frame = CGRectMake(0, KScreenHeight * 0.5, size.width, size.height);
        }
        _clickBlock = clickBlock;
        [self createUIWithImage: imageName];
        [kAppWindow addSubview: self];
        [kAppWindow bringSubviewToFront: self];
    }
    return self;
}



- (void)createUIWithImage: (NSString *)imageName
{
    if (imageName && ![imageName isEqualToString:@""] && imageName.length != 0) {
        self.imageV = [[UIImageView alloc] initWithImage: [UIImage imageNamed: imageName]];
        self.imageV.size = CGSizeMake(self.width, self.height);
        self.imageV.backgroundColor = [UIColor clearColor];
        self.imageV.center = CGPointMake(self.width * 0.5, self.height * 0.5);
        self.imageV.userInteractionEnabled = NO;
        [self addSubview: self.imageV];
    }else{
        self.backgroundColor = [UIColor grayColor];
        ViewRadius(self, 10);
        self.midBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        self.midBtn.size = CGSizeMake(self.width * 0.5, self.height * 0.5);
        ViewRadius(self.midBtn, self.midBtn.size.width * 0.5);
        self.midBtn.backgroundColor = [UIColor whiteColor];
        self.midBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
        self.midBtn.userInteractionEnabled = NO;
        [self addSubview: self.midBtn];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    self.beginP = [touch locationInView: kAppWindow];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint endP = [touch locationInView: kAppWindow];
    CGPoint preP = [touch previousLocationInView: kAppWindow];
//    NSLog(@"%@", NSStringFromCGPoint(endP));
    CGFloat offX = endP.x - preP.x;
    CGFloat offY = endP.y - preP.y;
    
    // 移动View
    self.transform = CGAffineTransformTranslate(self.transform, offX, offY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 判断view位置
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView: kAppWindow];
    // 判断开始点和结束点是否是同一点,  同一点表示为点击, 否则表示移动
    if (!CGPointEqualToPoint(point, self.beginP)) {
        if (point.y < self.height && point.x > KScreenWidth - self.width) {
            self.origin = CGPointMake(KScreenWidth - self.width, 0);
            return;
        }
        if (point.y > KScreenHeight - self.height && point.x >KScreenWidth - self.width){
            self.origin = CGPointMake(KScreenWidth - self.width, KScreenHeight - self.height);
            return;
        }
        if (point.x < self.width * 0.5  && point.y < self.height) {
            self.origin = CGPointMake(0,0);
            return;
        }
        if (point.y > KScreenHeight - self.height && point.x < self.width * 0.5) {
            self.origin = CGPointMake(0,KScreenHeight - self.height);
            return;
        }
        if (point.x < KScreenWidth * 0.5) {
            if (point.y < self.height) {
                self.origin = CGPointMake(point.x - self.width * 0.5, 0);
            }else if (point.y > KScreenHeight - self.height){
                self.origin = CGPointMake(point.x - self.width * 0.5, KScreenHeight - self.height);
            }else{
                self.origin = CGPointMake(0, point.y- self.height * 0.5);
            }
        }else{
            if (point.y < self.height) {
                self.origin = CGPointMake(point.x - self.width * 0.5, 0);
            }else if (point.y > KScreenHeight - self.height){
                self.origin = CGPointMake(point.x - self.width * 0.5, KScreenHeight - self.height);
            }else{
                self.origin = CGPointMake(KScreenWidth - self.width, point.y- self.height * 0.5);
            }
        }
    }
    else{
        if (self.clickBlock) {
            self.clickBlock();
        }
    }
    
}

- (void)windowButtonHide
{
    [self removeFromSuperview];
}

@end
