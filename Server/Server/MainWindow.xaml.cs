using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Server
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        private TcpListener myListener;
        private TcpClient newClient;
        public BinaryReader br;
        public BinaryWriter bw;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            Thread myThread = new Thread(ServerA);
            myThread.Start();
        }

        private void ServerA()
        {
            IPAddress ip = IPAddress.Parse("127.0.0.1");//服务器端ip
            myListener = new TcpListener(ip, 7890);//创建TcpListener实例
            myListener.Start();//start
            newClient = myListener.AcceptTcpClient();//等待客户端连接
            label.Dispatcher.Invoke(() => label.Content = "连接成功");
            while (true)
            {
                try
                {
                    NetworkStream clientStream = newClient.GetStream();//利用TcpClient对象GetStream方法得到网络流
                    br = new BinaryReader(clientStream);
                    string receive = null;
                    receive = br.ReadString();//读取
                    textBox.Dispatcher.Invoke(() => textBox.Text += receive + "\r\n");
                }
                catch
                {
                    MessageBox.Show("接收失败！");
                }
            }
        }
        //发送消息
        private void send_Click(object sender, RoutedEventArgs e)
        {
            //利用TcpClient对象GetStream方法得到网络流
            NetworkStream clientStream = newClient.GetStream();
            bw = new BinaryWriter(clientStream);
            //写入
            bw.Write(message.Text);
            textBox.Text += message.Text + "\r\n";
        }
    }
}