using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Media3D;

namespace MetrostroiToolkit.Classes
{
    public class Station : INotifyPropertyChanged
    {
        string name;
        int id;

        public string ListName
        {
            get { return id.ToString() + ") " + name; }
        }

        public string EditorName
        {
            get { return name; }
            set
            {
                if (value != "" && name != value)
                {
                    name = value;
                    NotifyPropertyChanged("ListName");
                }
            }
        }

        public int ID
        {
            get { return id; }
            set
            {
                if (id != value)
                {
                    id = value;
                    NotifyPropertyChanged("ListName");
                }
            }
        }
        

        void NotifyPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
        public event PropertyChangedEventHandler PropertyChanged;
    }

    //internal class StationConfiguration
    //{

    //    string ID;
    //    ObservableCollection<string> Names = new ObservableCollection<string>();
    //    ObservableCollection<StationPosition> Positions = new ObservableCollection<StationPosition>();
    //}

    //class StationPosition
    //{
    //    Vector3D Position;
    //    Angle ViewAngle;
    //}

    //internal class Angle
    //{
    //    int x;
    //    int y;
    //    int z;
    //}
}
