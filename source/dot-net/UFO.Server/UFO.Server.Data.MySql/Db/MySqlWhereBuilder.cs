using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Db
{
    public class MySqlWhereBuilder<I, E> : BaseWhereBuilder<I, E> where E : IEntity<I>
    {

        public override string OperandToString(Operand operand)
        {
            switch (operand)
            {
                case Operand.EQ:
                    return " = ";
                case Operand.LT:
                    return " < ";
                case Operand.GT:
                    return " > ";
                case Operand.LE:
                    return " <= ";
                case Operand.GE:
                    return " >= ";
                default:
                    throw new System.Exception(string.Format("Unknown operand '{0}' found", operand.ToString()));
            }
        }
    }
}
