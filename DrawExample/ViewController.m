//
//  ViewController.m
//  DrawExample
//
//  Created by Francisco Salazar on 9/25/14.
//  Copyright (c) 2014 sleek-geek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    
    
    [super viewDidLoad];
    
    //settings hidden on view load
    _settingsView.hidden=YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    drawImage.image = [defaults objectForKey:@"drawImageKey"];
    drawImage=[[UIImageView alloc] initWithImage:nil];
    
    
    drawImage.frame=self.view.frame;
    
    [_drawingView addSubview:drawImage];
    
    
    //default colors and values:
     blueVal=0.5;
     redVal = 0.5;
     greenVal=0.5;
     lightnessVal=1.0;
     brushSizeVal = 2.0;
    
    //to load the same values to temp settings. 
    adjustLightness=lightnessVal;
    adjustRed=redVal;
    adjustGreen=greenVal;
    adjustBlue=blueVal;
    adjustSize=brushSizeVal ;
    
    //
    //the temp brush will have a diameter set to the brush size;
    
    _tempBrushView=[[UIView alloc]initWithFrame:CGRectMake(20, 20, brushSizeVal*5, brushSizeVal*5)];
    _tempBrushView.backgroundColor=[UIColor colorWithRed:1.0 green:greenVal blue:blueVal alpha:lightnessVal];
    
    _tempBrushView.layer.cornerRadius = brushSizeVal*2.5;
    [ _settingsView addSubview:_tempBrushView];
    
    //fade away the intro label
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch =[[event allTouches] anyObject];
    
    if ([touch tapCount]==2) {
    
        drawImage.image =nil;
        
        
    }
    
    location = [touch locationInView:touch.view];
    lastPoint = [touch locationInView:self.drawingView];
    lastPoint.y -= 0;
    
    [super touchesBegan:touches withEvent:event];
    
}
//for help see http://stackoverflow.com/questions/19108185/lag-while-drawing-in-ios7

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch =[touches anyObject];
    currentPoint = [touch locationInView:self.drawingView]; //get the location of the touch and turn into point
    UIGraphicsBeginImageContext(self.view.frame.size); //drawing context encopasses whole screen
    [drawImage.image drawInRect:self.view.frame];
   CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushSizeVal); // set width and color:
   CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), redVal, greenVal, blueVal, lightnessVal);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    
    //here it differs:
    [drawImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
   // drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    [drawImage performSelectorInBackground:@selector(setImage:) withObject:UIGraphicsGetImageFromCurrentImageContext()]; //avoid delay in iOS7 when drawing
    
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
    [self.drawingView addSubview:drawImage]; //plop it down on the VC view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showSettings:(id)sender {
    
    _settingsView.hidden=NO;
    
}

- (IBAction)changeBrushSize:(id)sender {
    
    adjustSize=_changeBrushSizeSlider.value;
    
    [self updateTempValues];
}

- (IBAction)changeRed:(id)sender {
    
    adjustRed =_changeRedSlider.value;
    [self updateTempValues];
    
    
    
}

- (IBAction)changeLightness:(id)sender {
    
    adjustLightness= _changeLightnessSlider.value;
    [self updateTempValues];
}

- (IBAction)changeGreen:(id)sender {
    
    adjustGreen =_changeGreenSlider.value;
    [self updateTempValues];
}

- (IBAction)changeBlue:(id)sender {
    
    adjustBlue =_changeBlueSlider.value;
    [self updateTempValues];
}

- (IBAction)saveSettings:(id)sender {
    
    brushSizeVal=adjustSize;
    redVal=adjustRed;
    blueVal=adjustBlue;
    greenVal=adjustGreen;
    lightnessVal=adjustLightness;
    
    _settingsView.hidden=YES;
    
    
}

- (IBAction)cancelSettings:(id)sender {
    
    //return to previous values and discard temp adjustments
    _tempBrushView.backgroundColor=[UIColor colorWithRed:redVal green:greenVal blue:blueVal alpha:lightnessVal];

    _tempBrushView.frame=CGRectMake(20, 20, brushSizeVal*5, brushSizeVal*5 );
    _tempBrushView.layer.cornerRadius=brushSizeVal*2.5;
    
    _settingsView.hidden=YES;
}

- (IBAction)clearAll:(id)sender {
    
    
    NSLog(@"Clear all!");
    
    //go through all drawingView subviews and remove them:
    
    for (UIImageView*image in _drawingView.subviews) {
        
        
        image.image=nil;
        
        [image removeFromSuperview];
        
        
    }
    
    
    
    
}
-(void)updateTempValues{
    
    _tempBrushView.backgroundColor=[UIColor colorWithRed:adjustRed green:adjustGreen blue:adjustBlue alpha:adjustLightness];
    //also set the brush size:
    _tempBrushView.frame=CGRectMake(20, 20, adjustSize*5, adjustSize*5 );
    _tempBrushView.layer.cornerRadius=adjustSize*2.5;
    NSLog(@"Updating Temp Values >>> Red: %f, Green: %f, Blue %f, Alpha %f ", adjustRed, adjustGreen, adjustBlue, adjustLightness);
    
}

@end
