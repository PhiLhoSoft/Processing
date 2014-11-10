// The code below implements the drop event listening/handling
// and the Drop class. For less clutter put it in a separate
// pde file/tab.

import java.awt.dnd.*;
import java.awt.datatransfer.*;

// Note: droptarget.setActive(false) to stop listening for drops,
// droptarget.isActive() to know the current status (true/false).
DropTarget droptarget = new DropTarget(this/*this PFrame*/, 
  new DropTargetAdapter() {
    public void drop(DropTargetDropEvent event) {
      event.acceptDrop(DnDConstants.ACTION_COPY);
      DataFlavor[] flavors = event.getCurrentDataFlavors();
      if (flavors.length == 0)
        error("unsupported data flavor/type");
      else {
        DataFlavor f = flavors[0];
        Object data = null;
        try { 
          data = event.getTransferable().getTransferData(f);
        }
        catch (Exception e) { 
          error(e.toString());
        }
        if (data != null)
          dropped(new Drop(event, f, data));
      }
      event.dropComplete(true);
    }
  
    void error(String what) {
      frame.setTitle("*A drop error occured (see console)");
      System.err.println("Drop error:\n" + what);
    }
  }
);


