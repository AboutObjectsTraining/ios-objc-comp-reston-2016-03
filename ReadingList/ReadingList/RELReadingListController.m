#import "RELReadingListController.h"
#import "RELViewBookController.h"
#import "RELAddBookController.h"

#import "ReadingListStore.h"
#import "ReadingList.h"
#import "Book.h"
#import "Author.h"

@interface RELReadingListController ()

@property (nonatomic, strong) ReadingListStore *store;
@property (nonatomic, strong) NSMutableArray *books;

@end


@implementation RELReadingListController

- (void)saveReadingList
{
    ReadingList *newReadingList = [[ReadingList alloc] init];
    newReadingList.title = self.title;
    newReadingList.books = self.books;
    [self.store saveReadingList:newReadingList];
}

#pragma mark - Unwind Segues

- (IBAction)doneEditingBook:(UIStoryboardSegue *)segue
{
    [self.tableView reloadData];
    [self saveReadingList];
}

- (IBAction)doneAddingBook:(UIStoryboardSegue *)segue
{
    [self.tableView reloadData];
    [self saveReadingList];
}

- (IBAction)cancelAddingBook:(UIStoryboardSegue *)segue
{
    
}


#pragma mark - UIViewController

- (void)configureStore
{
    self.store = [ReadingListStore storeWithName:@"BooksAndAuthors"];
    ReadingList *readingList = [self.store fetchedReadingList];
    self.title = readingList.title;
    self.books = [readingList.books mutableCopy];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureStore];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier hasPrefix:@"View"]) {
        RELViewBookController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        controller.book = self.books[indexPath.row];
    }
    else {
        UINavigationController *navController = segue.destinationViewController;
        RELAddBookController *addController = navController.childViewControllers.firstObject;
        
        addController.completion = ^(Book *book) {
            [self.books insertObject:book atIndex:0];
            [self.tableView reloadData];
            [self saveReadingList];
        };
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookSummary"];
    
    Book *book = self.books[indexPath.row];
        
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  %@", book.year, book.author.fullName];
    cell.imageView.image = [UIImage imageNamed:book.author.lastName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.books removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self saveReadingList];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Book *book = self.books[sourceIndexPath.row];
    [self.books removeObjectAtIndex:sourceIndexPath.row];
    [self.books insertObject:book atIndex:destinationIndexPath.row];
    [self saveReadingList];
}

@end
