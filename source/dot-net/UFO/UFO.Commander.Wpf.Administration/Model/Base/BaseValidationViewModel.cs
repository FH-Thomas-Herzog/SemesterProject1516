using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection;
using UFO.Commander.Wpf.Administration.Model.Base;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    /// <summary>
    /// A base classe for ViewModel classes which supports validation using IDataErrorInfo interface. Properties must defines
    /// validation rules by using validation attributes defined in System.ComponentModel.DataAnnotations.
    /// </summary>
    public class BaseValidationViewModel : BasePropertyChangeModel, IDataErrorInfo
    {
        private readonly Dictionary<string, Func<BaseValidationViewModel, object>> propertyGetters;
        private readonly Dictionary<string, ValidationAttribute[]> validators;
        private readonly IDictionary<string, bool> validPropertiesMap;

        private bool _IsViewModelValid = false;

        public BaseValidationViewModel()
        {
            validators = this.GetType()
                .GetProperties()
                .Where(p => this.GetValidations(p).Length != 0)
                .ToDictionary(p => p.Name, p => this.GetValidations(p));

            propertyGetters = this.GetType()
                .GetProperties()
                .Where(p => this.GetValidations(p).Length != 0)
                .ToDictionary(p => p.Name, p => this.GetValueGetter(p));

            validPropertiesMap = GetType()
                .GetProperties()
                .Where(p => this.GetValidations(p).Length != 0)
                .ToDictionary(p => p.Name, p => false);
        }

        public bool IsViewModelValid
        {
            get
            {
                return _IsViewModelValid;
            }
            set
            {
                _IsViewModelValid = value;
                FirePropertyChangedEvent();
            }
        }

        /// <summary>
        /// Gets the error message for the property with the given name.
        /// </summary>
        /// <param name="propertyName">Name of the property</param>
        public string this[string propertyName]
        {
            get
            {
                if (this.propertyGetters.ContainsKey(propertyName))
                {
                    var propertyValue = this.propertyGetters[propertyName](this);
                    var errorMessages = this.validators[propertyName]
                        .Where(v => !v.IsValid(propertyValue))
                        .Select(v => v.FormatErrorMessage(v.ErrorMessageResourceName)).ToArray();

                    validPropertiesMap[propertyName] = errorMessages.Count() == 0;
                    IsAllValid();

                    return string.Join(Environment.NewLine, errorMessages);
                }

                return string.Empty;
            }
        }

        /// <summary>
        /// Gets an error message indicating what is wrong with this object.
        /// </summary>
        public string Error
        {
            get
            {
                var errors = from validator in this.validators
                             from attribute in validator.Value
                             where !attribute.IsValid(this.propertyGetters[validator.Key](this))
                             select attribute.ErrorMessage;

                return string.Join(Environment.NewLine, errors.ToArray());
            }
        }

        private ValidationAttribute[] GetValidations(PropertyInfo property)
        {
            return (ValidationAttribute[])property.GetCustomAttributes(typeof(ValidationAttribute), true);
        }

        private Func<BaseValidationViewModel, object> GetValueGetter(PropertyInfo property)
        {
            return new Func<BaseValidationViewModel, object>(viewmodel => property.GetValue(viewmodel, null));
        }

        private void IsAllValid()
        {
            bool result = true;
            foreach (var entry in validPropertiesMap)
            {
                if (!entry.Value)
                {
                    result = false;
                    break;
                }
            }
            IsViewModelValid = result;
        }
    }
}
