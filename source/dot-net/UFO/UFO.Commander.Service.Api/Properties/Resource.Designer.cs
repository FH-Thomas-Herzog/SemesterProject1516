﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace UFO.Commander.Service.Api.Properties {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    public class Resource {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resource() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("UFO.Commander.Service.Api.Properties.Resource", typeof(Resource).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Der Artist hat bereits eine Führung zu diesem Zeitpunkt oder die einzuhaltende Pause  zwischen den Aufführungen wurde unterschritten.
        /// </summary>
        public static string ARTIST_OVERBOOKED {
            get {
                return ResourceManager.GetString("ARTIST_OVERBOOKED", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Folgende Auflistung zeigt Ihre angelegten/geänderten Vorstellungen..
        /// </summary>
        public static string Email_NotifyChange_Content {
            get {
                return ResourceManager.GetString("Email_NotifyChange_Content", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Prgammänderungen !!!!!.
        /// </summary>
        public static string Email_NotifyChange_Subject {
            get {
                return ResourceManager.GetString("Email_NotifyChange_Subject", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Das Versenden der E-Mails ist fehlgeschlagen.
        /// </summary>
        public static string NOTIFICATION_ERROR {
            get {
                return ResourceManager.GetString("NOTIFICATION_ERROR", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Die Aufführung wurde bereits gestartet.
        /// </summary>
        public static string PERFORMANCE_ALREADY_STARTED {
            get {
                return ResourceManager.GetString("PERFORMANCE_ALREADY_STARTED", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Das Aufführungsdatum ist ungültig.
        /// </summary>
        public static string PERFORMANCE_DATE_INVALID {
            get {
                return ResourceManager.GetString("PERFORMANCE_DATE_INVALID", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Auf dieser Spilstätte findet bereits eine Aufführung statt.
        /// </summary>
        public static string VENUE_OVERBOOKED {
            get {
                return ResourceManager.GetString("VENUE_OVERBOOKED", resourceCulture);
            }
        }
    }
}
