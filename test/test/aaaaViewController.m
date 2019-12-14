//
//  aaaaViewController.m
//  test
//
//  Created by allsale on 2019/11/27.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "aaaaViewController.h"
typedef void(^runloopTask)(void);
@interface aaaaViewController ()

//存放任务的数组
@property (nonatomic, strong) NSMutableArray *TaskMarr;
//最大任务数     任务数据只保留最后停留在页面的任务
@property (nonatomic, assign) NSInteger maxTasksNumber;
@property(nonatomic, strong)UITableView *msgTableView;

@end

@implementation aaaaViewController
{
    CGFloat  ImageWidth;
    CGFloat  ImageHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //给当前runloop注册观察者
    [self addRunloopObserver];
      [self.view addSubview:self.msgTableView];
    ImageWidth = ImageHeight=  [UIScreen mainScreen].bounds.size.width/3;
    //给runloop一个事件源，让Runloop不断的运行执行代码块任务。
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runloopalive) userInfo:nil repeats:YES];
}
//如果方法里什么都不干，APP性能影响并不大。但cpu增加负担，
-(void)runloopalive{
   //什么都不干
}

-(NSMutableArray *)TaskMarr{
    
    if (!_TaskMarr) {
        
        _TaskMarr = [NSMutableArray array];
    }
    
    self.maxTasksNumber  =  15;
    
    return _TaskMarr;
}

#pragma mark  tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 999;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ImageHeight+20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString  *  cellId  =  @"runloopCellId";
    UITableViewCell  *  cell;
    if (!cell) {
        cell   =  [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }else{
        cell   =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    }
    __weak  aaaaViewController  *  weakSelf  = self;
    
    [self addTasks:^{
        [weakSelf addImage1ToCell:cell];
    }];
    
    [self addTasks:^{
        [weakSelf addImage2ToCell:cell];
    }];
    
    [self addTasks:^{
        [weakSelf addImage3ToCell:cell];
    }];
    
    return cell;

}


-(void)addImage1ToCell:(UITableViewCell*)cell{
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, ImageWidth, ImageHeight)];
    cellImageView.image = [UIImage imageNamed:@"timg-6.jpeg"];
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


//添加任务进数组保存
-(void)addTasks:(runloopTask)taskBlock{
    
    [self.TaskMarr addObject:taskBlock];
    //超过每次最多执行的任务数就移出当前数组
    if (self.TaskMarr.count > self.maxTasksNumber) {
        
        [self.TaskMarr removeObjectAtIndex:0];
    }
    
}

#pragma mark  设置runloop监听


//这里面都是C语言 -- 添加一个监听者
-(void)addRunloopObserver{
    //获取当前runloop
    CFRunLoopRef  currentRunloop =  CFRunLoopGetCurrent();
    //runloop观察者上下文， 为下面创建观察者准备，只有创建上下文才能在回调了拿到self对象，才能进行我们的逻辑操作. 这是一个结构体。
    /**
     typedef struct {
     CFIndex    version;
     void *    info;
     const void *(*retain)(const void *info);
     void    (*release)(const void *info);
     CFStringRef    (*copyDescription)(const void *info);
     } CFRunLoopObserverContext;
     **/
    CFRunLoopObserverContext  context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //创建Runloop观察者  kCFRunLoopBeforeWaiting  观察在等待状态之前  runloop有下面几种状态 看英文应该知道了。
    /*
     kCFRunLoopEntry = (1UL << 0),
     kCFRunLoopBeforeTimers = (1UL << 1),
     kCFRunLoopBeforeSources = (1UL << 2),
     kCFRunLoopBeforeWaiting = (1UL << 5),
     kCFRunLoopAfterWaiting = (1UL << 6),
     kCFRunLoopExit = (1UL << 7),
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     */
    static CFRunLoopObserverRef  obserberRef;
    obserberRef =CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0,&callback, &context);
    //给当前runloop添加观察者
    CFRunLoopAddObserver(currentRunloop, obserberRef, kCFRunLoopDefaultMode);
    //释放观察者
    CFRelease(obserberRef);
}

//观察回调
static void callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    aaaaViewController * vcSelf = (__bridge aaaaViewController *)(info);
    
    if (vcSelf.TaskMarr.count > 0) {
        //获取一次数组里面的任务并执行
        runloopTask  task  =  vcSelf.TaskMarr.firstObject;
        task();
        [vcSelf.TaskMarr removeObjectAtIndex:0];
    }else{
        return;
    }
  
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
