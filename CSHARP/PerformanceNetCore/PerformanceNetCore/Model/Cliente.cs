using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace PerformanceNetCore.Model
{
    [Table("ClienteNetCoreEF")]
    public class Cliente
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        public String nome { get; set; }

        public String endereco { get; set; }

        public String cpf { get; set; }

    }
}
