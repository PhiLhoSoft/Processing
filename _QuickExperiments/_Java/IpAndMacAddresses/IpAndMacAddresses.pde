// https://forum.processing.org/topic/computer-sn

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;

void start()
{
  InetAddress ip;
  try 
  {
    ip = InetAddress.getLocalHost();
    println("Current IP address: " + ip.getHostAddress());

    NetworkInterface network = NetworkInterface.getByInetAddress(ip);

    byte[] mac = network.getHardwareAddress();

    print("Current MAC address: ");

    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < mac.length; i++) 
    {
      sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
    }
    println(sb.toString());
  } 
  catch (UnknownHostException e) 
  {
    e.printStackTrace();
  } 
  catch (SocketException e) 
  {
    e.printStackTrace();
  }
}

