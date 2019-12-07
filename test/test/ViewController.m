//
//  ViewController.m
//  test
//
//  Created by allsale on 2019/7/25.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+ButtonExpand.h"
#import "UILabel+Chained.h"
#import "aaaaViewController.h"
#import "ReactiveObjC.h"
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
@property(nonatomic, strong)UIButton *button;
@property(nonatomic, strong)  UILabel *inputTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self eat:^{
//        NSLog(@"----------");
    }];
//    self.run(1);
    self.view.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:self.button];
    
    self.inputTextView = [[UILabel alloc] init];
    self.inputTextView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.inputTextView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [self.inputTextView layoutIfNeeded];
    if (@available(iOS 11.0, *)) {
             self.inputTextView.layer.cornerRadius = 6;
             self.inputTextView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner; // 左上圆角
         }else {
             CGFloat radius = 6; // 圆角大小
             UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
             UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.inputView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
             CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
             maskLayer.frame = self.inputView.bounds;
             maskLayer.path = path.CGPath;
             self.inputTextView.layer.mask = maskLayer;
         }
    
    
            self.inputTextView.layer.shadowColor = [UIColor grayColor].CGColor;
      //        self.layer.shadowOffset = CGSizeMake(3, 3);//有偏移量的情况,默认向右向下有阴影
              self.inputTextView.layer.shadowOffset = CGSizeZero; //设置偏移量为0,四周都有阴影
              self.inputTextView.layer.shadowRadius = 3.0f;//阴影半径，默认3
              self.inputTextView.layer.shadowOpacity = 0.8f;//阴影透明度，默认0
              self.inputTextView.layer.masksToBounds = NO;
              self.inputTextView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.inputView.bounds cornerRadius:self.inputTextView.layer.cornerRadius].CGPath;


//     [[RACSignal merge:@[self.inputTextView.rac_textSignal, RACObserve(self.inputTextView, text)]] subscribeNext:^(NSString* text) { // do something here
//
//     }];
    
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
/*
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

    
    UILabel * label = UILabel
        .createLabel
        .frameEqualTo(CGRectMake(100, 300, 200, 100))
        .textEqualTo(@"链式lable")
        .textColorEqualTo([UIColor grayColor])
        .bgColorEqualTo([UIColor redColor]);
    [self.view addSubview:label];
*/

}
-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100)];
        _button.backgroundColor = [UIColor yellowColor];
        [_button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"UI" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _button;
}
 
- (void)btnClicked {
    [NSThread detachNewThreadSelector:@selector(uiRefreashTest) toTarget:self withObject:nil];
}
 
- (void)uiRefreashTest {
    NSLog(@"当前线程:%@", [NSThread currentThread]);
    NSLog(@"主线程:%@", [NSThread mainThread]);
     
    //在子线程刷新该按钮的标题名字为子线程信息
    NSString *subStr = [NSString stringWithFormat:@"子线程:%@", [NSThread currentThread]];
    NSString *mainStr = [NSString stringWithFormat:@"主线程:%@", [NSThread mainThread]];
    [_button setTitle:subStr forState:UIControlStateNormal];
    CGRect labelTitleSize = [subStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    _button.frame = CGRectMake(0, 100, labelTitleSize.size.width+10, labelTitleSize.size.height+10);
     
    //在子线程新建一个按钮,标题名字为主线程信息
    UIButton *newBtn = [[UIButton alloc] init];
    newBtn.backgroundColor = [UIColor greenColor];
    newBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    newBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [newBtn setTitle:mainStr forState:UIControlStateNormal];
    [newBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    CGRect labelTitleSize01 = [mainStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
     
    newBtn.frame = CGRectMake(0, 250, labelTitleSize01.size.width+10, labelTitleSize01.size.height+10);
    [self.view addSubview:newBtn];
     
    //在这个子线程延迟5秒钟
    sleep(5);
    /*
     结果分析：
     为什么一定要在主线程刷新UI？
     安全+效率：因为UIKit框架不是线程安全的框架，当在多个线程进行UI操作，有可能出现资源抢夺，导致问题。

     其实：在子线程是不能更新UI的， 看到能更新的结果只是个假象。因为：在子线程代码完成之后，回到主线程，然后执行了子线程的更新UI的代码，由于这个时间很短，所以看起来是能够在子线程刷新UI的。想验证的话也很简单，看下面demo：点击按钮，会开启一个子线程，然后在子线程中刷新该按钮的标题，再新建一个按钮，最后一行代码是延迟5秒。
     从图中点击按钮后，虽然任务是在同一个子线程执行，但是并没有按顺序执行，而是首先立即执行NSLog日志输出，但是接下来并没有执行刷新按钮标题，和新建按钮的代码，而是优先执行sleep(5)延迟代码，然后才执行的刷新和新建控件的代码
     
     */
}
- (void)eat:(void (^)(void))block
{
    block();
}
- (void)refresh{
    NSLog(@"------------------------------");
}
- (void)clickedasda{
  aaaaViewController *vc  =[[aaaaViewController alloc] init];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:vc  animated:YES completion:nil];//从当前界面到nextVC
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SendGoodsSuccess" object:nil];
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
    /*
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = @(- M_PI/180*4);
    NSValue *value2 = @(M_PI/180*4);;
    NSValue *value3 = @(- M_PI/180*4);
    animation.values = @[value1, value2, value3];
    animation.repeatCount = MAXFLOAT;
    [self.testView.layer addAnimation:animation forKey:@"shakeAnimation"];
    */
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
