using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Wpf.Administration.Exception
{
    public class ViewException : System.Exception
    {
        public readonly string message;
        public readonly bool openDialog;
        public readonly System.Exception original;

        public ViewException(string message, bool openDialog, System.Exception original)
        {
            this.message = message;
            this.openDialog = openDialog;
            this.original = original;
        }
    }
}
