//
//  CustomView.m
//  test
//
//  Created by allsale on 2019/12/14.
//  Copyright © 2019 allsale. All rights reserved.
//

#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>
#define PI 3.14159265358979323846


@implementation CustomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
#pragma mark /*1.写文字*/
    //设置填充颜色
    CGContextSetRGBFillColor (context,255/255.0,175/255.0,40/255.0, 1.0);
    //增添字体属性
    NSDictionary *mDic = @{NSForegroundColorAttributeName:[UIColor cyanColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:13]};
    [@"画圆：" drawInRect:CGRectMake(10, 20, 80, 20) withAttributes:mDic];
    [@"画线及孤线：" drawInRect:CGRectMake(10, 80, 80, 20) withAttributes:mDic];
    [@"画矩形：" drawInRect:CGRectMake(10, 130, 80, 20) withAttributes:mDic];
    [@"画图形：" drawInRect:CGRectMake(10, 260, 80, 20) withAttributes:mDic];
    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 350, 80, 20) withAttributes:mDic];
    [@"图片:" drawInRect:CGRectMake(10, 400, 80, 20) withAttributes:mDic];
    [@"画虚线:" drawInRect:CGRectMake(10, 460, 80, 20) withAttributes:mDic];
    
#pragma mark     /*2.画圆*
    //边框圆1
    CGContextSetRGBStrokeColor(context,255/255.0,255/255.0,255/255.0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    /*
        void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise);
        参数：x,y为圆点坐标，radius半径，startAngle为开始的角度，endAngle为 结束的角度，clockwise 0为顺时针，1为逆时针。
     */
    CGContextAddArc(context, 70, 30, 15, 0, 2*PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    /*
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充（有边框颜色 和 填充颜色）
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    
    //填充圆2
    CGContextSetRGBFillColor (context,255/255.0,175/255.0,40/255.0, 1.0);
    CGContextAddArc(context, 130, 30, 20, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    //画有边框的实体圆3
    UIColor *aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    CGContextSetLineWidth(context, 3.0);//线的宽度
    CGContextAddArc(context, 200, 30, 30, 0, PI*2, 0);
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径加填充
    
#pragma mark     /*3.画线及孤线*/
    //画线1
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(120, 80);//坐标1
    aPoints[1] =CGPointMake(160, 100);//坐标2
    CGContextAddLines(context, aPoints, 2);//points[]坐标数组，count数组大小
    CGContextStrokePath(context);//直接写方法 不需要路径绘制参数
    
    //画线2
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextMoveToPoint(context, 170, 80);
    CGContextAddLineToPoint(context, 170, 100);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    //圆弧1（0到π逆时针的弧线）
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextAddArc(context, 200, 100, 15, 0, M_PI, 1);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    //画笑脸弧线2
    //左
    CGContextSetRGBStrokeColor(context, 255/255.0,255/255.0,255/255.0,1.0);//改变画笔颜色
    CGContextMoveToPoint(context, 240, 90);//开始点坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //参数：CGFloat x1 控制点的x坐标, CGFloat y1 控制点的y坐标,CGFloat x2 结束点的x坐标, CGFloat y2 结束点的y坐标, CGFloat radius 半径
    /*
    开始点的坐标为p1，控制点坐标为p2,结束点的的坐标为p3
        以p2为端点，发出两条射线，分别经过p1和p3，那么与两条射线相切的圆有无数个，若是给一个确定的半径，则可以确定一个圆。那么函数可以绘制两个切点之间的一段弧线
     1).若开始点和结束点正好在两个切点的位置，则绘制一条弧线。
     2).若开始点不是切点，则以开始点连一条直线到切点再绘制弧线。
     3).所以该函数需要确定好控制点 和 结束点的位置 及 半径的值
     4).上下文会自动以结束点为 current point。
     */
    CGContextAddArcToPoint(context, 248, 78, 256, 90, 10);
    CGContextStrokePath(context);//绘画路径
    
    //右
    CGContextMoveToPoint(context, 260, 90);
    CGContextAddArcToPoint(context, 268, 78, 276, 90, 10);
    CGContextStrokePath(context);
    
    //下
    CGContextMoveToPoint(context, 250, 100);
    CGContextAddArcToPoint(context, 258, 112, 266, 100, 10);
    CGContextStrokePath(context);
    
    
    //用CGContextMoveToPoint画一个圆角半径为10的矩形
    //左
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, 300, 80);
    CGContextAddArcToPoint(context, 300, 120, 310, 120, 10);
    CGContextStrokePath(context);
    //下
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, 310, 120);
    CGContextAddArcToPoint(context, 340, 120, 340, 110, 10);
    CGContextStrokePath(context);
    //右
    CGContextMoveToPoint(context, 340, 110);
    CGContextAddArcToPoint(context, 340, 70, 330, 70, 10);
    CGContextStrokePath(context);
    //上
    CGContextMoveToPoint(context, 330, 70);
    CGContextAddArcToPoint(context, 300, 70, 300, 80, 10);
    CGContextStrokePath(context);
    
    
