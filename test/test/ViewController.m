//
//  ViewController.m
//  test
//
//  Created by allsale on 2019/7/25.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+ButtonExpand.h"
#import <Masonry/Masonry.h>
#import "Person.h"
#import <objc/runtime.h>
#import "UIImage+sysytermImage.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIImpactFeedbackGenerator.h>
#import "ResetSizeImage.h"
#import "UIImage+Palette.h"
#import "PaletteColorModel.h"
#import "Palette.h"
#define typeDict @{@"0": @"Id card"}
#define APP_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//app详情地址
#define ITUNES_HOME_URL    @"https://itunes.apple.com/us/app/id1477144231?ls=1&mt=8"

//app更新的时候用的地址
#define ITUNES_UPDATE_URL  @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/search"
#import "NSArray+ALEXArray.h"


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITextViewDelegate>{
    UITextView * _textView ;
}
@property (nonatomic ,strong)UIView     *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = [UIColor whiteColor];
    /*
    [Person run];
    [Person eat];

    
    #pragma mark - 案例1：方法简单的交换
    // 获取两个类的类方法
    Method m1 = class_getClassMethod([Person class], @selector(run));
    Method m2 = class_getClassMethod([Person class], @selector(eat));
    // 开始交换方法实现
    method_exchangeImplementations(m1, m2);
    // 交换后，先打印学习，再打印跑！
    [Person run];
    [Person eat];
   
#pragma mark - 案例2：拦截系统方法
    UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    ima.image = [UIImage imageNamed:@"1234"];
    [self.view addSubview:ima];
    
    
#pragma mark - 案例3：在分类中设置属性，给任何一个对象设置属性
    ima.image.alexName = @"安静的斯卡迪";
    
#pragma mark - 案例4:   获得一个类的所有成员变量

    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([Person class], &outCount);
    
    // 遍历所有成员变量
    for (int i = 0; i < outCount; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"成员变量名：%s 成员变量类型：%s",name,type);
    }
    // 注意释放内存！
    free(ivars);
    
    */
#pragma mark - 案例5:    利用runtime 获取所有属性来重写归档解档方法

    UIView *labelView = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    labelView.backgroundColor = UIColor .magentaColor;
    self.testView = labelView ;
    [self.view addSubview:labelView];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 300, 80, 40);
    btn.backgroundColor = UIColor .whiteColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];


}
- (void)btnClick:(UIButton*)btn{
    /*
     位置动画
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
     animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
     animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 500)];
     animation.duration = 1.0f;
     [self.testView.layer addAnimation:animation forKey:@"positionAnimation"];
     */
    /*
   透明度动画
    CABasicAdaxnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(1.0);
    animation.toValue = @(.3);
    animation.duration = 1.0 ;
    [self.testView.layer addAnimation:animation forKey:@"opacityAnimation"];
    */
    /*
       缩放动画
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
     animation.fromValue = @(2.0);
     animation.toValue = @(0.5);
     animation.duration = 2.0f;
     [self.testView.layer addAnimation:animation forKey:@"scaleAnimation"];
     */
    
    /*
     旋转
      // （指定Z轴的话，就和UIView的动画一样绕中心旋转）
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
     animation.toValue = @(M_PI * 2);
     animation.duration = 1.0f;
     //     animation.beginTime = CACurrentMediaTime() + 2; // 2秒后执行
     animation.timingFunction =
     [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];  // 动画先加速后减速
     [self.testView.layer addAnimation:animation forKey:@"rotateAnimation"];
     
     */
     /*
      关键帧动画
      路径
      CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
      UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) radius:60.0f startAngle:0.0f endAngle:M_PI * 2 clockwise:YES];
      animation.duration = 2.0f;
      animation.path = path.CGPath;
      [self.testView.layer addAnimation:animation forKey:@"pathAnimation"];
      */
    /*
         关键帧动画
         抖动
     */
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = @(- M_PI/180*4);
    NSValue *value2 = @(M_PI/180*4);;
    NSValue *value3 = @(- M_PI/180*4);
    animation.values = @[value1, value2, value3];
    animation.repeatCount = MAXFLOAT;
    [self.testView.layer addAnimation:animation forKey:@"shakeAnimation"];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//   AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);//默认震动效果
 
}
- (void)actionTouched{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);//默认震动效果
}
- (void)gcdDemo4{
    dispatch_queue_t q = dispatch_get_global_queue(0,0);
    
    //循环添加10个任务，进入全局队列中
    for(int i = 0;i < 10;i++)
    {
        dispatch_async(q,^{
            NSLog(@"%@,%d",[NSThread currentThread],i);
        });
    }
    
    NSLog(@"come here");
}

-(void)gcdDemo5{
    
    //创建一个异步队列
    dispatch_queue_t q = dispatch_queue_create("cc_queue2",DISPATCH_QUEUE_CONCURRENT);
    //1.用户登录
    dispatch_sync(q,^{
        NSLog(@"用户登录 %@",[NSThread currentThread]);
    });
    
    //2.支付
    dispatch_async(q,^{
        NSLog(@"支付 %@",[NSThread currentThread]);
    });
    
    //3.下载
    dispatch_async(q,^{
        NSLog(@"下载  %@",[NSThread currentThread]);
    });
}
-(void)gcdDemo6
{
    //队列
    dispatch_queue_t q = dispatch_queue_create("cc_queue",DISPATCH_QUEUE_CONCURRENT);
    
    //任务，在这个任务中添加了3个任务
    void (^task)() = ^{
        
        //1.用户登录
        dispatch_async(q,^{
            NSLog(@"用户登录 %@",[NSThread currentThread]);
        });
        
        //2.支付
        dispatch_async(q,^{
            NSLog(@"支付 %@",[NSThread currentThread]);
        });
        
        //3.下载
        dispatch_async(q,^{
            NSLog(@"下载  %@",[NSThread currentThread]);
        });
    };
    
    for(int i = 0; i < 10; i++)
    {
        NSLog(@"%d %@",i,[NSThread currentThread]);
    }
    
    //将task 丢到异步执行中去。
    dispatch_async(q,task);
    NSLog(@"come here");
}
@end
