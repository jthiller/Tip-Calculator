//
//  TipViewController.m
//  Tip Calculator
//
//  Created by Joey Hiller on 5/27/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UILabel *billTextFieldLabel;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIStepper *splitAdd;
@property (weak, nonatomic) IBOutlet UILabel *splitCount;
@property (weak, nonatomic) IBOutlet UILabel *splitTotalLabel;


- (IBAction)onTap:(id)sender;
- (void)updateValues;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

-(void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    int peopleCount = [self.splitAdd value];

    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues [self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    float splitAmount = totalAmount / peopleCount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.splitCount.text = [NSString stringWithFormat:@"%i people",peopleCount];
    self.splitTotalLabel.text = [NSString stringWithFormat:@"$%0.2f", splitAmount];
}

@end