#pragma mark     /*4.画矩形*/
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextStrokeRect(context,CGRectMake(80, 120, 30, 30));//画方框
    
    CGContextSetLineWidth(context, 2.0);//线的宽度
    aColor = [UIColor blueColor];//blue蓝色
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    aColor = [UIColor yellowColor];
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
    CGContextAddRect(context,CGRectMake(140, 120, 60, 30));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //渐变颜色矩形1
    //关于颜色参考http://blog.sina.com.cn/s/blog_6ec3c9ce01015v3c.html
    //http://blog.csdn.net/reylen/article/details/8622932
    //第一种填充方式，第一种方式必须导入类库quartcore并#import <QuartzCore/QuartzCore.h>，这个就不属于在context上画，而是将层插入到view层上面。那么这里就涉及到Quartz Core图层编程了。
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = CGRectMake(240, 120, 40, 40);
    gradient1.colors = [NSArray arrayWithObjects:
                        (id)[UIColor purpleColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor cyanColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        nil];
    //注意这几个数字在0到1之间单调递增。
    gradient1.locations = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.1],
                           [NSNumber numberWithFloat:0.3],
                           [NSNumber numberWithFloat:0.6],
                           [NSNumber numberWithFloat:1.0], nil];
    //向量方向 表示颜色层次方向(左上角为（0.0） 右下角为（1.1）)
    gradient1.startPoint = CGPointMake(1, 0);
    gradient1.endPoint = CGPointMake(1, 1);
    [self.layer insertSublayer:gradient1 atIndex:0];
    
    
    //渐变颜色矩形2
    //第二种填充方式
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    //参数：创建一个渐变的色值 1:颜色空间 2:渐变的色数组 3:位置数组,如果为NULL,则为平均渐变,否则颜色和位置一一对应 4:位置的个数
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
    //使用RGB模式的颜色空间（在Quartz 2D中凡是使用带有Create或者Copy关键字方法创建的对象，在使用后一定要使用对应的方法释放）
    CGColorSpaceRelease(rgb);
    
    
    //画线形成一个矩形
    //CGContextSaveGState 与 CGContextRestoreGState的作用
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改。这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     
     举个例子：现在画一个矩形框，边框的宽度为1，颜色为红色 save上下文，接着再画一个矩形框，宽度为2，颜色为蓝色。若现在又想画另一个宽度为1，颜色为红色的矩形，就不必改去写CGContextSetLineWidth（）和CGContextSetFillColorWithColor（）函数改变属性了，直接restore上下文，上下文就恢复到save之前的各项属性了，省去了重复更改上下文属性的代码编写了。
     */
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 320, 130);
    CGContextAddLineToPoint(context, 350, 130);
    CGContextAddLineToPoint(context, 350, 160);
    CGContextAddLineToPoint(context, 320, 160);
    //context裁剪路径,后续操作的路径
    CGContextClip(context);
    //CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
    //参数：gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (320,130) ,CGPointMake(350,130),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context); //恢复到之前的context
    
    
    //下面再看一个颜色渐变的圆
    /*CGContextDrawRadialGradient(CGContextRef  _Nullable c, CGGradientRef  _Nullable gradient, CGPoint startCenter, CGFloat startRadius, CGPoint endCenter, CGFloat endRadius, CGGradientDrawingOptions options)
     参数介绍：
     startCenter:起始点 startRadius:起始点的半径 endCenter:终止点 endRadius: 终止点的半径 GGradientDrawingOptions options: 扩展
     options： 当你的起点或者终点不在图形上下文的边缘内时，指定该如何处理。你可以使用你的开始或结束颜色来填充渐变以外的空间。此参数为以下值之一：KCGGradientDrawsAfterEndLocation扩展整个渐变到渐变的终点之后的所有点 KCGGradientDrawsBeforeStartLocation扩展整个渐变到渐变的起点之前的所有点。0不扩展该渐变。
     kCGGradientDrawsBeforeStartLocation
     kCGGradientDrawsAfterEndLocation
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(90, 200), 0, CGPointMake(90, 200), 20, 0);
    
    
    //渐变圆筒
    CGPoint ZHstart = CGPointMake(170, 200);//起始点
    CGPoint ZHend = CGPointMake(250, 200); //终结点
    CGContextDrawRadialGradient(context, gradient, ZHstart, 5, ZHend, 30, 0);//可以试试改变最后一个参数看看效果
    
    
#pragma mark     /*5.画扇形和椭圆*/
    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
    aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    
    //以10为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, 100, 290);
    CGContextAddArc(context, 100, 290, 30,  -60 * PI / 180, -120 * PI / 180, 1);
    CGContextClosePath(context);//闭合图形
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(130, 260, 40, 20));
    CGContextDrawPath(context, kCGPathFillStroke);
    
