using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Resources;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Service.Api.Exception;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Commander.Wpf.Administration.Views.Util;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class PerformanceNotificationModel : BaseValidationViewModel, IDisposable
    {
        private string _Subject;
        private string _Content;

        private ICommand _SendCommand;

        private IMessageHandler messageHandler;
        private IPerformanceService performanceService;

        public PerformanceNotificationModel(IMessageHandler messageHandler) : base()
        {
            if (messageHandler == null)
            {
                throw new ArgumentException("Message handler must not be null");
            }
            this.messageHandler = messageHandler;
            performanceService = ServiceFactory.CreatePerformanceService();
            SendCommand = new RelayCommand(p => Send(p), p => IsViewModelValid);
        }

        public ICommand SendCommand
        {
            get { return _SendCommand; }
            private set { _SendCommand = value; FirePropertyChangedEvent(); }
        }


        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(255,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Subject
        {
            get { return _Subject; }
            set { _Subject = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(1024,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Content
        {
            get { return _Content; }
            set { _Content = value; FirePropertyChangedEvent(); }
        }

        private void Send(object data)
        {
            try
            {
                int count = performanceService.Notify(Subject, Content);
                messageHandler.ShowMessage(Resources.SuccessMessage, string.Format(Resources.EmailsSent, count));
            }
            catch (ServiceException e)
            {
                PerformanceErrorCode code = (PerformanceErrorCode)e.ErrorCode;
                if (code == PerformanceErrorCode.NOTIFICATION_ERROR)
                {
                    messageHandler.ShowErrorMessage(Service.Api.Properties.Resource.NOTIFICATION_ERROR);
                }
                else
                {
                    messageHandler.ShowErrorMessage(Resources.ErrorUnknwon + $" (ErrorCode={code})");
                }
            }
            catch (System.Exception e)
            {
                messageHandler.ShowErrorMessage(Resources.ErrorUnknwon + $" (error={e.Message}");
            }
        }

        public void Dispose()
        {
            ServiceFactory.DisposeService(performanceService);
        }
    }
}
