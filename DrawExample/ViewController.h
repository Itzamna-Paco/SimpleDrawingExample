//
//  ViewController.h
//  DrawExample
//
//  Created by Francisco Salazar on 9/25/14.
//  Copyright (c) 2014 sleek-geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    CGPoint lastPoint;
    CGPoint moveBackTo;
    CGPoint currentPoint;
    CGPoint location;
    BOOL mouseSwiped;
    UIImageView *drawImage;
    
    //to hold color values:
    
    float blueVal;
    float redVal;
    float greenVal;
    
    //lightness
    float lightnessVal;
    
    //brush size
    float brushSizeVal;
    
    //and temp values:
    float adjustRed;
    float adjustBlue;
    float adjustGreen;
    float adjustLightness;
    float adjustSize;
    
  
    
}
@property (strong, nonatomic) IBOutlet UIView *drawingView;
@property (strong, nonatomic)   UIView*tempBrushView;

@property (strong, nonatomic) IBOutlet UIView *settingsView;
@property (strong, nonatomic) IBOutlet UISlider *changeBrushSizeSlider;
@property (strong, nonatomic) IBOutlet UISlider *changeLightnessSlider;
@property (strong, nonatomic) IBOutlet UISlider *changeRedSlider;
@property (strong, nonatomic) IBOutlet UISlider *changeGreenSlider;
@property (strong, nonatomic) IBOutlet UISlider *changeBlueSlider;
@property (strong, nonatomic) IBOutlet UILabel *startDrawingLabel;


- (IBAction)showSettings:(id)sender;

- (IBAction)changeBrushSize:(id)sender;
- (IBAction)changeRed:(id)sender;
- (IBAction)changeLightness:(id)sender;
- (IBAction)changeGreen:(id)sender;
- (IBAction)changeBlue:(id)sender;

- (IBAction)saveSettings:(id)sender;
- (IBAction)cancelSettings:(id)sender;


- (IBAction)clearAll:(id)sender;
    
@end
