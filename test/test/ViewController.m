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


typedef void (^taskBlock) (void);


 

@interface ViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITextView * _textView ;
    CGFloat  ImageWidth;
    CGFloat  ImageHeight;
}
@property (nonatomic ,strong)UIView     *testView;
@property(nonatomic, strong)UIButton *button;
@property(nonatomic, strong)  UITextView *inputTextView;
@property(nonatomic, strong)NSMutableArray *taskArr;
//最大任务数     任务数据只保留最后停留在页面的任务
@property (nonatomic, assign) NSInteger maxTasksNumber;
@property(nonatomic, strong)NSMutableArray *dataList;
@property(nonatomic, strong)UITableView *msgTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self eat:^{
////        NSLog(@"----------");
//    }];
    ImageWidth = ImageHeight=  [UIScreen mainScreen].bounds.size.width/3;

//    self.run(1);
    self.view.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:self.button];
    
    
    [self addObserver];
    [self.view addSubview:self.msgTableView];
    /*
    self.inputTextView = [[UITextView alloc] init];
    self.inputTextView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.inputTextView];
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [self.inputTextView layoutIfNeeded];



     [[RACSignal merge:@[self.inputTextView.rac_textSignal, RACObserve(self.inputTextView, text)]] subscribeNext:^(NSString* text) { // do something here
         NSLog(@"----%@",text);
     }];
    */
    
//    [self gcdDemo8];
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

        //给runloop一个事件源，让Runloop不断的运行执行代码块任务。
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runloopalive) userInfo:nil repeats:YES];
}
//如果方法里什么都不干，APP性能影响并不大。但cpu增加负担，
-(void)runloopalive{
   //什么都不干
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
#pragma mark- 队列函数
- (void)gcdDemo1{
//    同步队列
    dispatch_queue_t queue = dispatch_queue_create("alex", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
//    异步函数
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
             NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");

    /**
     1 5 2 奔溃 奔溃在289行crash
    同步任务会阻塞当前线程，然后把 Block 中的任务放到指定的队列中执行，只有等到 Block 中的任务完成后才会让当前线程继续往下运行。
     因为异步函数 所以234 都会执行  但是同步任务导致4任务必须等三任务完成才可以执行 但是3任务会橘色当前线程到289行 4任务无法执行不许等到3任务完成才可以  所以死锁
     */
}
#pragma mark- a函数与队列关系
- (void)gcdDemo2{
    
    /**  任务 队列 函数 */
    dispatch_block_t block = ^{
        NSLog(@"Hellow World");
    };
    dispatch_queue_t queue = dispatch_queue_create("alex", NULL);
    dispatch_async(queue, block);
    
}
- (void)gcdDemo3{
    //并发队列
    dispatch_queue_t queue = dispatch_queue_create("alex", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_sync(queue, ^{
        NSLog(@"3");
    });
    NSLog(@"0");
    dispatch_async(queue, ^{
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        NSLog(@"5");
    });
    dispatch_async(queue, ^{
        NSLog(@"6");
    });
    
    /**
     123 是随机的  但是0肯定在第四位
     */
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
-(void)gcdDemo7{
        dispatch_queue_t queue = dispatch_queue_create("cc_queue",DISPATCH_QUEUE_CONCURRENT);

        dispatch_async(queue, ^{ // 􏴄􏲭􏱇􏱈1
        for (int i = 0; i < 2; ++i) {
        [NSThread sleepForTimeInterval:2]; NSLog(@"1---%@",[NSThread currentThread]);
        }
            
        });
    /*
        dispatch_barrier_async(queue, ^{
            NSLog(@"---");
        });
     
    */
    /**
     提交一个栅栏函数在执行中,它会等待栅栏函数执行完再去执行下一行代码（注意是下一行代码），同步栅栏函数是在主线程中执行的
     dispatch_barrier_sync(dispatch_queue_t queue, dispatch_block_t blcok);

     提交一个栅栏函数在异步执行中,它会立马返回开始执行下一行代码（不用等待任务执行完毕）
     dispatch_barrier_async(dispatch_queue_t queue, dispatch_block_t blcok);

     */
        dispatch_barrier_async(queue, ^{
            for (int i = 0; i < 2; ++i) {
              [NSThread sleepForTimeInterval:2]; NSLog(@"000---%@",[NSThread currentThread]);
              }
          });
       
        dispatch_async(queue, ^{ // 􏴄􏲭􏱇􏱈1
        for (int i = 0; i < 2; ++i) {
        [NSThread sleepForTimeInterval:2]; NSLog(@"2---%@",[NSThread currentThread]);
        } });
    /**
    //共同点
     1、都会等待在它前面插入队列的任务（1、2、3）先执行完
     2、都会等待他们自己的任务（barrier）执行完再执行后面的任务（4、5、6）（注意这里说的是任务不是下一行代码）

    //不同点 1、dispatch_barrier_sync需要等待自己的任务（barrier）结束之后，才会继续添加并执行写在barrier后面的任务（4、5、6），然后执行后面的任务
     2、dispatch_barrier_async将自己的任务（barrier）插入到queue之后，不会等待自己的任务结束，它会继续把后面的任务（4、5、6）插入到queue，然后执行任务。

     
     
     
     */
    /**
     􏱹􏰨􏳓􏲓􏰍􏰂􏱟dispatch_after􏳿􏳺􏱆􏱽􏰂􏰼􏲯􏲰􏳈􏴻􏲊􏲵􏳊􏰘􏳯􏱄􏱅􏰲􏰳􏱐􏳋􏰂􏰼􏲯􏲰􏳈􏴻􏲊 􏲵􏴃􏱇􏱈􏴄􏲭􏲮􏰧􏲏􏲐􏱋􏰥􏵶􏴮􏰈􏲘􏱐􏲄􏰛􏳈􏴻􏱆􏱽􏰂􏵷􏰸􏵸􏵹􏰍􏱐􏳕􏱼􏰨􏵋􏵺􏵻􏵼􏱄􏱅􏱇􏱈􏱐
     dispatch_after添加在某个队列中延迟执行block中的任务，是要等待该队列中的任务执行完才会执行block，也就是如果线程阻塞，延迟执行的时间就不确定了，可能并不是你设置的时长。
     
     一般延迟函数放在子线程中执行  因为主线程中一般会有一些耗时的操作
     */

}
-(void)gcdDemo8{
    /*
    NSArray *titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    dispatch_queue_t qeue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT  , 0);
    dispatch_apply(titleArr.count, qeue, ^(size_t index) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200 + index*30, 100, 20)];
             label.backgroundColor = [UIColor whiteColor];
             label.text = titleArr[index];
             label.font = [UIFont systemFontOfSize:18];
             [self.view addSubview:label];
    });
    */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
    NSLog(@"%zd---%@",index, [NSThread currentThread]); });
    NSLog(@"apply---end");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 999;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ImageHeight+20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    UITableViewCell  *  cell;
    if (!cell) {
        cell   =  [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
    }else{
        cell   =  [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier forIndexPath:indexPath];
    }
    @weakify(self);
    
    [self addTask:^{
        @strongify(self);
        [self addImage1ToCell:cell];
    }];
    
    [self addTask:^{
            @strongify(self);
        [self addImage2ToCell:cell];
    }];
    
    [self addTask:^{
            @strongify(self);
        [self addImage3ToCell:cell];
    }];
    
    return cell;
}
-(void)addImage1ToCell:(UITableViewCell*)cell{
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, ImageWidth, ImageHeight)];
    cellImageView.image = [UIImage imageNamed:@"timg-6.jpeg"];
    /*
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(cellImageView.bounds.size, NO, 0.0);
    
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:cellImageView.bounds cornerRadius:cellImageView.frame.size.width] addClip];
    
    [cellImageView drawRect:cellImageView.bounds];
    
    cellImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    */
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:cellImageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = cellImageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    
    cellImageView.layer.mask = maskLayer;
    [cell.contentView addSubview:cellImageView];
}

-(void)addImage2ToCell:(UITableViewCell*)cell{
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1*(ImageWidth+5), 5, ImageWidth, ImageHeight)];
    cellImageView.image = [UIImage imageNamed:@"timg-7.jpeg"];
    [cell.contentView addSubview:cellImageView];
}


