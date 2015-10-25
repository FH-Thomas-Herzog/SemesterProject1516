using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{
    public enum Operand
    {
        GT,
        LT,
        GE,
        LE,
        EQ
    }

    public abstract class BaseWhereBuilder<I, E> where E : IEntity<I>
    {
        protected object value;
        protected Operand operand;
        protected EntityBuilder<I, E> entityBuilder;

        public BaseWhereBuilder<I, E> WithEntityBuilder(EntityBuilder<I, E> entityBuilder)
        {
            Debug.Assert(entityBuilder != null, "Cannot use null entityBuilder");
            this.entityBuilder = entityBuilder;

            return this;
        }
        public BaseWhereBuilder<I, E> Eq(object value)
        {
            Debug.Assert(value != null, "Equality not possible with null value");

            this.value = value;
            this.operand = Operand.EQ;

            return this;
        }
        public BaseWhereBuilder<I, E> Lt(object value)
        {
            Debug.Assert(value != null, "Less than not possible with null value");

            this.value = value;
            this.operand = Operand.LT;

            return this;
        }
        public BaseWhereBuilder<I, E> Gt(object value)
        {
            Debug.Assert(value != null, "Greather than not possible with null value");

            this.value = value;
            this.operand = Operand.GT;

            return this;
        }
        public BaseWhereBuilder<I, E> Le(object value)
        {
            Debug.Assert(value != null, "Lower Equals not possible with null value");

            this.value = value;
            this.operand = Operand.LE;

            return this;
        }
        public BaseWhereBuilder<I, E> Ge(object value)
        {
            Debug.Assert(value != null, "Greather Equal not possible with null value");

            this.value = value;
            this.operand = Operand.GE;

            return this;
        }

        public string Build(string column, bool isFirst)
        {
            Debug.Assert(column != null, "Cannot build where part for null column");

            return new StringBuilder().Append((isFirst) ? " WHERE " : " AND ").Append(OperandToString(operand)).Append(" ").ToString();
        }

        public abstract string OperandToString(Operand operand);
    }
}
