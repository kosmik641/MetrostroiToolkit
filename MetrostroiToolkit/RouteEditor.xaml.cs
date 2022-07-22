using MetrostroiToolkit.Classes;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using NLua;
using System.IO;

namespace MetrostroiToolkit
{
    /// <summary>
    /// Логика взаимодействия для RouteEditor.xaml
    /// </summary>
    public partial class RouteEditor : Window
    {
        public ObservableCollection<Station> stationList = new ObservableCollection<Station>();
        Lua gLua = new Lua();

        public RouteEditor()
        {
            InitializeComponent();

            gLua.State.Encoding = Encoding.UTF8;
            gLua.DoFile("Lua/metrostroi.lua");

            bool metroLoaded = (bool)gLua["Metrostroi.Loaded"];
                
            //int MetrostroiVersion = (int)gLua["Metrostroi.Version"];
            //MessageBox.Show(MetrostroiVersion.ToString());

            // TODO: Перенести в биндинг
            Stations_LB.ItemsSource = stationList;
        }

        // Menu items
        private void MenuOpenFile_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog fileDialog = new OpenFileDialog()
            {
                Filter = "Lua (.lua)|*.lua"
            };
            if (fileDialog.ShowDialog() == false)
                return;

            string luaToRun = "require(\"" + fileDialog.FileName.Replace("\\","\\\\") + "\")";
            try
            {
                gLua.DoString(luaToRun);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(),"Lua error");
            }
            //gLua.Globals.ToList();
            var fileLines = gLua["Metrostroi.ASNPSetup"];
            Console.WriteLine("HERE");

            //using (Lua lua = new Lua())
            //{
            //    lua.State.Encoding = Encoding.UTF8;
            //    lua.DoFile(luaFile);
            //    var fileLines = (NLua.LuaTable)gLua["Metrostroi.ASNPSetup"];
            //    Console.WriteLine("HERE");
            //}
        }

        private void AddStation(object sender, RoutedEventArgs e)
        {
            Station stationItem = new Station();

            stationItem.ID = stationList.Count + 100;
            stationItem.EditorName = "New station " + (stationList.Count + 1);
            stationList.Insert((Stations_LB.SelectedIndex == -1) ? 0 : (Stations_LB.SelectedIndex + 1), stationItem);
            Stations_LB.SelectedItem = stationItem;
        }

        private void DeleteStation(object sender, RoutedEventArgs e)
        {
            stationList.RemoveAt(Stations_LB.SelectedIndex);
        }

        private void StationID_TB_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^1-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }

        private void UnfocusToList(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
                Stations_LB.Focus();
        }
    }
}
