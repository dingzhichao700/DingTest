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

namespace Client
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        private TcpClient client;
        public BinaryReader br;
        public BinaryWriter bw;
        public MainWindow()
        {
            InitializeComponent();
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {

            Thread myThread = new Thread(ClientA);
            myThread.Start();
        }

        private void ClientA()
        {
            //通过服务器的ip和端口号，创建TcpClient实例
            client = new TcpClient("127.0.0.1", 7890);
            label.Dispatcher.Invoke(() => label.Content = "与服务器连接成功");
            while (true)
            {
                try
                {
                    NetworkStream clientStream = client.GetStream();
                    br = new BinaryReader(clientStream);
                    string receive = null;

                    receive = br.ReadString();
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
            NetworkStream clientStream = client.GetStream();
            bw = new BinaryWriter(clientStream);
            bw.Write(message.Text);
            textBox.Text += message.Text + "\r\n";
        }
    }
}