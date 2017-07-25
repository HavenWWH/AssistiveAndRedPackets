# AssistiveAndRedPackets
#AssistiveAndRedPackets
模仿Assistive和外卖网抢红包

## Usage
```c
// 1, 创建AssistiveTouch
    [[WindowView alloc] initWithWindowView: CGSizeZero withClickBlock:^{
        NSLog(@"click");
    }];
// 2, 创建抢红包
    [[WindowView alloc] initWithWindowView: CGSizeMake(100, 80) withImage:@"redPack.png" withClickBlock:^{
        NSLog(@"抢红包");
    }];
```

## DEMO
## ![image](https://github.com/tbl00c/TLCityPicker/blob/master/Demo.gif)