#pragma mark     /*6.画多边形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3]; //坐标点
    sPoints[0] = CGPointMake(180, 290);//坐标1
    sPoints[1] = CGPointMake(210, 290);//坐标2
    sPoints[2] = CGPointMake(240, 230);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    //不规则五边形
    CGPoint myPoints[5]; //坐标点
    myPoints[0] = CGPointMake(250, 300);//坐标1
    myPoints[1] = CGPointMake(280, 300);//坐标2
    myPoints[2] = CGPointMake(280, 240);//坐标3
    myPoints[3] = CGPointMake(250, 240);//坐标4
    myPoints[4] = CGPointMake(265, 270);//坐标5
    CGContextAddLines(context, myPoints, 5);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    //使用贝塞尔画五角星  （此处不详细讲贝塞尔的使用）
    UIBezierPath* starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(314.5, 241)];
    [starPath addLineToPoint: CGPointMake(326.31, 255.41)];
    [starPath addLineToPoint: CGPointMake(346.36, 260.35)];
    [starPath addLineToPoint: CGPointMake(333.62, 274.19)];
    [starPath addLineToPoint: CGPointMake(334.19, 291.65)];
    [starPath addLineToPoint: CGPointMake(314.5, 285.8)];
    [starPath addLineToPoint: CGPointMake(294.81, 291.65)];
    [starPath addLineToPoint: CGPointMake(295.38, 274.19)];
    [starPath addLineToPoint: CGPointMake(282.64, 260.35)];
    [starPath addLineToPoint: CGPointMake(302.69, 255.41)];
    [starPath closePath];//封闭
    [[UIColor cyanColor] setFill];
    [starPath fill];//填充颜色
    
#pragma mark     /*7.画贝塞尔曲线*/
    //二次曲线
    CGContextMoveToPoint(context, 120, 350);//设起点
    //设置贝塞尔曲线的控制点坐标和终点坐标
    CGContextAddQuadCurveToPoint(context,150, 305, 180, 350);
    CGContextStrokePath(context);
    
    
    //三次曲线函数（控制点1，控制点2，终点）
    CGContextMoveToPoint(context, 200, 350);//设起点
    CGContextAddCurveToPoint(context,250, 330, 220, 400, 280, 320);
    CGContextStrokePath(context);
    
    
#pragma mark     /*8.图片*/
    UIImage *image = [UIImage imageNamed:@"wo.jpg"];
    [image drawInRect:CGRectMake(60, 400, 60, 60)];
    
    CGContextDrawImage(context, CGRectMake(160, 400, 60, 60), image.CGImage);
    
    //[image drawAtPoint:CGPointMake(200, 430)];//保持图片原始大小
    
    //平铺图
    //CGContextDrawTiledImage(context, CGRectMake(160, 400, 30, 30), image.CGImage);
    
    
    
#pragma mark     /*9.画虚线*/
    
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    //lengths的值｛10,10｝表示先绘制10个点的长度，再跳过10个点的长度，如此反复
    CGFloat lengths[] = {10,10};
    //注意：如果对上下文进行了修改之后的所有连线的类型都默认为虚线啦！其他属性也一并如此。
    //设置线条起点和终点的样式为圆角
    CGContextSetLineCap(context, kCGLineCapRound);
    /*
     CGContextSetLineDash(CGContextRef  _Nullable c, CGFloat phase, const CGFloat * _Nullable lengths, size_t count);
     参数：
        CGFloat phase:绘制第一个虚线点时先减去该数值的长度。
        size_t count：必须和lengths数组长度匹配。
     */
    CGContextSetLineDash(context, 5, lengths,2);
    
    CGContextMoveToPoint(context, 0, 490);
    CGContextAddLineToPoint(context, self.frame.size.width-3,520);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 2.0);
    CGFloat lengths1 [] = {10,10,5};//第一个数为实线长，第二个为空隙长度，第三个实线长度，第四个空隙长度，三个数一直循环
    CGContextSetLineDash(context, 0, lengths1,3);
    CGContextMoveToPoint(context, 0, 530);
    CGContextAddLineToPoint(context, self.frame.size.width,530);
    CGContextStrokePath(context);
    
    
}
@end
