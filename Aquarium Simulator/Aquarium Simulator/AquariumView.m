//
//  AquariumView.m
//  Aquarium Simulator
//
//  Created by Adam G Murphy on 2013-03-31.
//  Copyright (c) 2013 Adam G Murphy. All rights reserved.
//

#import "AquariumView.h"

@interface UIView()

@end


@implementation AquariumView

- (void) drawRect: (CGRect) rect {
    self.opaque = NO;
//    [self setBackgroundColor: [UIColor redColor]];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	
	CGColorRef finColor = [[UIColor greenColor] CGColor];
	CGColorRef bodyColor = [[UIColor blueColor] CGColor];
	CGColorRef outerEyeColor = [[UIColor whiteColor] CGColor];
	CGColorRef innerEyeColor = [[UIColor blackColor] CGColor];
	
	double size = 1.0;
	double facing = -1.0;
	double offset = 0.0;
	double eyeOffset = 0.0;
	
	double xPos = 50.0;
	double yPos = 50.0;
	
	if (facing == -1.0) {
		offset = 60.0 * size;
	}
	
	
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, facing * 20.0 * size + offset + xPos, 25.0 * size + yPos);
	CGContextAddLineToPoint(context, facing * 60.0 * size + offset + xPos, 10.0 * size + yPos);
	CGContextAddLineToPoint(context, facing * 60.0 * size + offset + xPos, 40.0 * size + yPos);
	CGContextClosePath(context);
	CGContextSetFillColorWithColor(context, finColor);
    CGContextFillPath(context);
	
	
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, facing * 0.0 * size + offset + xPos, 25.0 * size + yPos);
	CGContextAddLineToPoint(context, facing * 50 * size + offset + xPos, 0.0 * size + yPos);
	CGContextAddLineToPoint(context, facing * 50.0 * size + offset + xPos, 50.0 * size + yPos);
	CGContextClosePath(context);
	CGContextSetFillColorWithColor(context, bodyColor);
    CGContextFillPath(context);
    
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, facing * 30.0 * size + offset + xPos, 25.0 * size + yPos);
	CGContextAddLineToPoint(context, facing * 30.0 * size + offset + xPos, 35.0 * size + yPos);
	CGContextAddLineToPoint(context, facing * 40.0 * size + offset + xPos, 35.0 * size + yPos);
	CGContextAddLineToPoint(context, facing * 35.0 * size + offset + xPos, 25.0 * size + yPos);
	CGContextClosePath(context);
	CGContextSetFillColorWithColor(context, finColor);
    CGContextFillPath(context);
	
	if (facing == -1.0) {
		eyeOffset = - 7.5 * size;
	}
	
	CGRect rectangle = CGRectMake(facing * 15.0 * size + offset + eyeOffset + xPos, 20.0 * size + yPos, 7.5 * size, 7.5 * size);
	CGContextAddEllipseInRect(context, rectangle);
	CGContextSetFillColorWithColor(context, outerEyeColor);
    CGContextFillPath(context);
	
	if (facing == -1.0) {
		eyeOffset = - 5.0 * size;
	}
	
	rectangle = CGRectMake(facing * 16.25 * size + offset + eyeOffset + xPos, 21.25 * size + yPos, 5.0 * size, 5.0 * size);
	CGContextAddEllipseInRect(context, rectangle);
	CGContextSetFillColorWithColor(context, innerEyeColor);
    CGContextFillPath(context);
}


@end
