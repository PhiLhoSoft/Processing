final byte find = (byte) 'A';
final byte replace = (byte) 'B';

final int minNameLength = 3;  // Change if needed
final int maxNameLength = 10; // Increase as needed

// These bytes are found to be stable before a name in the given file:
// the signature can break in another file!
final byte[] sigBefore =
{
  (byte) 0x01,
  (byte) 0x09,
  (byte) 0x07,
  (byte) 0x01,
  (byte) 0x01
};
final byte[] sigAfter  =
{
  (byte) 0x08,
  (byte) 0x8C,
  (byte) 0xFF,
  (byte) 0x00,
  (byte) 0x00
};

String currentName;

void setup()
{
  byte[] originalBytes = loadBytes("slices_t_A.vfb");
  byte[] alteredBytes = Arrays.copyOf(originalBytes, originalBytes.length);

  int maxPos = originalBytes.length - sigBefore.length - 1 - maxNameLength - sigAfter.length;

  for (int i = 0; i < maxPos; i++)
  {
    if (CheckSignature(originalBytes, i, sigBefore))
    {
      i += sigBefore.length + 1; // Skip the variable byte...
      if (originalBytes[i] == find)
      {
        int found = i;
        i += GetName(originalBytes, i, sigAfter);
        boolean bChange = i - found >= minNameLength;
        if (bChange)
        {
          alteredBytes[found] = replace;
        }
        println(hex(found) + " " + currentName + (bChange ? "" : " (skipped)"));
      }
    }
  }

  saveBytes("slices_t_B.vfb", alteredBytes);

  exit();
}

boolean CheckSignature(byte[] buffer, int offset, byte[] signature)
{
  for (int i = 0, o = offset; i < signature.length; i++, o++)
  {
    if (signature[i] != buffer[o])
      return false;
  }
  return true;
}

// Only for debug/verification purpose
int GetName(byte[] buffer, int offset, byte[] signature)
{
  int i = 0;
  StringBuilder name = new StringBuilder();
  while (i < maxNameLength)
  {
    if (buffer[offset + i] == signature[0])
    {
      if (CheckSignature(buffer, offset + i, signature))
      {
        // Found
        currentName = name.toString();
        return i;
      }
    }
    else
    {
      name.append((char) buffer[offset + i]);
    }
    i++;
  }
  currentName = "!!!";
  return 0;
}
