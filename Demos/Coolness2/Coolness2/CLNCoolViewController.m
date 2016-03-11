#import "CLNCoolViewController.h"
#import "CLNCoolView.h"

const CGFloat CLNAccessoryHeight = 66.0;

@interface CLNCoolViewController () <UITextFieldDelegate>

@property (readonly, nonatomic) CGRect coolRect;


@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end


@implementation CLNCoolViewController

- (CGRect)coolRect
{
    return CGRectMake(20.0, 30.0, 80.0, 30.0);
}


- (IBAction)addCoolView
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


- (void)XXXloadView
{
    [[NSBundle mainBundle] loadNibNamed:@"CoolStuff" owner:self options:nil];
}

- (void)XXXloadView2
{
    NSArray *topLevelObjs = [[NSBundle mainBundle] loadNibNamed:@"CoolStuff" owner:nil options:nil];
    self.view = topLevelObjs.firstObject;
}

@end