-(void)addImage3ToCell:(UITableViewCell*)cell{
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2*(ImageWidth+5), 5, ImageWidth, ImageHeight)];
    cellImageView.image = [UIImage imageNamed:@"2012081210372.jpg"];
    [cell.contentView addSubview:cellImageView];
}

- (void)addObserver{
        __weak typeof(self) weakSelf = self;

    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAfterWaiting, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        kCFRunLoopAfterWaiting
        if (weakSelf.taskArr.count == 0) {
                   return;
               }
        taskBlock block = self.taskArr.firstObject;
        block();
        [weakSelf.taskArr removeObjectAtIndex:0];
        NSLog(@"----");
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
       CFRelease(observer);
}

- (void)addTask:(taskBlock)block{
    [self.taskArr addObject:block];
    //超过每次最多执行的任务数就移出当前数组
    if (self.taskArr.count > self.maxTasksNumber) {
        
        [self.taskArr removeObjectAtIndex:0];
    }
}
- (NSMutableArray *)taskArr
{
    if (!_taskArr) {
        _taskArr = [NSMutableArray array];
    }
     self.maxTasksNumber  =  20;
    return _taskArr ;
}
-(UITableView *)msgTableView
{
    if (!_msgTableView) {
        _msgTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _msgTableView.delegate = self;
        _msgTableView.dataSource = self;
        _msgTableView.estimatedRowHeight = 500;
        _msgTableView.sectionHeaderHeight = 0.001;
        _msgTableView.sectionFooterHeight = 0.001;
        _msgTableView.backgroundColor = UIColor.redColor;
        _msgTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    }
    return _msgTableView;
}
- (NSMutableArray *)dataList
{
    if (!_dataList) {
     
            _dataList = [NSMutableArray array];
        
    }
    return _dataList ;
    
}


     
@end
