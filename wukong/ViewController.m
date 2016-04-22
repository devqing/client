//
//  ViewController.m
//  MBProgress
//
//  Created by Circle on 16/4/12.
//  Copyright © 2016年 Hoolang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *container;
@property (nonatomic, strong) CAShapeLayer *shapeLayerProgress;
@property (nonatomic, strong) CAShapeLayer *shapeLayerBackground;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.container = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.container.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.container];
    // 初始旋转，则从顶部开始画圆，否则从右侧开始花园

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.container.transform = CGAffineTransformMakeRotation(-M_PI/2);
    [self initLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeValue:(id)sender {
//    _shapeLayerProgress.strokeStart = 0;
//    _shapeLayerProgress.strokeEnd = self.slider.value;
//    
//    [_percentLabel setText:[NSString stringWithFormat:@"%.f%%", self.slider.value * 100]];
//    NSLog(@"self.slider.value:%f", self.slider.value);
}

-(void)initLayer{
#pragma mark 背景
    //创建出CAShapeLayer
    self.shapeLayerBackground = [CAShapeLayer layer];
    self.shapeLayerBackground.frame = CGRectMake(0, 0, 100, 100);
    self.shapeLayerBackground.position = CGPointMake(self.container.frame.size.width *0.5, self.container.frame.size.height * 0.5);
    self.shapeLayerBackground.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayerBackground.lineWidth = 2.0f;
    self.shapeLayerBackground.strokeColor = [UIColor redColor].CGColor;
    
    //设置stroke起始点
    self.shapeLayerBackground.strokeStart = 0;
    self.shapeLayerBackground.strokeEnd = 1;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayerBackground.path = circlePath.CGPath;
    
    //添加并显示
    [self.container.layer addSublayer:self.shapeLayerBackground];
    
#pragma mark 进度条
    //创建出CAShapeLayer
    self.shapeLayerProgress = [CAShapeLayer layer];
    self.shapeLayerProgress.frame = CGRectMake(0, 0, 100, 100);
    self.shapeLayerProgress.position = CGPointMake(self.container.frame.size.width *0.5, self.container.frame.size.height * 0.5);
    self.shapeLayerProgress.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayerProgress.lineWidth = 2.0f;
    self.shapeLayerProgress.strokeColor = [UIColor blueColor].CGColor;
    
    //设置stroke起始点
    self.shapeLayerProgress.strokeStart = 0;
    self.shapeLayerProgress.strokeEnd = 0;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayerProgress.path = circlePath2.CGPath;
    
    //添加并显示
    [self.container.layer addSublayer:self.shapeLayerProgress];
}
@end
