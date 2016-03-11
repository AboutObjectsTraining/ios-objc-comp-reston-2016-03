#import "CLNCoolViewController.h"
#import "CLNCoolView.h"

const CGFloat CLNAccessoryHeight = 66.0;

@interface CLNCoolViewController () <UITextFieldDelegate>

@property (readonly, nonatomic) CGRect coolRect;

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIView *contentView;

@end


@implementation CLNCoolViewController

- (CGRect)coolRect
{
    return CGRectMake(20.0, 30.0, 80.0, 30.0);
}

- (void)addCoolView
{
    NSLog(@"In %s, text is %@\n", __func__, self.textField.text);
    
    CLNCoolView *newCoolView = [[CLNCoolView alloc] init];
    newCoolView.text = self.textField.text;
    [newCoolView sizeToFit];
    
    [self.contentView addSubview:newCoolView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)loadView
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    self.view = [[UIView alloc] initWithFrame:screenRect];
    
    UIView *accessoryView = [[UIView alloc] initWithFrame:
                             CGRectMake(screenRect.origin.x, screenRect.origin.y,
                                        screenRect.size.width, CLNAccessoryHeight)];
    UIView *contentView = [[UIView alloc] initWithFrame:
                           CGRectMake(screenRect.origin.x, CLNAccessoryHeight,
                                      screenRect.size.width, screenRect.size.height - CLNAccessoryHeight)];
    
    [self.view addSubview:accessoryView];
    [self.view addSubview:contentView];
    
    contentView.clipsToBounds = YES;
    
    self.contentView = contentView;
    
    
    // Controls
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8.0, 28.0, 250.0, 30.0)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Enter some text";
    
    self.textField = textField;
    
    textField.delegate = self;
    
    [accessoryView addSubview:textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [accessoryView addSubview:button];
    
    [button setTitle:@"Add" forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectOffset(button.frame, 280.0, 28.0);
    
    [button addTarget:self action:@selector(addCoolView) forControlEvents:UIControlEventTouchUpInside];
    
    // Cool View
    
    CLNCoolView *subview1 = [[CLNCoolView alloc] initWithFrame:self.coolRect];
    CLNCoolView *subview2 = [[CLNCoolView alloc] initWithFrame:CGRectOffset(self.coolRect, 30.0, 50.0)];
    
    subview1.text = @"CoolViews are Cool!";
    subview2.text = @"App Store here we come.";
    
    [subview1 sizeToFit];
    [subview2 sizeToFit];
    
    [contentView addSubview:subview1];
    [contentView addSubview:subview2];
    
    subview1.backgroundColor = [UIColor purpleColor];
    subview2.backgroundColor = [UIColor orangeColor];    
    self.view.backgroundColor = [UIColor brownColor];
    accessoryView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
}

@end
