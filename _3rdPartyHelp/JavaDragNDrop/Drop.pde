class Drop {
  int x, y;
  Object data;
  DataFlavor flavor;
  DropTargetDropEvent event;

  Drop(DropTargetDropEvent e, DataFlavor f, Object d) {
    event = e;
    flavor = f;
    data = d;
    x = e.getLocation().x;
    y = e.getLocation().y;
  }

  String text() {
    try {
      return (String)
        event.getTransferable()
          .getTransferData(DataFlavor.stringFlavor);
    }
    catch (Exception e) {
    }
    return null;
  }

  String richtext() {
    if (flavor.getMimeType().startsWith("text")) {
      Scanner s = data instanceof Reader ? new Scanner((Reader)data) :
      data instanceof InputStream ? new Scanner((InputStream)data) : null;
      s.useDelimiter("^\\s"); // alien hack to preserve whitespaces
      if (s != null) {
        StringBuilder buf = new StringBuilder(256);
        while (s.hasNext ())
          buf.append(s.next());
        return buf.toString();
      }
    }
    return null;
  }

  File[] files() {
    if (flavor.equals(DataFlavor.javaFileListFlavor)) {
      List list = (List) data;
      return list.toArray(new File[list.size()]);
    }
    return null;
  }

  String[] paths() {
    if (data instanceof URL)
    return new String[] { 
      ((URL)data).toString()
    };
    File[] f = files();
    if (f != null) {
      int i = f.length;
      String[] paths = new String[i];
      while (i-- > 0)
        paths[i] = f[i].getAbsolutePath();
      return paths;
    }
    return null;
  }

  PImage[] images() {
    // Single image
    if (flavor.equals(DataFlavor.imageFlavor))
    return new PImage[] { 
      new PImage((Image) data)
    };
    // Load from paths / urls.
    // TODO async loading? Skip files with non-image extension?
    List<PImage> images = new ArrayList<PImage>();
    PImage tmp = null;
    if (flavor.equals(DataFlavor.javaFileListFlavor)) {
      for (File f : (List) data)
        if (f.isFile() && f.exists() &&
          (tmp = loadImage(f.getAbsolutePath())) != null)
          images.add(tmp);
    }
    else {
      String[] paths = paths();
      if (paths != null)
        for (String path : paths)
          if ((tmp = loadImage(path)) != null)
            images.add(tmp);
    }
    return images.size() == 0 ? null :
    images.toArray(new PImage[images.size()]);
  }

  public String toString() { 
    return data.toString();
  }
}

