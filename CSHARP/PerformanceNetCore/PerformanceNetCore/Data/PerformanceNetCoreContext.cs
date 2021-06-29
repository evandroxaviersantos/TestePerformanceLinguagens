using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using PerformanceNetCore.Model;

namespace PerformanceNetCore.Data
{
    public class PerformanceNetCoreContext : DbContext
    {
        public PerformanceNetCoreContext (DbContextOptions<PerformanceNetCoreContext> options)
            : base(options)
        {
        }

        public DbSet<PerformanceNetCore.Model.Cliente> Cliente { get; set; }
    }
}
