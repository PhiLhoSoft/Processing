public enum TestEnum
{
  Number1(1, new String[] { "ichi", "one", "un", "uno" }, false),
  Number2(2, new String[] { "ni", "two", "deux", "dos" }, true),
  Number3(3, new String[] { "san", "three", "trois", "tres" }, false),
  Number4(4, new String[] { "shi", "four", "quatre", "quatro" }, true);

  private final int m_value;
  private final String[] m_names;
  private final boolean m_bEven;

  TestEnum(int value, String[] names, boolean bEven)
  {
    m_value = value;
    m_names = names;
    m_bEven = bEven;
  }

  String[] GetNames()
  {
    return m_names;
  }

  static String GetNameList()
  {
    if (m_names == null || m_names.length == 0)
      return "";
    StringBuilder names = new StringBuilder();
    for (String name : m_names)
    {
      names.append(name).append(", ");
    }
    return names.delete(names.length() - 2, names.length() - 1).toString();
  }

  int GetValue()
  {
    return m_value;
  }

  boolean IsEven()
  {
    return m_bEven;
  }

  // Test function
  public static void main(String[] args)
  {
    for (TestEnum ev : TestEnum.values())
    {
      System.out.printf("Enumeration: %s (%s) = %d -> '%s'\n",
          ev, ev.name(), ev.ordinal(), TestEnum.valueOf(ev.name()));
      System.out.printf("             %s (%b) = %d\n",
          ev.GetNameList(), ev.IsEven(), ev.GetValue());
    }
  }
}
