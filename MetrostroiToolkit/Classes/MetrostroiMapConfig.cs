using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetrostroiToolkit.Classes
{
    internal class MetrostroiMapConfig
    {
        string MapName;
        string? PlatformMap;
        string? CurrentMap;

        List<LastStationTex>? LastStationTexList;
        List<PassSchemeTex>? PassSchemeTexList;
        List<string> TickerAdverts;
    }
}
