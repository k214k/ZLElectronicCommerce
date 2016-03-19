//
//  XYGridCollectionViewFlowLayout.m
//  ZLElectronicCommerce
//
//  Created by zhangliang on 16/3/5.
//  Copyright © 2016年 zhangl. All rights reserved.
//

#import "XYGridCollectionViewFlowLayout.h"
static NSString * const CALAgendaMonthCollectionViewLayoutCell = @"CALAgendaMonthCollectionViewLayoutCell";
@interface XYGridCollectionViewFlowLayout ()
KPropertyStrong NSDictionary *layoutInfo;
@end
@implementation XYGridCollectionViewFlowLayout
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        CGFloat itemWidth = floorf((kScreenWidth-10)/ 5);
        CGFloat itemHeight = itemWidth;
        self.sectionInset = UIEdgeInsetsMake(0,5,0,0);
        self.itemSize = CGSizeMake(itemWidth, itemHeight);
        self.minimumLineSpacing = 0.;
        self.minimumInteritemSpacing = 0.;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

#pragma mark - Layout

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath;
    CGRect previousRect = CGRectZero;
    NSIndexPath *previousIndexPath;
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForItemAtIndexPath:indexPath previousRect:previousRect previousIndexPath:previousIndexPath];
            previousRect = itemAttributes.frame;
            cellLayoutInfo[indexPath] = itemAttributes;
            previousIndexPath = indexPath;
        }
    }
    newLayoutInfo[CALAgendaMonthCollectionViewLayoutCell] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}
- (CGSize)collectionViewContentSize
{
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //compute the worst case
        NSInteger numOfSections = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
        NSIndexPath *lastHeaderIndexPath = [NSIndexPath indexPathForRow:0 inSection:numOfSections-1];
        UICollectionViewLayoutAttributes *lastLayoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:lastHeaderIndexPath];
        CGSize contentSize = CGSizeMake(CGRectGetMaxX(lastLayoutAttributes.frame),CGRectGetMaxY(lastLayoutAttributes.frame) + 6*self.itemSize.height);
        return contentSize;
    }
    else {
        //compute the worst case
        //NSInteger numOfSections = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
        //CGSize contentSize = CGSizeMake(kScreenWidth, self.headerReferenceSize.height + 6*self.itemSize.height + 7*self.minimumLineSpacing);
        CGSize contentSize = CGSizeMake(kScreenWidth, self.headerReferenceSize.height + 2*self.itemSize.height + 1*self.minimumLineSpacing);
        //JMOLog(@"COntent size -> %@", NSStringFromCGSize(contentSize));
        return contentSize;
    }
}
#pragma mark - Cells Layout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[CALAgendaMonthCollectionViewLayoutCell][indexPath];
}


- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath previousRect:(CGRect)previousRect previousIndexPath:(NSIndexPath*)previousIndexPath
{
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        if (CGRectEqualToRect(CGRectZero, previousRect)) {
            return CGRectMake(0.0f, self.headerReferenceSize.height + self.minimumLineSpacing, self.itemSize.width, self.itemSize.height);
        }
        else {
            CGRect theoricalRect = previousRect;
            theoricalRect.origin.x = theoricalRect.origin.x + self.minimumInteritemSpacing + self.itemSize.width;
            if ((indexPath.section - previousIndexPath.section) > 0) {
                theoricalRect.origin.y = theoricalRect.origin.y + self.itemSize.height + self.headerReferenceSize.height + self.minimumLineSpacing;
                theoricalRect.origin.x = 0.0f;
            }else if ((theoricalRect.origin.x + self.itemSize.width) > self.collectionView.frame.size.width) {
                theoricalRect.origin.x = 0.0f;
                theoricalRect.origin.y = theoricalRect.origin.y + self.minimumLineSpacing + self.itemSize.height;
            }
            return theoricalRect;
        }
    }
    else {
        if (CGRectEqualToRect(CGRectZero, previousRect)) {
            return CGRectMake(0.0f, self.headerReferenceSize.height + self.minimumLineSpacing, self.itemSize.width, self.itemSize.height);
        }
        else {
            CGRect theoricalRect = previousRect;
            theoricalRect.origin.x = theoricalRect.origin.x + self.minimumInteritemSpacing + self.itemSize.width;
            if ((theoricalRect.origin.x + self.itemSize.width) > self.collectionView.frame.size.width * (indexPath.section+1)) {
                theoricalRect.origin.x =  self.collectionView.frame.size.width * indexPath.section;
                theoricalRect.origin.y = theoricalRect.origin.y + self.minimumLineSpacing + self.itemSize.height;
            }
            if ((indexPath.section - previousIndexPath.section) > 0) {
                theoricalRect.origin.x = self.collectionView.frame.size.width * indexPath.section;
                theoricalRect.origin.y = self.headerReferenceSize.height + self.minimumLineSpacing;
            }
            return theoricalRect;
        }
    }
    
    return CGRectZero;
}
@end
