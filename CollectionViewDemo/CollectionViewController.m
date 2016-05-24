//
//  CollectionViewController.m
//  CollectionViewDemo
//
//  Created by Karma on 16/5/24.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "CollectionViewController.h"
#import "MYCollectionViewCell.h"
#import "MYHeadeViewrCollectionReusableView.h"
#import "MYFooterViewCollectionReusableView.h"

#define kMargin 10
@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifierHeader = @"MYHeaderCell";
static NSString * const reuseIdentifierFooter = @"MYFooterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"MYCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MYHeadeViewrCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MYFooterViewCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
    
    // Do any additional setup after loading the view.
    self.collectionView.allowsMultipleSelection=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return the number of items
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (MYCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    //获取点击的单元格
    MYCollectionViewCell *cell = (MYCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取点击的单元格
    MYCollectionViewCell *cell = (MYCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
}
#pragma mark <UICollectionViewDelegateFlowLayout>
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(120, 120);
    
    /*如何获得固定样式的margin
     1.获取屏幕大小
     2.减去margin
     3.除以个数
     */
    CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width;
    CGFloat cellWidth=(screenWidth -3*kMargin) *0.5;
    return CGSizeMake(cellWidth, cellWidth);
    
    
}
//【整体】边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);//分别为上、左、下、右
}
//设置Cell横向之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}
//设置Cell纵向之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}
#pragma mark -header and footer
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *supplementaryView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //设置header的属性
        MYHeadeViewrCollectionReusableView *view = (MYHeadeViewrCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        view.headLabel.text = [NSString stringWithFormat:@"这是header:%d",indexPath.section];
        supplementaryView = view;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        //设footer的属性
        MYFooterViewCollectionReusableView *view = (MYFooterViewCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
        view.footerLabel.text = [NSString stringWithFormat:@"这是Footer:%d",indexPath.section];
        supplementaryView = view;
    }
    return supplementaryView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 69);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 50);
}

@end
