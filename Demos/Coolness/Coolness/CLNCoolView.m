#import "CLNCoolView.h"

const CGPoint CLNDefaultTextInset = { 8.0, 8.0 };


@implementation CLNCoolView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    [self configureLayer];
    [self configureGestureRecognizers];
    
    return self;
}

- (void)configureGestureRecognizers
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(bounce)];
    recognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:recognizer];
}

- (void)configureLayer
{
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
}

+ (NSDictionary *)defaultTextAttributes
{
    return @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
              NSForegroundColorAttributeName: [UIColor whiteColor] };
}


- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    self.alpha = highlighted ? 0.5 : 1.0;
}


#pragma mark - Resizing

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize newSize = [self.text sizeWithAttributes:[self.class defaultTextAttributes]];
    newSize.width  += CLNDefaultTextInset.x * 2;
    newSize.height += CLNDefaultTextInset.y * 2;
    return newSize;
}


#pragma mark - View Rendering

- (void)drawRect:(CGRect)rect
{
    [self.text drawAtPoint:CLNDefaultTextInset withAttributes:[self.class defaultTextAttributes]];
}


#pragma mark - Animation

- (void)bounce
{
    [self animateBounceWithSize:CGSizeMake(120.0, 240.0)];
}

- (void)animateEndOfBounceWithSize:(CGSize)size
{
    [UIView animateWithDuration:1.0 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.frame = CGRectOffset(self.frame, -size.width, -size.height);
    }];
}

- (void)configureBounceWithSize:(CGSize)size
{
    [UIView setAnimationRepeatCount:3.5];
    [UIView setAnimationRepeatAutoreverses:YES];
    self.frame = CGRectOffset(self.frame, size.width, size.height);
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)animateBounceWithSize:(CGSize)size
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         [self configureBounceWithSize:size];
                     }
                     completion:^(BOOL done) {
                         [self animateEndOfBounceWithSize:size];
                     }];
}


#pragma mark - UIResponder Methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    [touch.view.superview bringSubviewToFront:touch.view];
    
    self.highlighted = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currLocation = [touch locationInView:touch.view];
    CGPoint prevLocation = [touch previousLocationInView:touch.view];
    
    CGPoint newLocation = touch.view.center;
    newLocation.x += currLocation.x - prevLocation.x;
    newLocation.y += currLocation.y - prevLocation.y;
    
    touch.view.center = newLocation;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}


@end
