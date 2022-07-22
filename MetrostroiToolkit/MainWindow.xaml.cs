using System.Windows;
using System.Diagnostics;
using System.Windows.Navigation;

namespace MetrostroiToolkit
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void OpenRouteEditor_Click(object sender, RoutedEventArgs e)
        {
            RouteEditor routeEditor = new RouteEditor();
            routeEditor.Show();
        }

        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            var processStartInfo = new ProcessStartInfo(e.Uri.AbsoluteUri);
            processStartInfo.UseShellExecute = true;
            Process.Start(processStartInfo);
            e.Handled = true;
        }
    }
}
