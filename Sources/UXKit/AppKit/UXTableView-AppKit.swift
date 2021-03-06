//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa
      
  public typealias UXTableView          = NSTableView
  
  /**
   * This is the type of the view a tableview datasource is expected to return
   * (when creating a view for a row).
   *
   * On AppKit, this can be any view, but on UIKit, it *must* be a
   * UITableViewCell.
   *
   * Also note that on AppKit there is a `NSTableCellView`. This is *not* the
   * same like the `UITableViewCell`! The `NSTableCellView` doesn't create its
   * contents, but purely serves as an outlet holder for IB.
   *
   * To workaround that, we provide an own `NSTableViewCell` which tries to
   * mirror what `UITableViewCell` does.
   */
  public typealias UXTableViewCellType  = NSTableCellView // Yes!
  
  /**
   * A concrete view which you can use in a view datasource. It provides an
   * image, label, detail-label, and a set of different styles.
   *
   * On iOS, this is builtin via `UITableViewCell`, and on macOS we provide
   * an own class for that (`NSTableViewCell`).
   */
  public typealias UXTableViewCell      = NSTableViewCell // Yes! (own)
  
  public enum      UXTableViewCellStyle {
    // Hm. Not really used for now.
    case `default`
    case value1
    case value2
    case subtitle
  }

  public protocol UXTableViewCellInit : class {
    init(style: UXTableViewCellStyle, reuseIdentifier: String?)
    func prepareForReuse()
  }

  /// Map UIKit options to AppKit options
  public extension NSTableView.AnimationOptions {
    public static var fade   = effectFade
    public static var right  = slideRight
    public static var left   = slideLeft
    public static var top    = slideUp
    public static var bottom = slideDown
    public static var none   : NSTableView.AnimationOptions = []
    public static var middle = effectGap // TBD: is this the same?
    
    // TODO: automatic (make it depend on the modification operation)
    //       the 10.13 flags go till 0x40, so we could use a special raw
    public static var automatic = slideDown
  }

  public extension NSTableView {
    
    public func insertRows(at indexes : [ IndexPath ],
                           with ao    : NSTableView.AnimationOptions? = nil)
    {
      insertRows(at: IndexSet.setForRowsInPathes(indexes),
                 withAnimation: ao ?? []) // FIXME: rather .slideUp?
    }
    
    public func deleteRows(at indexes : [ IndexPath ],
                           with ao    : NSTableView.AnimationOptions? = nil)
    {
      removeRows(at: IndexSet.setForRowsInPathes(indexes),
                 withAnimation: ao ?? []) // FIXME: rather .slideDown?
    }
    
    public func reloadRows(at indexes : [ IndexPath ],
                           with ao    : NSTableView.AnimationOptions? = nil)
    {
      // Note: no animation support
      reloadData(forRowIndexes: IndexSet.setForRowsInPathes(indexes),
                 columnIndexes: IndexSet(integer: 0))
    }
  }
#endif
