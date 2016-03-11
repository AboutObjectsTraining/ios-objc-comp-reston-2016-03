#import <UIKit/UIKit.h>

@class Book;

@interface RELAddBookController : UITableViewController

@property (nonatomic, strong) void (^completion)(Book *book);

@end
