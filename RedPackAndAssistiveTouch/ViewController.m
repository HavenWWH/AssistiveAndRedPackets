//
//  ViewController.m
//  RedPackAndAssistiveTouch
//
//  Created by Haven on 2017/7/25.
//  Copyright © 2017年 com.RuanZhiHongYi. All rights reserved.
//

#import "ViewController.h"
#import "WindowView.h"



@interface ViewController ()
@property (nonatomic, strong) WindowView *windowView1;
@property (nonatomic, strong) WindowView *windowView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     这里的windowView是不会显示的,  被self.view覆盖了,  
     因为当前控制器是根控制器, viewcontroller管理的view时，第一次是没有改对象的，因此调用loadview创建，然后就会调用viewdidload 方法；
     你viewdidload方法返回window添加一个view ；紧接着 viewcontroller 管理的 view 加到 window；
    */
    self.windowView1 = [[WindowView alloc] initWithWindowView: CGSizeMake(100, 80) withImage:@"redPack.png" withClickBlock:^{
        NSLog(@"抢红包");
    }];
     // 根控制特殊情况用此方法显示
//    [self.view addSubview: self.windowView1];
    
    // 通过此方法查看windowView1
//    [self.view setHidden: YES];
    
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

- (IBAction)click {
    self.windowView1 = [[WindowView alloc] initWithWindowView: CGSizeZero withClickBlock:^{
        NSLog(@"click");
    }];
    self.windowView2 = [[WindowView alloc] initWithWindowView: CGSizeMake(100, 80) withImage:@"redPack.png" withClickBlock:^{
        NSLog(@"抢红包");
    }];
}



- (IBAction)hide:(id)sender {
    [self.windowView1 windowButtonHide];
    [self.windowView2 windowButtonHide];
    
}

@end
