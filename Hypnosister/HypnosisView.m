//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Fernando Castor on 07/01/15.
//  Copyright (c) 2015 Fernando Castor. All rights reserved.
//

#import "HypnosisView.h"
@interface HypnosisView ()

@property (nonatomic) NSInteger lineWidth;

@end

@implementation HypnosisView

NSMutableArray *circles;
bool firstTime = true;
NSMutableArray *circleColors;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [self drawCircles];
    if (firstTime) {
        firstTime = false;
    }
}

- (instancetype)initWithFrame: (CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    circles = [NSMutableArray array];
    circleColors = [NSMutableArray array];
    self.lineWidth = 10;
    
    return self;
}

- (UIColor *)randomColor {
    float red = ((float)(arc4random() %100)) /100;
    float green = ((float)(arc4random() %100)) /100;
    float blue = ((float)(arc4random() %100)) /100;
    UIColor *randColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return randColor;
}

- (void)drawCircles {
    CGPoint center;
    center.x = self.bounds.origin.x + self.bounds.size.width / 2;
    center.y = self.bounds.origin.y + self.bounds.size.height / 2;
    float radius = (MIN(self.bounds.size.width, self.bounds.size.height))/10;
    NSLog(@"%f", radius);
    //    We could have used the following as a starting point. The problem in this
    //    case is that we won't be drawing a circle because we'll
    //    be considering both dimensions of the bounds CGRect, instead
    //    of just the smaller one.
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    float halfDiagonal = sqrtf(self.bounds.size.height*self.bounds.size.height + self.bounds.size.width*self.bounds.size.width) / 2;
    // The line above could be simply
    // float halfDiagonal = hypot(self.bounds.size.width, self.bounds.size.height) /2;
  
    UIImage *image = [UIImage imageNamed:@"mrmr.png"];
    [image drawInRect:self.bounds];
    
    int index = 0;
    while (radius < halfDiagonal) {
        UIBezierPath *path =[[UIBezierPath alloc] init];
        path.lineWidth = self.lineWidth;
        [path addArcWithCenter: center
                        radius:radius
                    startAngle: 0.0
                      endAngle: M_PI * 2
                     clockwise: YES];
        if(firstTime) {
          [circles insertObject:path atIndex:index];
          [circleColors insertObject:[UIColor lightGrayColor] atIndex:index];
        }
        [[circleColors objectAtIndex:index] setStroke];
        index++;
        [path stroke];
        path = nil;
        radius = radius + 20;
        // The following line is necessary for us to separate the points. Otherwise, they will look
        // like a group of concentric points drawn withouth the lifting the pencil from the paper,
        // with a straight line conecting the various circles.
//        [path moveToPoint: CGPointMake(center.x + radius, center.y)];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"A touch event has just occurred.");

    UITouch *touch = [touches anyObject];
    CGPoint coords = [touch locationInView:self];
    NSInteger toBeRepainted = [self selectCircleToRepaint: coords];
    
//    int toBeRepainted = arc4random() % numCircles;
    if (toBeRepainted != -1) {
        UIColor *newColor = [self randomColor];
        [circleColors replaceObjectAtIndex: toBeRepainted withObject:newColor];
    }

    [self setNeedsDisplay];
}

- (NSInteger)selectCircleToRepaint: (CGPoint) coords {
    NSInteger circle = -1;
    int centerX = 0;
    int centerY = 0;
    // Avoids recalculating the center unnecessarily.
    if(circles.count > 0) {
        UIBezierPath *path = [circles objectAtIndex:0];
        CGRect boundingBox = [path bounds];
        centerX = boundingBox.origin.x + boundingBox.size.width/2;
        centerY = boundingBox.origin.y + boundingBox.size.height/2;
    }
    for (int i = 0; i < circles.count; i++) {
        UIBezierPath *path = [circles objectAtIndex:i];
        CGRect boundingBox = [path bounds];
        // We'll use the bounding box for the path to obtain the center
        // and the radius of the circle, in order to check whether
        // the touched point is contained within it.
        float radius = (boundingBox.size.width + self.lineWidth)/2;
        float dist = hypotf(coords.x - centerX, coords.y - centerY);
        if (i==1){
            NSLog(@"Radius for circle: %f", radius);
            NSLog(@"Center: %d, %d", centerX, centerY);
            NSLog(@"Clicked at: %f, %f", coords.x, coords.y);
            NSLog(@"From center to click: %f", dist);
            NSLog(@"Coords: %f, %f", centerX + boundingBox.size.width/2, centerY + boundingBox.size.height/2);
        }
        if (dist <= radius && (radius - self.lineWidth) <= dist) {
            return i;
        }
    }
    return circle;
}

- (void)setCircleColor:(UIColor *)circleColor {
//    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
