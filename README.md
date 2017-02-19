# EditDistance
EditDistance is one of the incremental update tool for UITableView and UICollectionView.

# What's this?
It is so difficult to update UITableView or UICollectionView incrementally. Developers need to manage diff between two arrays and update UITableView incrementally.

Typical code:
```swift
var dataSource = ["Francis Elton", "Stanton Denholm", "Arledge Camden", "Farland Ridley", "Alex Helton"]

// insertion and deletion to data source
dataSource.remove(at: 2)
dataSource.insert("Woodruff Chester", at: 1)
dataSource.insert("Eduard Colby", at: 3)

// You have to update UITableView according to array's diff.
tableView.beginUpdates()
tableView.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
tableView.insertRows(at: [IndexPath(row: 1, section: 0), IndexPath(row: 3, section: 0)], with: .fade)
tableView.endUpdates()
```

EditDistance takes on that maginging work. All you need is to make updated array.

```swift
var dataSource = ["Francis Elton", "Stanton Denholm", "Arledge Camden", "Farland Ridley", "Alex Helton"]
var nextDataSource = dataSource

// insertion and deletion to data source
nextDataSource.remove(at: 2)
nextDataSource.insert("Woodruff Chester", at: 1)
nextDataSource.insert("Eduard Colby", at: 3)

// You don't need to write insertion and deletion.
let scripts = dataSource.diff.compare(with: nextDataSource)
dataSource = nextDataSource
tableView.diff.reload(with: scripts) 

```

That enables to pileline the incremental update. You don't have to take into account Diff between DataSource and UI.

# How dose it work?

The following examples show how this library update UI. They generate random elements for data source and update incrementally.

| UITableView | UICollectionView |
|---|---|
| ![tableview](https://cloud.githubusercontent.com/assets/18320004/23104148/adbfb22c-f70b-11e6-80bc-97fb1bac7bbc.gif)  | ![collectionview 1](https://cloud.githubusercontent.com/assets/18320004/23104147/ab1a6d00-f70b-11e6-921b-e328153306fd.gif)  |

# Feature
- [x] You don't need to calculate diff manually.
- [x] You can choose any diff algorithm as you like.
- [x] You don't need to call [reloadRows(at:with:)](https://developer.apple.com/reference/uikit/uitableview/1614935-reloadrows) and [performBatchUpdates(_:completion:)](https://developer.apple.com/reference/uikit/uicollectionview/1618045-performbatchupdates) anymore.
- [x] minimum implimentation for incremental update

# Requirements
- iOS 8.0+
- Xcode 8.1+
- Swift 3.0+

# Installation

### Carthage

+ Install Carthage from Homebrew
```
> ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
> brew update
> brew install carthage
```
+ Move your project dir and create Cartfile
```
> touch Cartfile
```
+ add the following line to Cartfile
```
github "kazuhiro4949/EditDistance"
```
+ Create framework
```
> carthage update --platform iOS
```

+ In Xcode, move to "Genera > Build Phase > Linked Frameworks and Library"
+ Add the framework to your project
+ Add a new run script and put the following code
```
/usr/local/bin/carthage copy-frameworks
```
+ Click "+" at Input file and Add the framework path
```
$(SRCROOT)/Carthage/Build/iOS/EditDistance.framework
```
+ Write Import statement on your source file
```
Import EditDistance
```

# Usage
## 1 Calculate Diff between two arrays
```swift
let nextDataSource = ["Francis Elton", "Woodruff Chester", "Stanton Denholm", "Eduard Colby, "Farland Ridley", "Alex Helton"]
let script = dataSource.diff.compare(with: nextDataSource)
```

## 2. update DataSource and UI
```swift
dataSource = nextDataSource
tableView.diff.reload(with: scripts) 
```

That's it!
