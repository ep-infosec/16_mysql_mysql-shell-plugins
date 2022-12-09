/*
 * Copyright (c) 2021, Oracle and/or its affiliates.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License, version 2.0,
 * as published by the Free Software Foundation.
 *
 * This program is also distributed with certain software (including
 * but not limited to OpenSSL) that is licensed under separate terms, as
 * designated in a particular file or component or in included license
 * documentation.  The authors of MySQL hereby grant you an additional
 * permission to link the program and your derivative works with the
 * separately licensed software that they have included with MySQL.
 * This program is distributed in the hope that it will be useful,  but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
 * the GNU General Public License, version 2.0, for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
 */

import Foundation
import Cocoa
import WebKit;

class DragTargetWebView: WKWebView {

  public var appDelegate: AppDelegate?;

  //--------------------------------------------------------------------------------------------------------------------

  override func awakeFromNib() -> Void {
    // No need to register file URLs in for dragging. This is done already by the web view.
  }

  //--------------------------------------------------------------------------------------------------------------------

  override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
    return NSDragOperation.move;
  }

  //--------------------------------------------------------------------------------------------------------------------

  override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {

    let pasteBoard = sender.draggingPasteboard;
    if pasteBoard.availableType(from: [NSPasteboard.PasteboardType.fileURL]) != nil {
      if let urls = pasteBoard.readObjects(forClasses: [NSURL.self]) as? [URL] {
        if (urls.count == 1 && isValidSqliteFile(url: urls[0])) {
          let url = urls[0].path.removingPercentEncoding!;
          appDelegate?.sendAppMessage(command: "dbFileDropped", data: [url]);

          return true;
        } else {

          return false;
        }
      }
    }

    return super.performDragOperation(sender);
  }

  //--------------------------------------------------------------------------------------------------------------------

  func isValidSqliteFile(url: URL) -> Bool {
    if (!url.isFileURL) {
      return false;
    }

    if (url.pathExtension != "sqlite3") {
      return false;
    }

    return true;
  }

  //--------------------------------------------------------------------------------------------------------------------

}
